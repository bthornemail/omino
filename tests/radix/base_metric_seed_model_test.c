#include <stdio.h>
#include "../../examples/radix/base_metric_seed_model.c"

static int fail(const char *message) {
    fprintf(stderr, "base metric conformance failed: %s\n", message);
    return 1;
}

static int expect_model(uint8_t base_n, uint8_t shift) {
    BaseMetricSeedModel model;
    if (init_base_metric_model(base_n, &model) != RADIX_OK) {
        return fail("supported base rejected");
    }
    if (model.radix_base_n != base_n ||
        model.bit_shift_shortcut != shift ||
        model.current_accumulator != 0u) {
        return fail("base model initialization mismatch");
    }
    return 0;
}

int main(void) {
    BaseMetricSeedModel model;

    if (init_base_metric_model(1u, &model) != RADIX_ERROR_INVALID_BASE) {
        return fail("invalid base accepted");
    }
    if (init_base_metric_model(16u, NULL) != RADIX_ERROR_INVALID_ARGUMENT) {
        return fail("NULL model accepted");
    }

    if (expect_model(2u, 1u) != 0) return 1;
    if (expect_model(8u, 3u) != 0) return 1;
    if (expect_model(10u, 0u) != 0) return 1;
    if (expect_model(16u, 4u) != 0) return 1;
    if (expect_model(58u, 0u) != 0) return 1;
    if (expect_model(64u, 6u) != 0) return 1;

    if (init_base_metric_model(16u, &model) != RADIX_OK) return fail("base16 init failed");
    if (inject_radix_digit(&model, 0x0Au) != RADIX_OK ||
        inject_radix_digit(&model, 0x0Fu) != RADIX_OK ||
        model.current_accumulator != 0xAFu) {
        return fail("base16 shift path mismatch");
    }
    if (inject_radix_digit(&model, 16u) != RADIX_ERROR_CHARACTER_OUT_OF_BOUNDS) {
        return fail("base16 out-of-bounds digit accepted");
    }

    if (init_base_metric_model(10u, &model) != RADIX_OK) return fail("base10 init failed");
    if (inject_radix_digit(&model, 7u) != RADIX_OK ||
        inject_radix_digit(&model, 2u) != RADIX_OK ||
        model.current_accumulator != 72u) {
        return fail("base10 scaling path mismatch");
    }

    if (init_base_metric_model(58u, &model) != RADIX_OK) return fail("base58 init failed");
    if (inject_radix_digit(&model, 57u) != RADIX_OK ||
        inject_radix_digit(&model, 58u) != RADIX_ERROR_CHARACTER_OUT_OF_BOUNDS) {
        return fail("base58 bounds mismatch");
    }

    model.radix_base_n = 16u;
    model.bit_shift_shortcut = 4u;
    model.current_accumulator = 0xFFFFFFFFu;
    if (inject_radix_digit(&model, 1u) != RADIX_ERROR_OVERFLOW_FAIL) {
        return fail("overflow accepted");
    }

    if (inject_radix_digit(NULL, 0u) != RADIX_ERROR_INVALID_ARGUMENT) {
        return fail("NULL inject accepted");
    }

    printf("Base metric conformance verified: examples/radix/base_metric_seed_model.c\n");
    return 0;
}
