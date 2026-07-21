# Claim Status

| Claim | Status | Notes |
| --- | --- | --- |
| Nibble round-trip | implemented | Covered by C runtime output and golden fixture. |
| Selector routing | implemented | Selectors decode to Local/CAR or Remote/CDR in the runtime. |
| XOR-0x80 mirror | implemented | Runtime checks Remote base equals Local base XOR `0x80`. |
| Hamming [7,4,3] | implemented | Runtime encodes/checks the compact profile. |
| Miquel [8,4,4] | defined_model | Extended integrity is documented but not yet extracted as a conformance suite. |
| Single-error correction | implemented | Runtime demonstrates SECDED single-bit correction. |
| Double-error detection | implemented | Runtime contains double-error status logic; broader vector tests pending. |
| Algorithmic clock sequence | implemented | Runtime emits deterministic clock ticks. |
| Zero-drift synchronization | interpretation | Demonstrated as centroid-relative matching, not proved universally. |
| Hardware acceleration | interpretation | Architectural claim only; no benchmark or hardware proof included. |
| Mathematical impossibility of leakage | interpretation | Design intent, not a formal proof in this repository. |
| `.o` as source carrier | defined_model | Required authority boundary; parser integration pending. |
| COBS frame validation | pending | Boundary documented; implementation suite pending. |
| Projection determinism | pending | Static view exists; generator determinism suite pending. |
