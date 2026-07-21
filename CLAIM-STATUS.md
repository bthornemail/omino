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
| Lambda Canon RTL interlock | implemented | Optional Verilog module and vectors added; simulator run depends on `iverilog`/`vvp`. |
| Lambda Canon RTL conformance | pending | Full C/RTL cross-check awaits simulator availability and broader vectors. |
| Quasigroup CONS recovery | implemented | `make test-recovery` verifies rotate/XOR inverses, resolver salt behavior, diagnostic-only square tracking, and non-collapse boundaries. |
| Lambda Canon type-level block checks | implemented | Optional GHC harness validates the modeled five-level block and expected compile-time rejections; this is a Haskell reference-surface guarantee, not whole-system hardware proof. |
| Backplane connector profile | defined_model | Pinout and signal-integrity targets documented; no fabricated board, timing closure, or EMC validation claimed. |
| ESP32 fixed-buffer execution example | implemented | `make test-esp32` verifies bounded parse, COBS zero-leak rejection, mux-band rejection, centroid, and parabolic tracking behavior as host C. |
| ESP32 P2P gossip sync profile | implemented | `make test-esp32-gossip` verifies fixed 64-byte raw frames, bounded COBS wire encoding, zero-leak rejection, sync mismatch rejection, and preflight output rollback as host C. |
| eMMC-style boot envelope profile | implemented | `make test-boot-envelope` verifies the 64-byte flash envelope, canonical gauge pre-header, big-endian bootstrap frame extraction, BQF bounds, centroid detection, and secure-receipt rejection. |
| TCG backend profile | defined_model | `docs/TCG-BACKEND-SPEC.md` and `examples/tcg/` record the QEMU TCG target profile; `make test-tcg-backend-spec` performs static checks without building QEMU. |
| Reconciled runtime lock | implemented | `make test-runtime-lock` verifies fixed centroid, greedy/exact/lazy separation, exact sync rejection, and atomic preflight rollback. |
| BASE(n) metric seed model | implemented | `make test-base-metric` verifies supported radix profiles, power-of-two shift shortcuts, non-power-of-two scaling, digit bounds, and overflow rejection. |
| Multimedia federated sync media bridge | implemented | `make test-media-bridge` verifies receipt-backed/nonzero carrier gating for streaming, render, capture, and transcode bridge words while rejecting unreceipted or out-of-band effects. |
| Metatron pre-closure inscription pipeline | implemented | `make test-metatron-preclosure` verifies `<< 4` place stepping, `0x10000` carry, `0x18` witness gating, and separate Tetragrammatron `120` closure adjudication. |
| Octahedral face router RTL | implemented | Optional Verilog router and vectors added; `make octahedral-router-test` verifies selector-face routing when simulator tools are available. |
| Octahedral type-level face checks | implemented | Optional GHC harness validates selector-to-face and face-to-interface assignments, including rejection of the incorrect `0xA080 -> Face4` mapping. |
| Canonical authority type-level checks | implemented | Optional GHC harness validates authority/witness namespace separation and rejects cross-authority witness assignments. |
| Metatron incidence scribe RTL | implemented | Optional Verilog block and vectors added; `make metatron-scribe-test` verifies place stepping, carry, sector-gated `0x18` witness, and pairwise plane flags. |
| Omnicron epistemic COBS-CONS/BQF layer | implemented | `make test-omnicron-epistemic` verifies `0x00` trapping, `0x00..0x1F`/`0x20..0x7F`/`0x80..0xAF`/`0xB0..0xFF` classification, local 240-field rejection, and BQF `Q(x,y)=60x^2+16xy+4y^2` evaluation. |
| Omnicron BQF resolver RTL | implemented | Optional Verilog block and vectors added; `make omnicron-bqf-test` verifies diagnostic energy, byte-band routing, high-nibble delineation, and null-boundary trap behavior. |
| Fano 5040 slot scheduler RTL | implemented | Optional Verilog block and vectors added; `make fano-slot-test` verifies `fano7*720 + role3*240 + local240`, ceiling slot `5039`, and bounds-fault zeroing. |
| EAL meta-assembler RTL | implemented | Optional Verilog block and vectors added; `make meta-assembler-test` verifies packed opcode/slot words, centroid reporting, slot ceiling rejection, and 7-bit token rejection. |
| Backplane interlock monitor RTL | implemented | Optional Verilog block and vectors added; `make backplane-monitor-test` verifies XOR-`0x80` phase mirror, Tetragrammatron `120` sum check, active-low lockout, and Hamming/Tetragrammatron/phase fault priority. |
| Pure meta-compiler reference core | implemented | Optional GHC harness validates modeled Surface-to-Parsed and Resolved-to-Lowered passes, slot arithmetic, and expected compile-time rejections for invalid local240, slot5040, and assembler-token bounds. |
| Absolute conformance ledger | implemented | `docs/CONFORMANCE-LEDGER.md` maps the 27 guardrails to executable targets or documented-model boundaries; `make test-conformance-guardrail-types` verifies aggregate mirror, scheduler, and assembler bounds in the Haskell reference surface. |
| Externalized proof complex bibliography | defined_model | `docs/EXTERNAL-PROOF-COMPLEX.md` links Omino to `bthornemail/axiomatic-sovereignty` at observed commit `12ad1d4f860c400c2b6304a68dd6c45469ed41d9`; proof checks run outside Omino and are not part of `make check`. |
