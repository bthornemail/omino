# Conformance

Conforming Omino implementations must preserve the existing `.o` source-carrier role and the native runtime laws.

## Required Runtime Behavior

- Board operations are deterministic over the 256-position plane.
- Coproduct injection preserves origin and provenance.
- Overlap is recorded as conflict and is not destructive.
- Union-Find only maintains equivalence after validation.
- CONS composition remains ordered and non-commutative.
- Nibble interleave and selector decoding match the canonical selector table.
- LOGOS/NOMOS/PATHOS are derived from FS/GS/RS/US.
- Integrity checks do not accept state.
- Receipt remains separate from projection.

## Required Projection Behavior

- HTML must use Omi-Portal DOM carriers when rendering OMI/IMO nodes.
- JSON Canvas must use standard `nodes` and `edges` fields; native metadata belongs under `omi`.
- DOT output must be deterministic.
- SVG output generated from DOT must be reproducible.
- All projections must retain `.o` source path and origin.

## Current Conformance Guardrail

`tests/golden/c-runtime-output.txt` captures the current native C output. `make test-golden` compares the runtime output byte-for-byte against the fixture.
