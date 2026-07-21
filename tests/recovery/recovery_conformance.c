#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

#define main omi_runtime_demo_main
#include "../../src/omnicron-coproduct-partition.c"
#undef main

typedef struct {
    uint32_t car;
    uint32_t cdr;
    uint32_t cons;
    uint32_t recovered_car;
    uint32_t recovered_cdr;
    uint16_t resolver;
    uint16_t square16;
} RecoveryVector;

static int fail(const char *message) {
    fprintf(stderr, "recovery conformance failed: %s\n", message);
    return 1;
}

static bool parse_hex_field(const char *line, const char *key, uint32_t *out) {
    char pattern[64];
    snprintf(pattern, sizeof(pattern), "\"%s\"", key);
    const char *p = strstr(line, pattern);
    if (p == NULL) return false;
    p = strchr(p, ':');
    if (p == NULL) return false;
    p++;
    while (*p == ' ' || *p == '"') p++;
    char *end = NULL;
    unsigned long value = strtoul(p, &end, 0);
    if (end == p) return false;
    *out = (uint32_t)value;
    return true;
}

static bool load_recovery_vector(const char *line, RecoveryVector *v) {
    uint32_t resolver = 0;
    uint32_t square16 = 0;
    bool ok = parse_hex_field(line, "car", &v->car) &&
              parse_hex_field(line, "cdr", &v->cdr) &&
              parse_hex_field(line, "cons", &v->cons) &&
              parse_hex_field(line, "resolver", &resolver) &&
              parse_hex_field(line, "recovered_car", &v->recovered_car) &&
              parse_hex_field(line, "recovered_cdr", &v->recovered_cdr) &&
              parse_hex_field(line, "tracking_square16", &square16);
    v->resolver = (uint16_t)resolver;
    v->square16 = (uint16_t)square16;
    return ok;
}

static int check_recovery_vectors(const char *path) {
    FILE *fh = fopen(path, "r");
    if (fh == NULL) return fail("could not open vectors/quasigroup-recovery.jsonl");

    char line[1024];
    unsigned recovery_count = 0;
    bool saw_square_collision = false;

    while (fgets(line, sizeof(line), fh) != NULL) {
        if (strstr(line, "\"type\":\"recovery\"") != NULL) {
            RecoveryVector v;
            if (!load_recovery_vector(line, &v)) {
                fclose(fh);
                return fail("malformed recovery vector");
            }

            if (omi_cons_fold(v.car, v.cdr, v.resolver) != v.cons) {
                fclose(fh);
                return fail("CONS fold did not match vector");
            }
            if (omi_cons_recover_car(v.cons, v.cdr, v.resolver) != v.recovered_car ||
                v.recovered_car != v.car) {
                fclose(fh);
                return fail("CAR recovery did not invert CONS fold");
            }
            if (omi_cons_recover_cdr(v.car, v.cons, v.resolver) != v.recovered_cdr ||
                v.recovered_cdr != v.cdr) {
                fclose(fh);
                return fail("CDR recovery did not invert CONS fold");
            }
            if (omi_cons_tracking_square16((uint16_t)v.car, (uint16_t)v.cdr) != v.square16) {
                fclose(fh);
                return fail("tracking square witness did not match vector");
            }
            recovery_count++;
        } else if (strstr(line, "\"type\":\"tracking_square_collision\"") != NULL) {
            uint32_t left_car = 0, left_cdr = 0, right_car = 0, right_cdr = 0, square = 0;
            bool ok = parse_hex_field(line, "left_car16", &left_car) &&
                      parse_hex_field(line, "left_cdr16", &left_cdr) &&
                      parse_hex_field(line, "right_car16", &right_car) &&
                      parse_hex_field(line, "right_cdr16", &right_cdr) &&
                      parse_hex_field(line, "tracking_square16", &square);
            if (!ok) {
                fclose(fh);
                return fail("malformed square collision vector");
            }
            uint16_t left_square = omi_cons_tracking_square16((uint16_t)left_car, (uint16_t)left_cdr);
            uint16_t right_square = omi_cons_tracking_square16((uint16_t)right_car, (uint16_t)right_cdr);
            if (left_square != (uint16_t)square || right_square != (uint16_t)square) {
                fclose(fh);
                return fail("tracking square collision vector did not collide");
            }
            if ((uint16_t)left_car == (uint16_t)right_car &&
                (uint16_t)left_cdr == (uint16_t)right_cdr) {
                fclose(fh);
                return fail("tracking square collision used identical coordinates");
            }
            saw_square_collision = true;
        }
    }

    fclose(fh);

    if (recovery_count < 4u) return fail("expected at least four recovery vectors");
    if (!saw_square_collision) return fail("expected diagnostic square collision vector");
    return 0;
}

