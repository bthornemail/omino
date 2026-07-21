# Metatron Pre-Closure Pipeline

The pre-closure pipeline models Metatron inscription before Tetragrammatron closure.

Metatron owns place inscription:

```text
FS 0x0001 -> GS 0x0010 -> RS 0x0100 -> US 0x1000 -> CARRY 0x10000
```

Each active step shifts the tracking register left by four bits. The `0x18` permutation witness must be present before the layout can be handed to the closure adjudicator.

Tetragrammatron closure remains separate. In the C harness, closure is granted only when:

```text
permutation_witness == 0x18
diagonal_sum == 120
```

Conformance target:

```sh
make test-metatron-preclosure
```

Metatron records where a relation occurred. It does not validate or attestation by itself.
