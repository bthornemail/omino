#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include <string.h>
#include "../../examples/esp32/esp32_p2p_gossip.c"

static int fail(const char *message) {
    fprintf(stderr, "esp32 gossip conformance failed: %s\n", message);
    return 1;
}

int main(void) {
    uint8_t wire[OMI_GOSSIP_WIRE_FRAME_MAX];
    OmiGossipPacket outgoing;
    OmiGossipPacket incoming;
    gossip_status status = GOSSIP_OK;
    const uint64_t local_step = UINT64_C(94832047);

    memset(&outgoing, 0, sizeof(outgoing));
    memset(&incoming, 0xA5, sizeof(incoming));

    outgoing.source_node_id = 0x0E5F32C3u;
    outgoing.step_accumulator = local_step;
    outgoing.omnion_phase = 1u;
    outgoing.board_matrix[0] = 0x80u;
    outgoing.board_matrix[31] = 0x7Eu;
    outgoing.transport_digest[0] = 0xAAu;
    outgoing.transport_digest[15] = 0x55u;

    size_t wire_len = esp32_gossip_encode_frame(&outgoing, wire, sizeof(wire), &status);
    if (status != GOSSIP_OK || wire_len == 0u || wire_len > OMI_GOSSIP_WIRE_FRAME_MAX) {
        return fail("encode did not produce a bounded frame");
    }
    if (wire[wire_len - 1u] != 0x00u) {
        return fail("encoded frame missing delimiter");
    }
    for (size_t i = 0u; i + 1u < wire_len; i++) {
        if (wire[i] == 0x00u) return fail("encoded frame contains internal zero");
    }

    if (esp32_gossip_decode_and_verify(wire, wire_len, local_step, &incoming) != GOSSIP_OK) {
        return fail("valid frame did not decode");
    }
    if (incoming.source_node_id != outgoing.source_node_id ||
        incoming.step_accumulator != outgoing.step_accumulator ||
        incoming.omnion_phase != outgoing.omnion_phase ||
        memcmp(incoming.board_matrix, outgoing.board_matrix, OMI_GOSSIP_BOARD_BYTES) != 0 ||
        memcmp(incoming.transport_digest, outgoing.transport_digest, OMI_GOSSIP_DIGEST_BYTES) != 0) {
        return fail("decoded packet fields mismatch");
    }

    memset(&incoming, 0xA5, sizeof(incoming));
    if (esp32_gossip_decode_and_verify(wire, wire_len, local_step + 1u, &incoming) !=
        GOSSIP_ERROR_SYNC_MISMATCH) {
        return fail("step mismatch was not rejected");
    }
    if (incoming.source_node_id != 0xA5A5A5A5u) {
        return fail("sync mismatch modified output packet");
    }

    wire[1] = 0x00u;
    if (esp32_gossip_decode_and_verify(wire, wire_len, local_step, &incoming) !=
        GOSSIP_ERROR_ZERO_LEAK) {
        return fail("internal zero leak was not rejected");
    }

    memset(&outgoing, 0xFF, sizeof(outgoing));
    wire_len = esp32_gossip_encode_frame(&outgoing, wire, sizeof(wire), &status);
    if (status != GOSSIP_OK || wire_len != OMI_GOSSIP_WIRE_FRAME_MAX) {
        return fail("maximal nonzero frame did not use the bounded wire maximum");
    }

    if (esp32_gossip_encode_frame(&outgoing, wire, OMI_GOSSIP_WIRE_FRAME_MAX - 1u, &status) != 0u ||
        status != GOSSIP_ERROR_CORRUPT_FRAME) {
        return fail("undersized output buffer was accepted");
    }

    printf("ESP32 P2P gossip conformance verified: examples/esp32/esp32_p2p_gossip.c\n");
    return 0;
}
