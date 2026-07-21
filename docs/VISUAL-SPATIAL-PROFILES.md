# Visual and Spatial Projection Profiles

Section 53 defines inert display profiles for inspecting internal topology.

Implemented optional RTL:

```text
verilog/omino_visual_matrix_projector.v
verilog/tb_omino_visual_matrix_projector.v
vectors/visual-matrix-projector.jsonl
```

The visual matrix maps local nibble `0x0..0xF` to a 4x4 display grid:

```text
row = nibble[3:2]
col = nibble[1:0]
```

`o_view_is_inert` is always high. This is a projection signal only.

The documented presentation profiles are:

```text
16-state local nibble surface
Pascal tetrahedron Layer-4 multiplicity grid
12 free pentomino / pentacube layout
```

Conformance targets:

```sh
make visual-matrix-test
make clock-crosscheck
```

Visual outputs do not validate relations, collapse nodes, merge origins, mutate
memory, or issue attestations.
