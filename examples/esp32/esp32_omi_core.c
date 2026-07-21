#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include <string.h>

#define OMI_SEGMENT_COUNT 8u
#define OMI_COBS_BUFFER_SIZE 64u
#define OMI_FIXED_CENTROID_ADDR 0x0000u

typedef enum {
    EAL_OK = 0,
    EAL_ERROR_FRAME_TRUNCATED,
    EAL_ERROR_ZERO_LEAK,
    EAL_ERROR_BAND_BREACH,
    EAL_ERROR_QUADRATIC_MISMATCH
} eal_status;

typedef struct {
    uint16_t segments[OMI_SEGMENT_COUNT];
} OmiAddress128;

typedef struct {
    char subject[16];
    char predicate[16];
    char object[16];
    char ontology[16];
    char epistemology[16];
} LambdaCanonBlock;

typedef struct {
    uint16_t x_omi;
    uint16_t y_imo;
    uint32_t parabolic_evaluation;
    uint8_t  active_surface_band;
    bool     is_centroid;
} ReconciledEngineState;

static size_t esp32_cobs_decode_bounded(const uint8_t *src,
                                        size_t src_len,
                                        uint8_t *dst,
                                        size_t dst_cap,
                                        eal_status *out_status) {
    size_t src_idx = 0;
    size_t dst_idx = 0;
    if (out_status != NULL) *out_status = EAL_OK;

    while (src_idx < src_len) {
        uint8_t code = src[src_idx++];
        if (code == 0x00u) {
            if (out_status != NULL) *out_status = EAL_ERROR_ZERO_LEAK;
            return 0;
        }

        for (uint8_t i = 1u; i < code; i++) {
            if (src_idx >= src_len || dst_idx >= dst_cap) {
                if (out_status != NULL) *out_status = EAL_ERROR_FRAME_TRUNCATED;
                return 0;
            }
            dst[dst_idx++] = src[src_idx++];
        }

        if (code < 0xFFu && src_idx < src_len) {
            if (dst_idx >= dst_cap) {
                if (out_status != NULL) *out_status = EAL_ERROR_FRAME_TRUNCATED;
                return 0;
            }
            dst[dst_idx++] = 0x00u;
        }
    }

    return dst_idx;
}

static uint32_t esp32_evaluate_parabolic_form(uint16_t x, uint16_t y) {
    uint32_t linear_root = ((uint32_t)x << 2) + ((uint32_t)y << 1);
    return linear_root * linear_root;
}

static int esp32_hex_value(char c) {
    if (c >= '0' && c <= '9') return c - '0';
    if (c >= 'a' && c <= 'f') return 10 + (c - 'a');
    if (c >= 'A' && c <= 'F') return 10 + (c - 'A');
    return -1;
}

static bool esp32_parse_hex_segment(const char *text, uint16_t *out) {
    uint16_t value = 0;
    for (uint32_t i = 0; i < 4u; i++) {
        int nibble = esp32_hex_value(text[i]);
        if (nibble < 0) return false;
        value = (uint16_t)((value << 4) | (uint16_t)nibble);
    }
    *out = value;
    return true;
}

static bool esp32_parse_hex_frame(const char *hex_str, OmiAddress128 *out_addr) {
    if (hex_str == NULL || out_addr == NULL) return false;
    if (strlen(hex_str) != 39u) return false;

    for (uint32_t i = 0; i < OMI_SEGMENT_COUNT; i++) {
        uint32_t offset = i * 5u;
        if (!esp32_parse_hex_segment(&hex_str[offset], &out_addr->segments[i])) return false;
        if (i < OMI_SEGMENT_COUNT - 1u && hex_str[offset + 4u] != '-') return false;
    }
    return true;
}

static eal_status esp32_reconcile_interface(const OmiAddress128 *addr,
                                            uint8_t mux_token,
                                            ReconciledEngineState *out_state) {
    if (addr == NULL || out_state == NULL) return EAL_ERROR_FRAME_TRUNCATED;

    out_state->x_omi = addr->segments[0];
    out_state->y_imo = addr->segments[1];

    if (mux_token <= 0x20u) {
        out_state->active_surface_band = 0;
    } else if (mux_token <= 0x40u) {
        out_state->active_surface_band = 1;
    } else if (mux_token <= 0x60u) {
        out_state->active_surface_band = 2;
    } else if (mux_token <= 0x7Fu) {
        out_state->active_surface_band = 3;
    } else {
        return EAL_ERROR_BAND_BREACH;
    }

    out_state->parabolic_evaluation =
        esp32_evaluate_parabolic_form(out_state->x_omi, out_state->y_imo);
    out_state->is_centroid =
        (out_state->x_omi == OMI_FIXED_CENTROID_ADDR) &&
        (out_state->y_imo == OMI_FIXED_CENTROID_ADDR) &&
        (out_state->parabolic_evaluation == 0u);

    return EAL_OK;
}

#ifdef OMI_ESP32_EMULATED_MAIN
static void app_main_emulated(void) {
    const char *mock_address = "0000-0000-0000-0000-0000-0000-0000-0000";
    uint8_t mux_token = 0x1Bu;
    OmiAddress128 frame;
    ReconciledEngineState state;

    printf("--- ESP32 PLATFORM-AGNOSTIC OMI-IMO ENGINE START ---\n");
    if (!esp32_parse_hex_frame(mock_address, &frame)) {
        printf("Error: inbound address frame failed structural parsing.\n");
        return;
    }
    eal_status code = esp32_reconcile_interface(&frame, mux_token, &state);
    if (code != EAL_OK) {
        printf("Rejection fault: %d\n", code);
        return;
    }

    printf("Reconciliation Vector Resolved Successfully:\n");
    printf("  Active Character Surface : Band %u\n", state.active_surface_band);
    printf("  Parabolic Evaluation Q   : %u\n", state.parabolic_evaluation);
    printf("  System Centroid Status   : %s\n",
           state.is_centroid ? "ACTIVE NULL.NULL CORE" : "DEVIATED PLANE");
}

int main(void) {
    app_main_emulated();
    return 0;
}
#endif
