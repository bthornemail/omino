#include <stdio.h>
#include <string.h>
#include "../../examples/metatron/metatron_preclosure.c"

static int fail(const char *message) {
    fprintf(stderr, "metatron preclosure conformance failed: %s\n", message);
    return 1;
}

int main(void) {
    InscriptionPlane plane = {0x0001u, 1u, 0x18u};
    TetragrammatronLock lock;

    if (metatron_advance_place(NULL, true) != INSCRIPTION_ERROR_INVALID_ARGUMENT) {
        return fail("NULL plane accepted");
    }
    if (metatron_advance_place(&plane, false) != INSCRIPTION_OK ||
        plane.register_accumulation != 0x0001u) {
        return fail("non-trigger step changed plane");
    }
    if (metatron_advance_place(&plane, true) != INSCRIPTION_OK ||
        plane.register_accumulation != 0x0010u) {
        return fail("FS to GS step mismatch");
    }
    if (metatron_advance_place(&plane, true) != INSCRIPTION_OK ||
        plane.register_accumulation != 0x0100u) {
        return fail("GS to RS step mismatch");
    }
    if (metatron_advance_place(&plane, true) != INSCRIPTION_OK ||
        plane.register_accumulation != 0x1000u) {
        return fail("RS to US step mismatch");
    }
    if (metatron_advance_place(&plane, true) != INSCRIPTION_ERROR_CARRY_OVERFLOW ||
        plane.register_accumulation != 0x10000u) {
        return fail("US carry horizon mismatch");
    }

    if (metatron_confirm_preclosure(&plane) != INSCRIPTION_OK) {
        return fail("valid permutation witness rejected");
    }
    lock = tetragrammatron_adjudicate_closure(&plane, 120u);
    if (!lock.relation_closed ||
        strcmp(lock.status_signature, "RELATION_CLOSURE_GRANTED_AND_LOCKED") != 0) {
        return fail("valid closure rejected");
    }

    lock = tetragrammatron_adjudicate_closure(&plane, 119u);
    if (lock.relation_closed ||
        strcmp(lock.status_signature, "REJECT_CLOSED_RELATION") != 0) {
        return fail("bad diagonal sum accepted");
    }

    plane.permutation_witness = 0x00u;
    if (metatron_confirm_preclosure(&plane) != INSCRIPTION_ERROR_PATTERN_FAULT) {
        return fail("bad witness accepted by Metatron");
    }
    lock = tetragrammatron_adjudicate_closure(&plane, 120u);
    if (lock.relation_closed) {
        return fail("bad witness accepted by Tetragrammatron");
    }

    printf("Metatron preclosure conformance verified: examples/metatron/metatron_preclosure.c\n");
    return 0;
}
