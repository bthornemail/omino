#include <stdio.h>
#include <string.h>
#include "../../examples/media/omi_media_bridge.c"

static int fail(const char *message) {
    fprintf(stderr, "media bridge conformance failed: %s\n", message);
    return 1;
}

static int expect_gate(uint8_t effect,
                       bool attestation,
                       uint32_t hash,
                       bool allow,
                       uint16_t bridge_word,
                       uint8_t offset,
                       const char *signature) {
    MediaStreamChunk chunk = {101u, hash, effect, attestation};
    MediaHardwareGate gate = omi_arbitrate_media_bus(&chunk);

    if (gate.allow_hardware_bus != allow ||
        gate.local_bridge_word != bridge_word ||
        gate.storage_offset != offset ||
        strcmp(gate.action_log, signature) != 0) {
        return fail(signature);
    }
    return 0;
}

int main(void) {
    MediaHardwareGate gate = omi_arbitrate_media_bus(NULL);
    if (gate.allow_hardware_bus || strcmp(gate.action_log, "REJECT_NULL_CHUNK") != 0) {
        return fail("NULL chunk accepted");
    }

    if (expect_gate(EFFECT_STREAMING, false, 0xDEADBEEFu, false, 0x0000u, 0x00u,
                    "REJECT_UNATTESTED_CARRIER") != 0) return 1;
    if (expect_gate(EFFECT_STREAMING, true, 0u, false, 0x0000u, 0x00u,
                    "REJECT_EMPTY_CARRIER_HASH") != 0) return 1;
    if (expect_gate(EFFECT_STREAMING, true, 0xDEADBEEFu, true, 0x1A55u, 0x18u,
                    "AUTHORIZE_P2P_MEDIA_STREAM") != 0) return 1;
    if (expect_gate(EFFECT_RENDER, true, 0xAAAA5555u, true, 0x1B55u, 0x1Cu,
                    "AUTHORIZE_GPU_WEBGL_RENDER") != 0) return 1;
    if (expect_gate(EFFECT_CAPTURE, true, 0x01020304u, true, 0x1C55u, 0x20u,
                    "AUTHORIZE_LOCAL_SENSOR_CAPTURE") != 0) return 1;
    if (expect_gate(EFFECT_TRANSCODE, true, 0x10203040u, true, 0x1D55u, 0x24u,
                    "AUTHORIZE_FORMAT_TRANSCODE") != 0) return 1;
    if (expect_gate(EFFECT_UNAUTHORIZED, true, 0xDEADBEEFu, false, 0x0000u, 0x00u,
                    "REJECT_OUT_OF_BAND_EFFECT_CLASS") != 0) return 1;

    printf("Media bridge conformance verified: examples/media/omi_media_bridge.c\n");
    return 0;
}
