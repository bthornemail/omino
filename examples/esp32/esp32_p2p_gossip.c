#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include <string.h>
#include <inttypes.h>

#define OMI_GOSSIP_PORT 5040u
#define OMI_GOSSIP_BOARD_BYTES 32u
#define OMI_GOSSIP_DIGEST_BYTES 16u
#define OMI_GOSSIP_RAW_FRAME_SIZE 64u
#define OMI_GOSSIP_WIRE_FRAME_MAX (OMI_GOSSIP_RAW_FRAME_SIZE + 2u)

typedef enum {
    GOSSIP_OK = 0,
    GOSSIP_ERROR_CORRUPT_FRAME,
    GOSSIP_ERROR_ZERO_LEAK,
    GOSSIP_ERROR_SYNC_MISMATCH
} gossip_status;

typedef struct {
    uint32_t source_node_id;
    uint64_t step_accumulator;
    uint8_t  omnion_phase;
    uint8_t  board_matrix[OMI_GOSSIP_BOARD_BYTES];
    uint8_t  transport_digest[OMI_GOSSIP_DIGEST_BYTES];
} OmiGossipPacket;

static void gossip_put_u32_le(uint8_t *dst, uint32_t value) {
    for (uint32_t i = 0; i < 4u; i++) {
        dst[i] = (uint8_t)((value >> (i * 8u)) & 0xFFu);
    }
}

static void gossip_put_u64_le(uint8_t *dst, uint64_t value) {
    for (uint32_t i = 0; i < 8u; i++) {
        dst[i] = (uint8_t)((value >> (i * 8u)) & 0xFFu);
    }
}

static uint32_t gossip_get_u32_le(const uint8_t *src) {
    uint32_t value = 0u;
    for (uint32_t i = 0; i < 4u; i++) {
        value |= ((uint32_t)src[i]) << (i * 8u);
    }
    return value;
}

static uint64_t gossip_get_u64_le(const uint8_t *src) {
    uint64_t value = 0u;
    for (uint32_t i = 0; i < 8u; i++) {
        value |= ((uint64_t)src[i]) << (i * 8u);
    }
    return value;
}

static void esp32_gossip_pack_raw(const OmiGossipPacket *packet,
                                  uint8_t raw[OMI_GOSSIP_RAW_FRAME_SIZE]) {
    memset(raw, 0, OMI_GOSSIP_RAW_FRAME_SIZE);
    gossip_put_u32_le(&raw[0], packet->source_node_id);
    gossip_put_u64_le(&raw[4], packet->step_accumulator);
    raw[12] = packet->omnion_phase;
    memcpy(&raw[16], packet->board_matrix, OMI_GOSSIP_BOARD_BYTES);
    memcpy(&raw[48], packet->transport_digest, OMI_GOSSIP_DIGEST_BYTES);
}

static void esp32_gossip_unpack_raw(const uint8_t raw[OMI_GOSSIP_RAW_FRAME_SIZE],
                                    OmiGossipPacket *packet) {
    packet->source_node_id = gossip_get_u32_le(&raw[0]);
    packet->step_accumulator = gossip_get_u64_le(&raw[4]);
    packet->omnion_phase = raw[12];
    memcpy(packet->board_matrix, &raw[16], OMI_GOSSIP_BOARD_BYTES);
    memcpy(packet->transport_digest, &raw[48], OMI_GOSSIP_DIGEST_BYTES);
}

static size_t esp32_gossip_encode_frame(const OmiGossipPacket *packet,
                                        uint8_t *out_wire_buf,
                                        size_t out_wire_cap,
                                        gossip_status *out_status) {
    uint8_t raw[OMI_GOSSIP_RAW_FRAME_SIZE];
    size_t dst_idx = 1u;
    size_t code_idx = 0u;
    uint8_t code = 1u;

    if (out_status != NULL) *out_status = GOSSIP_OK;
    if (packet == NULL || out_wire_buf == NULL || out_wire_cap < OMI_GOSSIP_WIRE_FRAME_MAX) {
        if (out_status != NULL) *out_status = GOSSIP_ERROR_CORRUPT_FRAME;
        return 0u;
    }

    esp32_gossip_pack_raw(packet, raw);
    out_wire_buf[0] = 0u;

    for (size_t i = 0u; i < OMI_GOSSIP_RAW_FRAME_SIZE; i++) {
        if (raw[i] == 0x00u) {
            out_wire_buf[code_idx] = code;
            code_idx = dst_idx++;
            code = 1u;
        } else {
            out_wire_buf[dst_idx++] = raw[i];
            code++;
        }
    }

    out_wire_buf[code_idx] = code;
    out_wire_buf[dst_idx++] = 0x00u;
    return dst_idx;
}

