# Reconciled Architectural Lock

The runtime is locked around three separate compute layers:

```text
GREEDY clock state  -> omi_clock_tick() advances with the bitwise oscillate law.
EXACT sync authority -> centroid-relative state equality decides peer sync.
LAZY projection      -> geometry and display vectors are read on demand.
```

The lock preserves these boundaries:

- One fixed centroid state: `omi_centroid_state(_) == 0x0000`.
- OMNION selects orientation (`0x00` or `0x80`), not a different centroid address.
- Physical or SI clock frequency constants are adapter concerns, not runtime law.
- Blackboard injection preflights every claimed coordinate before mutation.
- Polybius diagonal comments stay aligned: XOR witnesses cancellation; SUM preserves `0x1E` relational weight.
- Transport digests are optional metadata and never source identity.

Conformance target:

```sh
make test-runtime-lock
```

This target checks the lock behavior without changing the golden runtime output.
