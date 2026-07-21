#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include <string.h>

#define OMI_BOOT_ENVELOPE_SIZE 64u
#define OMI_BOOT_PREFIX_HALF_SIZE 32u
#define OMI_BOOT_SHEBANG_SIZE 8u
#define OMI_BOOT_FIELD_X_LIMIT 240u
#define OMI_BOOT_FACE_COUNT 4u

typedef enum {
    BOOT_OK = 0,
    BOOT_ERROR_GAUGE_MISMATCH,
    BOOT_ERROR_BQF_OUT_OF_BOUNDS,
    BOOT_ERROR_SECURE_REJECTION,
    BOOT_ERROR_INVALID_ARGUMENT
} omi_boot_status;

typedef enum {
    OMI_BOOT_FACE_BOOT0 = 0,
    OMI_BOOT_FACE_BOOT1 = 1,
    OMI_BOOT_FACE_SECURE = 2,
    OMI_BOOT_FACE_USER = 3
} omi_boot_face;

typedef struct {
    uint16_t active_scopes[4];
    uint16_t carrier_scopes[4];
    uint32_t register_flags;
    uint32_t stack_context;
    uint32_t car_pointer;
    uint32_t cdr_pointer;
} OmiBootstrapFrame;

typedef struct {
    uint32_t address_energy_bqf;
    uint8_t  active_incidence_face;
    bool     is_centroid_core;
} OmiBootResolution;

static const uint8_t OMI_BOOT_GAUGE_PREHEADER[OMI_BOOT_SHEBANG_SIZE] = {
    0xFFu, 0x00u, 0x1Cu, 0x1Du, 0x1Eu, 0x1Fu, 0x20u, 0xFFu
};

static uint16_t omi_boot_read_u16_be(const uint8_t *src) {
    return (uint16_t)(((uint16_t)src[0] << 8) | (uint16_t)src[1]);
}

static uint32_t omi_boot_read_u32_be(const uint8_t *src) {
    return ((uint32_t)src[0] << 24) |
           ((uint32_t)src[1] << 16) |
           ((uint32_t)src[2] << 8) |
           (uint32_t)src[3];
}

static inline uint32_t omi_boot_calculate_bqf(uint32_t x, uint32_t y) {
    return (60u * x * x) + (16u * x * y) + (4u * y * y);
}

static omi_boot_status omi_boot_envelope_parse(const uint8_t *envelope_buf,
                                               size_t envelope_len,
                                               OmiBootstrapFrame *out_frame) {
    if (envelope_buf == NULL || out_frame == NULL ||
        envelope_len != OMI_BOOT_ENVELOPE_SIZE) {
        return BOOT_ERROR_INVALID_ARGUMENT;
    }

    if (memcmp(envelope_buf, OMI_BOOT_GAUGE_PREHEADER, OMI_BOOT_SHEBANG_SIZE) != 0) {
        return BOOT_ERROR_GAUGE_MISMATCH;
    }

    const uint8_t *bootstrap = &envelope_buf[OMI_BOOT_PREFIX_HALF_SIZE];
    for (uint32_t i = 0u; i < 4u; i++) {
        out_frame->active_scopes[i] = omi_boot_read_u16_be(&bootstrap[i * 2u]);
        out_frame->carrier_scopes[i] = omi_boot_read_u16_be(&bootstrap[8u + (i * 2u)]);
    }

    out_frame->register_flags = omi_boot_read_u32_be(&bootstrap[16]);
    out_frame->stack_context = omi_boot_read_u32_be(&bootstrap[20]);
    out_frame->car_pointer = omi_boot_read_u32_be(&bootstrap[24]);
    out_frame->cdr_pointer = omi_boot_read_u32_be(&bootstrap[28]);

    return BOOT_OK;
}

static omi_boot_status omi_boot_resolve_candidate(uint8_t incidence_face,
                                                  uint32_t x,
                                                  uint32_t y,
                                                  bool secure_receipt,
                                                  OmiBootResolution *out_res) {
    if (out_res == NULL) return BOOT_ERROR_INVALID_ARGUMENT;
    if (incidence_face >= OMI_BOOT_FACE_COUNT || x >= OMI_BOOT_FIELD_X_LIMIT ||
        y >= OMI_BOOT_FACE_COUNT) {
        return BOOT_ERROR_BQF_OUT_OF_BOUNDS;
    }

    out_res->address_energy_bqf = omi_boot_calculate_bqf(x, y);
    out_res->active_incidence_face = incidence_face;
    out_res->is_centroid_core = (x == 0u && y == 0u);

    if (!secure_receipt) return BOOT_ERROR_SECURE_REJECTION;
    return BOOT_OK;
}

#ifdef OMI_BOOT_EMULATED_MAIN
static void app_main_boot_test(void) {
    uint8_t envelope[OMI_BOOT_ENVELOPE_SIZE];
    OmiBootstrapFrame frame;
    OmiBootResolution res;

    memset(envelope, 0, sizeof(envelope));
    memcpy(envelope, OMI_BOOT_GAUGE_PREHEADER, OMI_BOOT_SHEBANG_SIZE);
    envelope[0x20] = 0x05u;

    printf("--- OMINO HARDWARE CORE: FLASH BOOTSTRAP RESOLVER ENGINE ---\n");
    if (omi_boot_envelope_parse(envelope, sizeof(envelope), &frame) == BOOT_OK) {
        printf("Extracted Active FS (S0): 0x%04X\n", frame.active_scopes[0]);
    }
    if (omi_boot_resolve_candidate(OMI_BOOT_FACE_BOOT0, 15u, 0u, true, &res) == BOOT_OK) {
        printf("Resolved BQF Position Vector Energy Q(15,0) = %u Units\n",
               res.address_energy_bqf);
    }
}

int main(void) {
    app_main_boot_test();
    return 0;
}
#endif
