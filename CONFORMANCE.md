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
- ESP32 example conformance uses fixed buffers, bounded parsing, COBS zero-leak rejection, and the diagnostic parabolic tracking form without becoming a new authority.
- Runtime lock conformance preserves greedy clock advancement, exact centroid-relative sync, lazy projection, and atomic injection rollback.
- Receipt remains separate from projection.

## Required Projection Behavior

- HTML must use Omi-Portal DOM carriers when rendering OMI/IMO nodes.
- JSON Canvas must use standard `nodes` and `edges` fields; native metadata belongs under `omi`.
- DOT output must be deterministic.
- SVG output generated from DOT must be reproducible.
- All projections must retain `.o` source path and origin.

## Current Conformance Guardrail

`tests/golden/c-runtime-output.txt` captures the current native C output. `make test-golden` compares the runtime output byte-for-byte against the fixture.

`make test-recovery` verifies the CONS recovery vectors. `make test-lambda-types` type-checks a valid five-level Lambda Canon Block and requires GHC to reject invalid mux and observer-boundary examples when GHC is installed.

`make test-esp32` compiles the fixed-memory ESP32-style engine example as host C and verifies bounded parsing/reconciliation behavior. `make test-runtime-lock` checks the reconciled architectural lock without changing the golden runtime fixture.
