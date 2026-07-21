#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include <string.h>

#define main omi_runtime_demo_main
#include "../../src/omnicron-coproduct-partition.c"
#undef main

static int fail(const char *message) {
    fprintf(stderr, "runtime lock conformance failed: %s\n", message);
    return 1;
}

static int check_centroid_lock(void) {
    if (omi_centroid_state(0u) != 0x0000u || omi_centroid_state(1u) != 0x0000u) {
        return fail("OMNION changed centroid address");
    }
    OmiOrientedOmnionClock c0 = omi_process_centroid_alignment(0x1234u, 0u);
    OmiOrientedOmnionClock c1 = omi_process_centroid_alignment(0x1234u, 1u);
    if (c0.current_azimuth != 0x00u || c1.current_azimuth != 0x80u) {
        return fail("OMNION did not select the expected orientation");
    }
    return 0;
}

static int check_greedy_exact_lazy_layers(void) {
    OmiClockState clock = omi_make_clock(0x1234u);
    uint16_t expected_next = omi_clock_oscillate(clock.state);
    OmiGeometricVector before = omi_resolve_vector_to_centroid(0xA28Bu, 1u);
    OmiClockState advanced = omi_clock_tick(clock);
    OmiGeometricVector after = omi_resolve_vector_to_centroid(0xA28Bu, 1u);

    if (advanced.state != expected_next) return fail("greedy clock tick did not advance");
    if (before.relative_address != after.relative_address ||
        before.azimuth_angle != after.azimuth_angle ||
        before.radial_distance != after.radial_distance) {
        return fail("lazy projection changed across identical reads");
    }

    OmiClockSyncPeer left = omi_clock_sync_peer_init(0x1234u);
    OmiClockSyncPeer right = omi_clock_sync_peer_init(0x1234u);
    OmiClockSyncPeer drifted = omi_clock_sync_peer_init(0xFFFFu);
    for (uint32_t i = 0; i < 3u; i++) {
        omi_clock_sync_peer_tick(&left);
        omi_clock_sync_peer_tick(&right);
        omi_clock_sync_peer_tick(&drifted);
    }
    if (!omi_clock_sync_check_resolved(&left, &right, 0u)) {
        return fail("same-seed peers did not synchronize exactly");
    }
    if (omi_clock_sync_check_resolved(&left, &drifted, 0u)) {
        return fail("different-seed peer synchronized unexpectedly");
    }
    return 0;
}

static int check_atomic_preflight_rollback(void) {
    OmiCoproductBlackboard bb;
    omi_blackboard_init(&bb);

    for (uint32_t i = 0; i < OMI_MAX_FIBER_CONTRIBUTORS; i++) {
        OmiBoardContribution c = omi_make_contribution(
            0x41410000u + i, i, i + 1u, 0u, 1u, 0x48u);
        uint32_t idx = 0;
        if (omi_blackboard_inject(&bb, &c, &idx) != OMI_OK) {
            return fail("preflight setup injection failed");
        }
    }

    uint32_t count_before = bb.contribution_count;
    uint32_t conflict_before = omi_board256_popcount(&bb.conflict);
    OmiBoardContribution overflow = omi_make_contribution(
        0x4F564552u, 0x11111111u, 0x22222222u, 0u, 1u, 0x48u);
    omi_board256_set(&overflow.board, 0x49u);

    if (omi_blackboard_inject(&bb, &overflow, NULL) != OMI_ERROR_CAPACITY) {
        return fail("fiber overflow did not reject");
    }
    if (bb.contribution_count != count_before) {
        return fail("failed preflight changed contribution count");
    }
    if (omi_board256_test(&bb.occupancy, 0x49u)) {
        return fail("failed preflight mutated occupancy");
    }
    if (omi_board256_popcount(&bb.conflict) != conflict_before) {
        return fail("failed preflight mutated conflict board");
    }
    return 0;
}

int main(void) {
    int rc = 0;
    rc |= check_centroid_lock();
    rc |= check_greedy_exact_lazy_layers();
    rc |= check_atomic_preflight_rollback();
    if (rc == 0) {
        printf("Runtime architectural lock conformance verified\n");
    }
    return rc;
}
