#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include "../../examples/esp32/omnicron_epistemic_core.c"

static int fail(const char *message) {
    fprintf(stderr, "omnicron epistemic conformance failed: %s\n", message);
    return 1;
}

static int expect_surface(uint8_t raw_byte,
                          omnicron_status expected_status,
                          uint8_t expected_band,
                          bool expected_delineation) {
    OmnicronResolution res;
    omnicron_status st = omnicron_resolve_byte_surface(raw_byte, &res);
    if (st != expected_status) return fail("status mismatch");
    if (res.active_band != expected_band) return fail("byte band mismatch");
    if (res.is_delineation != expected_delineation) return fail("delineation mismatch");
    return 0;
}

int main(void) {
    OmnicronResolution res;
    EpistemicQuadrant q = {1u, 0u, 15u, 4u};

    if (omnicron_calculate_bqf(15u, 4u) != 14524u) {
        return fail("BQF Q(15,4) mismatch");
    }
    if (omnicron_calculate_bqf(1u, 1u) != 80u) {
        return fail("BQF Q(1,1) mismatch");
    }

    if (expect_surface(0x00u, OMNICRON_ERROR_ZERO_LEAK, 0u, false) != 0) return 1;
    if (expect_surface(0x1Fu, OMNICRON_OK, 0u, false) != 0) return 1;
    if (expect_surface(0x3Fu, OMNICRON_OK, 1u, false) != 0) return 1;
    if (expect_surface(0x80u, OMNICRON_OK, 3u, false) != 0) return 1;
    if (expect_surface(0xAFu, OMNICRON_OK, 3u, false) != 0) return 1;
    if (expect_surface(0xB0u, OMNICRON_OK, 2u, true) != 0) return 1;
    if (expect_surface(0xFFu, OMNICRON_OK, 2u, true) != 0) return 1;

    if (omnicron_resolve_byte_surface(0x20u, NULL) != OMNICRON_ERROR_OUT_OF_BAND) {
        return fail("NULL resolution output was accepted");
    }
    if (omnicron_resolve_epistemic_quadrant(&q, &res) != OMNICRON_OK ||
        res.address_energy != 14524u) {
        return fail("valid epistemic quadrant did not resolve");
    }
    q.local_field_x = OMI_LOCAL_240_FIELD;
    if (omnicron_resolve_epistemic_quadrant(&q, &res) !=
        OMNICRON_ERROR_DELINEATION_BREACH) {
        return fail("local 240-field breach was accepted");
    }

    printf("Omnicron epistemic core conformance verified: examples/esp32/omnicron_epistemic_core.c\n");
    return 0;
}
