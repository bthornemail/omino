# Views

Views are projections of `.o` declarations or resolved runtime state. They do not define a parallel data model and do not replace `.o`.

## Layout

```text
html/       Omi-Portal DOM projection
canvas/     standard JSON Canvas examples
dot/        deterministic DOT templates
svg/        generated SVG output location
generated/  generated artifacts
```

Projection generators must retain source `.o` path, origin, address, CAR, CDR, CONS, selector, scope, integrity state, validation state, and attestation state when those values exist.
