# O Source Lifecycle

```text
source .o
-> parsed declaration
-> typed axial coordinate
-> coproduct contribution
-> integrity check
-> CONS recovery when one coordinate is missing and resolver profile is known
-> validation decision
-> receipt
-> projection
```

`.o` files are declaration carriers. They are not replaced by JSON Canvas, HTML, DOT, SVG, or any generated view.

## Boundaries

- Declaration states source intent and provenance.
- Integrity checks whether encoded scope remains coherent.
- Recovery reconstructs missing CAR/CDR/CONS coordinates under the CONS resolver profile. It is not validation.
- Validation decides whether a candidate relation may be accepted.
- Receipt records acceptance.
- Projection renders context for inspection.