static gossip_status esp32_gossip_decode_and_verify(const uint8_t *wire_buf,
                                                    size_t wire_len,
                                                    uint64_t local_accumulator,
                                                    OmiGossipPacket *out_packet) {
    uint8_t raw[OMI_GOSSIP_RAW_FRAME_SIZE];
    OmiGossipPacket candidate;
    size_t src_idx = 0u;
    size_t dst_idx = 0u;
    size_t target_decode_len;

    if (wire_buf == NULL || out_packet == NULL || wire_len < 2u ||
        wire_len > OMI_GOSSIP_WIRE_FRAME_MAX || wire_buf[wire_len - 1u] != 0x00u) {
        return GOSSIP_ERROR_CORRUPT_FRAME;
    }

    memset(raw, 0, sizeof(raw));
    memset(&candidate, 0, sizeof(candidate));
    target_decode_len = wire_len - 1u;

    while (src_idx < target_decode_len) {
        uint8_t code = wire_buf[src_idx++];
        if (code == 0x00u) return GOSSIP_ERROR_ZERO_LEAK;

        for (uint8_t i = 1u; i < code; i++) {
            if (src_idx >= target_decode_len || dst_idx >= OMI_GOSSIP_RAW_FRAME_SIZE) {
                return GOSSIP_ERROR_CORRUPT_FRAME;
            }
            if (wire_buf[src_idx] == 0x00u) return GOSSIP_ERROR_ZERO_LEAK;
            raw[dst_idx++] = wire_buf[src_idx++];
        }

        if (code < 0xFFu && src_idx < target_decode_len) {
            if (dst_idx >= OMI_GOSSIP_RAW_FRAME_SIZE) return GOSSIP_ERROR_CORRUPT_FRAME;
            raw[dst_idx++] = 0x00u;
        }
    }

    if (dst_idx != OMI_GOSSIP_RAW_FRAME_SIZE) return GOSSIP_ERROR_CORRUPT_FRAME;

    esp32_gossip_unpack_raw(raw, &candidate);
    if (candidate.step_accumulator != local_accumulator) {
        return GOSSIP_ERROR_SYNC_MISMATCH;
    }

    *out_packet = candidate;
    return GOSSIP_OK;
}

#ifdef OMI_GOSSIP_EMULATED_MAIN
static void app_main_gossip_test(void) {
    uint64_t local_step = UINT64_C(94832047);
    OmiGossipPacket outgoing;
    OmiGossipPacket incoming;
    uint8_t wire[OMI_GOSSIP_WIRE_FRAME_MAX];
    gossip_status status;

    memset(&outgoing, 0, sizeof(outgoing));
    outgoing.source_node_id = 0xE5F32C3u;
    outgoing.step_accumulator = local_step;
    outgoing.omnion_phase = 1u;
    outgoing.board_matrix[0] = 0x80u;

    size_t wire_len = esp32_gossip_encode_frame(&outgoing, wire, sizeof(wire), &status);

    printf("--- ESP32 MULTI-PROCESSOR P2P GOSSIP SUBSYSTEM INTERFACE ---\n");
    printf("UDP Port: %u\n", OMI_GOSSIP_PORT);
    printf("Serialized COBS Gossip Frame Length: %zu Bytes\n", wire_len);

    status = esp32_gossip_decode_and_verify(wire, wire_len, local_step, &incoming);
    if (status == GOSSIP_OK) {
        printf("Verification Result: SUCCESS\n");
        printf("Decoded Node ID: 0x%08X\n", incoming.source_node_id);
        printf("Clock Cadence: %" PRIu64 "\n", incoming.step_accumulator);
    } else {
        printf("Verification Rejection: %d\n", status);
    }
}

int main(void) {
    app_main_gossip_test();
    return 0;
}
#endif
