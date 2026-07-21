# Lagrange Space Resolver

Section 54 defines a 7-bit fold/unfold/project profile for layout coordinates.

Implemented optional RTL and Haskell checks:

```text
verilog/eal_lagrange_space_resolver.v
verilog/tb_eal_lagrange_space_resolver.v
vectors/lagrange-space-resolver.jsonl
tests/lagrange-types/
```

Pure operations:

```text
UNFOLD(x) = ((x >> 5) & 3, x & 0x1F)
FOLD(b,s) = (b << 5) | s
```

The RTL also projects each band to canvas coordinates:

```text
band 0 -> x=0,   y=slot*16
band 1 -> x=slot*16, y=0
band 2 -> x=512, y=slot*16
band 3 -> x=slot*16, y=512
```

Inputs above `0x7F` assert `o_byte_bounds_fault`.

Conformance targets:

```sh
make test-lagrange-types
make lagrange-space-test
make clock-crosscheck
```

This profile computes presentation coordinates and fold/unfold witnesses. It
does not validate relations, merge origins, mutate memory, or issue receipts.
