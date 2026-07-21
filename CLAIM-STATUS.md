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
| Reconciled runtime lock | implemented | `make test-runtime-lock` verifies fixed centroid, greedy/exact/lazy separation, exact sync rejection, and atomic preflight rollback. |
| Octahedral face router RTL | implemented | Optional Verilog router and vectors added; `make octahedral-router-test` verifies selector-face routing when simulator tools are available. |
| Octahedral type-level face checks | implemented | Optional GHC harness validates selector-to-face and face-to-interface assignments, including rejection of the incorrect `0xA080 -> Face4` mapping. |
| Canonical authority type-level checks | implemented | Optional GHC harness validates authority/witness namespace separation and rejects cross-authority witness assignments. |
