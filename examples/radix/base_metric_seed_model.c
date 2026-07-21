#include <stdint.h>
#include <stdbool.h>

typedef enum {
    RADIX_OK = 0,
    RADIX_ERROR_INVALID_BASE,
    RADIX_ERROR_CHARACTER_OUT_OF_BOUNDS,
    RADIX_ERROR_OVERFLOW_FAIL,
    RADIX_ERROR_INVALID_ARGUMENT
} radix_status;

typedef struct {
    uint8_t  radix_base_n;
    uint8_t  bit_shift_shortcut;
    uint32_t current_accumulator;
} BaseMetricSeedModel;

static bool radix_base_is_supported(uint8_t base_n) {
    return base_n == 2u || base_n == 8u || base_n == 10u ||
           base_n == 16u || base_n == 58u || base_n == 64u;
}

static radix_status init_base_metric_model(uint8_t base_n, BaseMetricSeedModel *out_model) {
    if (out_model == NULL) return RADIX_ERROR_INVALID_ARGUMENT;
    if (!radix_base_is_supported(base_n)) return RADIX_ERROR_INVALID_BASE;

    out_model->radix_base_n = base_n;
    out_model->bit_shift_shortcut = 0u;
    out_model->current_accumulator = 0u;

    switch (base_n) {
    case 2:
        out_model->bit_shift_shortcut = 1u;
        break;
    case 8:
        out_model->bit_shift_shortcut = 3u;
        break;
    case 16:
        out_model->bit_shift_shortcut = 4u;
        break;
    case 64:
        out_model->bit_shift_shortcut = 6u;
        break;
    default:
        out_model->bit_shift_shortcut = 0u;
        break;
    }

    return RADIX_OK;
}

static radix_status inject_radix_digit(BaseMetricSeedModel *model, uint8_t raw_digit_value) {
    uint64_t next_accum;

    if (model == NULL) return RADIX_ERROR_INVALID_ARGUMENT;
    if (!radix_base_is_supported(model->radix_base_n)) return RADIX_ERROR_INVALID_BASE;
    if (raw_digit_value >= model->radix_base_n) return RADIX_ERROR_CHARACTER_OUT_OF_BOUNDS;

    if (model->bit_shift_shortcut > 0u) {
        next_accum = (((uint64_t)model->current_accumulator) << model->bit_shift_shortcut) |
                     (uint64_t)raw_digit_value;
    } else {
        next_accum = ((uint64_t)model->current_accumulator * (uint64_t)model->radix_base_n) +
                     (uint64_t)raw_digit_value;
    }

    if (next_accum > 0xFFFFFFFFULL) return RADIX_ERROR_OVERFLOW_FAIL;

    model->current_accumulator = (uint32_t)next_accum;
    return RADIX_OK;
}

#ifdef OMI_BASE_METRIC_EMULATED_MAIN
#include <stdio.h>

int main(void) {
    BaseMetricSeedModel hex_model;
    BaseMetricSeedModel dec_model;

    if (init_base_metric_model(16u, &hex_model) != RADIX_OK) return 1;
    inject_radix_digit(&hex_model, 0x0Au);
    inject_radix_digit(&hex_model, 0x0Fu);

    if (init_base_metric_model(10u, &dec_model) != RADIX_OK) return 1;
    inject_radix_digit(&dec_model, 7u);
    inject_radix_digit(&dec_model, 2u);

    printf("--- OMICORE BASE(N) MULTIPLEXER ---\n");
    printf("BASE(16) accumulator: 0x%02X\n", hex_model.current_accumulator);
    printf("BASE(10) accumulator: %u\n", dec_model.current_accumulator);
    return 0;
}
#endif