static int check_resolver_salt(void) {
    uint32_t car = 0x12345678u;
    uint32_t cdr = 0x55667788u;
    uint32_t cons_a = omi_cons_fold(car, cdr, 0x0001u);
    uint32_t cons_b = omi_cons_fold(car, cdr, 0x0002u);

    if (cons_a == cons_b) return fail("resolver salt did not affect CONS");
    if (omi_cons_recover_car(cons_a, cdr, 0x0001u) != car) return fail("salted CAR recovery failed");
    if (omi_cons_recover_cdr(car, cons_a, 0x0001u) != cdr) return fail("salted CDR recovery failed");
    if (omi_cons_recover_car(cons_a, cdr, 0x0002u) == car) {
        return fail("wrong resolver unexpectedly recovered CAR");
    }
    if (omi_cons_recover_cdr(car, cons_a, 0x0002u) == cdr) {
        return fail("wrong resolver unexpectedly recovered CDR");
    }
    return 0;
}

static int check_recovery_does_not_validate(void) {
    OmiCoproductBlackboard bb;
    omi_blackboard_init(&bb);

    OmiBoardContribution left = omi_make_contribution(
        0x4C454654u, 0x12345678u, 0x55667788u, 1u, 1u, 0x48u);
    OmiBoardContribution right = omi_make_contribution(
        0x52474854u, 0x12345678u, 0x55667789u, 1u, 1u, 0x48u);

    uint32_t left_idx = 0, right_idx = 0;
    if (omi_blackboard_inject(&bb, &left, &left_idx) != OMI_OK) return fail("left injection failed");
    if (omi_blackboard_inject(&bb, &right, &right_idx) != OMI_OK) return fail("right injection failed");

    if (bb.fibers[0x48u].contribution_count != 2u) {
        return fail("coproduct overlap collapsed fiber contributors");
    }
    if (omi_board256_popcount(&bb.occupancy) != 1u ||
        omi_board256_popcount(&bb.conflict) != 1u) {
        return fail("overlap accounting changed during recovery conformance");
    }

    uint32_t cons = omi_cons_fold(left.car, left.cdr, left.resolver_profile);
    if (omi_cons_recover_cdr(left.car, cons, left.resolver_profile) != left.cdr) {
        return fail("precondition recovery failed");
    }

    OmiContributionRef left_ref = {
        .source_id = left.source_id,
        .car = left.car,
        .cdr = left.cdr,
        .resolver_profile = left.resolver_profile,
        .scope = left.scope,
        .flags = 0
    };
    OmiContributionRef right_ref = {
        .source_id = right.source_id,
        .car = right.car,
        .cdr = right.cdr,
        .resolver_profile = right.resolver_profile,
        .scope = right.scope,
        .flags = 0
    };

    OmiValidationResult validation;
    omi_blackboard_validate_equivalence(&bb, left_ref, right_ref, &validation);
    if (validation.valid || validation.reason != OMI_VALID_REASON_NO_MATCH) {
        return fail("recovery coordinates were treated as validation acceptance");
    }
    if (omi_blackboard_union(&bb, left_idx, right_idx, &validation) != OMI_ERROR_NOT_VALIDATED) {
        return fail("union accepted an unvalidated recovery relation");
    }
    if (omi_find(&bb.equivalence, left_idx) == omi_find(&bb.equivalence, right_idx)) {
        return fail("unvalidated recovery relation merged origins");
    }
    return 0;
}

int main(void) {
    int rc = 0;
    rc |= check_recovery_vectors("vectors/quasigroup-recovery.jsonl");
    rc |= check_resolver_salt();
    rc |= check_recovery_does_not_validate();
    if (rc == 0) {
        printf("Quasigroup recovery vectors verified: vectors/quasigroup-recovery.jsonl\n");
    }
    return rc;
}
