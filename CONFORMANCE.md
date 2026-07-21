# Conformance

Conforming Omino implementations must preserve the existing `.o` source-carrier role and the native runtime laws.

## Required Runtime Behavior

- Board operations are deterministic over the 256-position plane.
- Coproduct injection preserves origin and provenance.
- Overlap is recorded as conflict and is not destructive.
- Union-Find only maintains equivalence after validation.
- CONS composition remains ordered and non-commutative.
- Quasigroup recovery may reconstruct a missing CAR/CDR/CONS coordinate, but it does not validate or merge origins.
- Nibble interleave and selector decoding match the canonical selector table.
- LOGOS/NOMOS/PATHOS are derived from FS/GS/RS/US.
- Integrity checks do not accept state.
- Type-level Lambda Canon checks, when built, enforce modeled block completeness and boundary guards only for the Haskell reference surface.
- Type-level octahedral checks, when built, enforce modeled selector-to-face and face-to-interface assignments only for the Haskell reference surface.
- Type-level canonical authority checks, when built, keep relation closure, route inscription, display orientation, and byte-plane classification witnesses in separate namespaces.
- ESP32 example conformance uses fixed buffers, bounded parsing, COBS zero-leak rejection, and the diagnostic parabolic tracking form without becoming a new authority.
- ESP32 gossip conformance uses fixed-size raw frames, bounded COBS wire buffers, explicit little-endian serialization, zero-leak rejection, and sync-mismatch preflight rollback.
- Boot-envelope conformance uses a fixed 64-byte flash carrier, exact gauge pre-header matching, big-endian bootstrap field extraction, BQF bounds checks, and explicit secure-receipt separation from parse/stage.
- Omnicron epistemic conformance uses fixed buffers, BQF place-value evaluation, local 240-field boundary rejection, COBS-CONS `0x00` boundary trapping, and byte-band classification without becoming validation authority.
- TCG backend conformance is a static specification check only. Omino does not build QEMU or treat TCG lowering as validation authority.
- Runtime lock conformance preserves greedy clock advancement, exact centroid-relative sync, lazy projection, and atomic injection rollback.
- Optional octahedral RTL routing must match the canonical selector law and remain projection-only.
- Optional Metatron RTL inscription must keep place stepping and incidence logging isolated from Tetragrammatron validation.
- Optional Omnicron BQF RTL must match the COBS-CONS byte-band law and diagnostic BQF energy calculation without accepting relations or issuing receipts.
- Optional Fano 5040 RTL scheduling must enforce `fano7 <= 6`, `role3 <= 2`, `local240 <= 239`, and zero the slot on bounds fault.
- Optional EAL meta-assembler RTL must reject `slot5040 >= 5040` and non-7-bit character tokens before committing a packed instruction word.
- Optional backplane monitor RTL must assert active-low lockout on phase mirror drift, Tetragrammatron sum drift, or Hamming double-error reports, with deterministic fault priority.
- Type-level meta-compiler checks, when built, enforce modeled stage transitions, slot bounds, and assembler token bounds only for the Haskell reference surface.
- Type-level conformance guardrail checks, when built, aggregate modeled mirror, scheduler, and assembler bounds without replacing runtime validation or hardware proof.
- External Coq proof authority is bibliographic only inside Omino. Proofs are checked from `bthornemail/axiomatic-sovereignty`, not from Omino `make check`.
- Receipt remains separate from projection.

## Required Projection Behavior

- HTML must use Omi-Portal DOM carriers when rendering OMI/IMO nodes.
- JSON Canvas must use standard `nodes` and `edges` fields; native metadata belongs under `omi`.
- DOT output must be deterministic.
- SVG output generated from DOT must be reproducible.
- All projections must retain `.o` source path and origin.

## Current Conformance Guardrail

`tests/golden/c-runtime-output.txt` captures the current native C output. `make test-golden` compares the runtime output byte-for-byte against the fixture.

`docs/CONFORMANCE-LEDGER.md` maps the Section 40 checklist to executable targets and documented-model boundaries.

`docs/EXTERNAL-PROOF-COMPLEX.md` records the Section 41 bibliography boundary to `bthornemail/axiomatic-sovereignty`. Omino does not vendor Coq sources or generated proof artifacts, and `make check` does not depend on the external proof repository.

`make test-recovery` verifies the CONS recovery vectors. `make test-lambda-types` type-checks a valid five-level Lambda Canon Block and requires GHC to reject invalid mux and observer-boundary examples when GHC is installed. `make test-octahedral-types` type-checks valid selector-face/interface examples and requires GHC to reject invalid face/interface assignments. `make test-canonical-types` type-checks valid authority envelopes and requires GHC to reject cross-authority witness assignments and out-of-range byte planes. `make test-meta-compiler-types` type-checks valid pure compiler/slot examples and requires GHC to reject invalid `local240`, `slot5040`, and assembler-token examples. `make test-conformance-guardrail-types` type-checks the aggregate Section 40 guardrail and requires GHC to reject invalid local240, fano, mirror, and assembler-token examples.

`make test-esp32` compiles the fixed-memory ESP32-style engine example as host C and verifies bounded parsing/reconciliation behavior. `make test-esp32-gossip` compiles the Section 43 P2P gossip layer as host C and verifies bounded COBS frame encode/decode, zero-leak rejection, sync mismatch rejection, and output rollback. `make test-boot-envelope` compiles the Section 45 boot envelope layer as host C and verifies gauge matching, bootstrap parsing, BQF bounds, and secure-receipt rejection. `make test-omnicron-epistemic` compiles the Section 37 Omnicron COBS-CONS/BQF layer as host C and verifies byte-band and local-field containment. `make test-tcg-backend-spec` statically checks the Section 44 TCG backend profile without requiring QEMU. `make test-runtime-lock` checks the reconciled architectural lock without changing the golden runtime fixture.

`make octahedral-router-test` verifies the optional RTL face router when Verilog tools are installed. `make metatron-scribe-test` verifies the optional RTL Metatron scribe. `make omnicron-bqf-test` verifies the optional RTL Omnicron BQF resolver. `make fano-slot-test` verifies the optional RTL Fano 5040 scheduler. `make meta-assembler-test` verifies the optional RTL EAL meta-assembler. `make backplane-monitor-test` verifies the optional RTL backplane interlock monitor. `make clock-crosscheck` validates Lambda Canon, octahedral router, Metatron scribe, Omnicron BQF, Fano scheduler, meta-assembler, and backplane monitor vector shapes when `jq` is available.
