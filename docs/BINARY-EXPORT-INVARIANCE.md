# Binary Export Invariance

Sections 51-52 define a bounded metamorphic export profile.

The C profile emits a 12-byte image:

```text
F8 00 1C 1D 1E 1F 20 F8 <linear-root-u32>
```

The linear root is:

```text
4x + 2y
```

First Form Void is `meta_compile_to_eal(0, 0)`. Therefore binary identity is a
centroid property. Active EAL coordinates are expected to differ from First Form
Void and must be rejected by the comparison guard.

Conformance targets:

```sh
make test-binary-export
make test-metamorphic-types
make metamorphic-export-test
make clock-crosscheck
```

The export verifier compares deterministic byte streams. It does not validate
relations, merge origins, issue attestations, or prove platform-wide compiler
correctness.
