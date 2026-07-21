#include <stdint.h>
#include <stdbool.h>

typedef enum {
    EFFECT_STREAMING = 8,
    EFFECT_TRANSCODE = 9,
    EFFECT_RENDER = 10,
    EFFECT_CAPTURE = 11,
    EFFECT_UNAUTHORIZED = 12
} MediaEffectClass;

typedef struct {
    uint32_t chunk_sequence_id;
    uint32_t media_carrier_hash;
    uint8_t  requested_effect;
    bool     is_receipt_backed;
} MediaStreamChunk;

typedef struct {
    uint16_t local_bridge_word;
    uint8_t  storage_offset;
    bool     allow_hardware_bus;
    const char *action_log;
} MediaHardwareGate;

static MediaHardwareGate omi_arbitrate_media_bus(const MediaStreamChunk *chunk) {
    MediaHardwareGate gate = {
        0x0000u,
        0x00u,
        false,
        "REJECT_UNAUTHORIZED_EFFECT"
    };

    if (chunk == NULL) {
        gate.action_log = "REJECT_NULL_CHUNK";
        return gate;
    }
    if (!chunk->is_receipt_backed) {
        gate.action_log = "REJECT_UNRECEIPTED_CARRIER";
        return gate;
    }
    if (chunk->media_carrier_hash == 0u) {
        gate.action_log = "REJECT_EMPTY_CARRIER_HASH";
        return gate;
    }

    switch (chunk->requested_effect) {
    case EFFECT_STREAMING:
        gate.local_bridge_word = 0x1A55u;
        gate.storage_offset = 0x18u;
        gate.allow_hardware_bus = true;
        gate.action_log = "AUTHORIZE_P2P_MEDIA_STREAM";
        break;
    case EFFECT_RENDER:
        gate.local_bridge_word = 0x1B55u;
        gate.storage_offset = 0x1Cu;
        gate.allow_hardware_bus = true;
        gate.action_log = "AUTHORIZE_GPU_WEBGL_RENDER";
        break;
    case EFFECT_CAPTURE:
        gate.local_bridge_word = 0x1C55u;
        gate.storage_offset = 0x20u;
        gate.allow_hardware_bus = true;
        gate.action_log = "AUTHORIZE_LOCAL_SENSOR_CAPTURE";
        break;
    case EFFECT_TRANSCODE:
        gate.local_bridge_word = 0x1D55u;
        gate.storage_offset = 0x24u;
        gate.allow_hardware_bus = true;
        gate.action_log = "AUTHORIZE_FORMAT_TRANSCODE";
        break;
    default:
        gate.action_log = "REJECT_OUT_OF_BAND_EFFECT_CLASS";
        break;
    }

    return gate;
}

#ifdef OMI_MEDIA_BRIDGE_EMULATED_MAIN
#include <stdio.h>

int main(void) {
    MediaStreamChunk chunk = {
        204u,
        0xAAAA5555u,
        EFFECT_RENDER,
        true
    };
    MediaHardwareGate gate = omi_arbitrate_media_bus(&chunk);

    printf("--- OMINO MULTIMEDIA BRIDGE ---\n");
    printf("Hardware Bus Access: %s\n", gate.allow_hardware_bus ? "GRANTED" : "REJECTED");
    printf("Bridge Word: 0x%04X\n", gate.local_bridge_word);
    printf("Diagnostics: %s\n", gate.action_log);
    return gate.allow_hardware_bus ? 0 : 1;
}
#endif
