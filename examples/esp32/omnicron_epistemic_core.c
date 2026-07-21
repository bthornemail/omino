#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>

#define OMI_LOCAL_240_FIELD 240u
#define OMI_DELINEATION_THRESHOLD 0x0Bu

typedef enum {
    OMNICRON_OK = 0,
    OMNICRON_ERROR_ZERO_LEAK,
    OMNICRON_ERROR_DELINEATION_BREACH,
    OMNICRON_ERROR_OUT_OF_BAND
} omnicron_status;

typedef struct {
    uint8_t  car_visibility;
    uint8_t  cdr_visibility;
    uint16_t local_field_x;
    uint16_t local_field_y;
} EpistemicQuadrant;

typedef struct {
    uint32_t address_energy;
    uint8_t  active_band;
    bool     is_delineation;
} OmnicronResolution;

static inline uint32_t omnicron_calculate_bqf(uint32_t x, uint32_t y) {
    return (60u * x * x) + (16u * x * y) + (4u * y * y);
}

static omnicron_status omnicron_resolve_byte_surface(uint8_t raw_byte,
                                                     OmnicronResolution *out_res) {
    if (out_res == NULL) return OMNICRON_ERROR_OUT_OF_BAND;

    out_res->address_energy = 0u;
    out_res->is_delineation =
        (((raw_byte >> 4) & 0x0Fu) >= OMI_DELINEATION_THRESHOLD);

    if (raw_byte <= 0x1Fu) {
        out_res->active_band = 0u;
        if (raw_byte == 0x00u) return OMNICRON_ERROR_ZERO_LEAK;
    } else if (raw_byte <= 0x7Fu) {
        out_res->active_band = 1u;
    } else if (raw_byte <= 0xAFu) {
        out_res->active_band = 3u;
    } else {
        out_res->active_band = 2u;
    }

    return OMNICRON_OK;
}

static omnicron_status omnicron_resolve_epistemic_quadrant(const EpistemicQuadrant *q,
                                                           OmnicronResolution *out_res) {
    if (q == NULL || out_res == NULL) return OMNICRON_ERROR_OUT_OF_BAND;
    if (q->local_field_x >= OMI_LOCAL_240_FIELD) {
        return OMNICRON_ERROR_DELINEATION_BREACH;
    }

    out_res->address_energy =
        omnicron_calculate_bqf(q->local_field_x, q->local_field_y);
    return OMNICRON_OK;
}

#ifdef OMNICRON_EPISTEMIC_EMULATED_MAIN
static void app_main_omnicron(void) {
    uint8_t incoming_signal = 0x3Fu;
    OmnicronResolution res;
    EpistemicQuadrant q = {1u, 0u, 15u, 4u};

    printf("--- ESP32 OMNICRON CORE: COBS-CONS PROTOCOL RUNTIME ---\n");
    omnicron_status st = omnicron_resolve_byte_surface(incoming_signal, &res);
    if (st == OMNICRON_OK) {
        printf("Stream Signal [0x%02X] Resolved:\n", incoming_signal);
        printf("  Target Byte Band : %u\n", res.active_band);
        printf("  High Delineation : %s\n",
               res.is_delineation ? "TRUE (FRAME BOUND)" : "FALSE (LOCAL DECLARATION)");
    }

    st = omnicron_resolve_epistemic_quadrant(&q, &res);
    if (st == OMNICRON_OK) {
        printf("Place-Value Address Energy Q(15,4) = %u Units\n", res.address_energy);
    }
}

int main(void) {
    app_main_omnicron();
    return 0;
}
#endif
