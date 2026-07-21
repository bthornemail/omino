# Projection Determinism

Projection generators must be deterministic:

- stable node ordering
- stable edge ordering
- stable identifiers
- no timestamps
- no random layout values in source artifacts

Generated projection nodes must retain source `.o` path, origin identifier, address, CAR, CDR, CONS, selector, scope, integrity state, validation state, and receipt state where those values exist.
