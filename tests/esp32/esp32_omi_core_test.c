#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include "../../examples/esp32/esp32_omi_core.c"

static int fail(const char *message) {
    fprintf(stderr, "esp32 conformance failed: %s\n", message);
    return 1;
}

int main(void) {
    OmiAddress128 addr;
    ReconciledEngineState state;

    if (!esp32_parse_hex_frame("0000-0000-0000-0000-0000-0000-0000-0000", &addr)) {
        return fail("centroid frame did not parse");
    }
    if (esp32_reconcile_interface(&addr, 0x1Bu, &state) != EAL_OK) {
        return fail("centroid frame did not reconcile");
    }
    if (!state.is_centroid || state.parabolic_evaluation != 0u || state.active_surface_band != 0u) {
        return fail("centroid state was not recognized");
    }

    if (!esp32_parse_hex_frame("000F-001E-0000-0000-0000-0000-0000-0000", &addr)) {
        return fail("tracking frame did not parse");
    }
    if (esp32_reconcile_interface(&addr, 0x7Fu, &state) != EAL_OK) {
        return fail("valid high declaration band was rejected");
    }
    if (state.parabolic_evaluation != 14400u || state.active_surface_band != 3u) {
        return fail("tracking value or band mismatch");
    }
    if (esp32_reconcile_interface(&addr, 0x80u, &state) != EAL_ERROR_BAND_BREACH) {
        return fail("out-of-band mux token was accepted");
    }
    if (esp32_parse_hex_frame("0000-0000-0000-0000-0000-0000-0000", &addr)) {
        return fail("truncated frame parsed unexpectedly");
    }

    uint8_t decoded[OMI_COBS_BUFFER_SIZE];
    eal_status status = EAL_OK;
    const uint8_t zero_leak[1] = {0x00u};
    if (esp32_cobs_decode_bounded(zero_leak, sizeof(zero_leak), decoded, sizeof(decoded), &status) != 0u ||
        status != EAL_ERROR_ZERO_LEAK) {
        return fail("COBS zero leak was not rejected");
    }

    const uint8_t frame[3] = {0x03u, 0xAAu, 0x55u};
    size_t n = esp32_cobs_decode_bounded(frame, sizeof(frame), decoded, sizeof(decoded), &status);
    if (n != 2u || status != EAL_OK || decoded[0] != 0xAAu || decoded[1] != 0x55u) {
        return fail("COBS payload did not decode");
    }

    printf("ESP32 OMI core conformance verified: examples/esp32/esp32_omi_core.c\n");
    return 0;
}
