#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include <string.h>
#include "../../examples/esp32/omi_boot_envelope.c"

static int fail(const char *message) {
    fprintf(stderr, "boot envelope conformance failed: %s\n", message);
    return 1;
}

static void put_u16_be(uint8_t *dst, uint16_t value) {
    dst[0] = (uint8_t)((value >> 8) & 0xFFu);
    dst[1] = (uint8_t)(value & 0xFFu);
}

static void put_u32_be(uint8_t *dst, uint32_t value) {
    dst[0] = (uint8_t)((value >> 24) & 0xFFu);
    dst[1] = (uint8_t)((value >> 16) & 0xFFu);
    dst[2] = (uint8_t)((value >> 8) & 0xFFu);
    dst[3] = (uint8_t)(value & 0xFFu);
}

int main(void) {
    uint8_t envelope[OMI_BOOT_ENVELOPE_SIZE];
    OmiBootstrapFrame frame;
    OmiBootResolution res;

    memset(envelope, 0, sizeof(envelope));
    memset(&frame, 0xA5, sizeof(frame));
    memcpy(envelope, OMI_BOOT_GAUGE_PREHEADER, OMI_BOOT_SHEBANG_SIZE);

    put_u16_be(&envelope[0x20], 0x1C00u);
    put_u16_be(&envelope[0x22], 0x1D00u);
    put_u16_be(&envelope[0x24], 0x1E00u);
    put_u16_be(&envelope[0x26], 0x1F00u);
    put_u16_be(&envelope[0x28], 0x001Cu);
    put_u16_be(&envelope[0x2A], 0x001Du);
    put_u16_be(&envelope[0x2C], 0x001Eu);
    put_u16_be(&envelope[0x2E], 0x001Fu);
    put_u32_be(&envelope[0x30], 0xAABBCCDDu);
    put_u32_be(&envelope[0x34], 0x01020304u);
    put_u32_be(&envelope[0x38], 0x11223344u);
    put_u32_be(&envelope[0x3C], 0x55667788u);

    if (omi_boot_envelope_parse(envelope, sizeof(envelope), &frame) != BOOT_OK) {
        return fail("valid envelope rejected");
    }
    if (frame.active_scopes[0] != 0x1C00u ||
        frame.active_scopes[3] != 0x1F00u ||
        frame.carrier_scopes[0] != 0x001Cu ||
        frame.carrier_scopes[3] != 0x001Fu ||
        frame.register_flags != 0xAABBCCDDu ||
        frame.stack_context != 0x01020304u ||
        frame.car_pointer != 0x11223344u ||
        frame.cdr_pointer != 0x55667788u) {
        return fail("parsed bootstrap fields mismatch");
    }

    envelope[0] = 0x00u;
    if (omi_boot_envelope_parse(envelope, sizeof(envelope), &frame) !=
        BOOT_ERROR_GAUGE_MISMATCH) {
        return fail("gauge mismatch accepted");
    }
    envelope[0] = 0xFFu;

    if (omi_boot_envelope_parse(envelope, OMI_BOOT_ENVELOPE_SIZE - 1u, &frame) !=
        BOOT_ERROR_INVALID_ARGUMENT) {
        return fail("truncated envelope accepted");
    }

    if (omi_boot_calculate_bqf(15u, 0u) != 13500u) {
        return fail("BQF Q(15,0) mismatch");
    }
    if (omi_boot_resolve_candidate(OMI_BOOT_FACE_BOOT0, 15u, 0u, true, &res) !=
        BOOT_OK ||
        res.address_energy_bqf != 13500u ||
        res.active_incidence_face != OMI_BOOT_FACE_BOOT0 ||
        res.is_centroid_core) {
        return fail("valid boot candidate resolution mismatch");
    }
    if (omi_boot_resolve_candidate(OMI_BOOT_FACE_BOOT1, 0u, 0u, true, &res) !=
        BOOT_OK ||
        !res.is_centroid_core) {
        return fail("centroid candidate not recognized");
    }
    if (omi_boot_resolve_candidate(OMI_BOOT_FACE_BOOT0, 15u, 0u, false, &res) !=
        BOOT_ERROR_SECURE_REJECTION) {
        return fail("missing secure receipt accepted");
    }
    if (omi_boot_resolve_candidate(OMI_BOOT_FACE_COUNT, 15u, 0u, true, &res) !=
        BOOT_ERROR_BQF_OUT_OF_BOUNDS) {
        return fail("invalid face accepted");
    }
    if (omi_boot_resolve_candidate(OMI_BOOT_FACE_BOOT0, OMI_BOOT_FIELD_X_LIMIT, 0u, true, &res) !=
        BOOT_ERROR_BQF_OUT_OF_BOUNDS) {
        return fail("invalid field x accepted");
    }
    if (omi_boot_resolve_candidate(OMI_BOOT_FACE_BOOT0, 15u, OMI_BOOT_FACE_COUNT, true, &res) !=
        BOOT_ERROR_BQF_OUT_OF_BOUNDS) {
        return fail("invalid field y accepted");
    }

    printf("Omino boot envelope conformance verified: examples/esp32/omi_boot_envelope.c\n");
    return 0;
}
