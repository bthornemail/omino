# Pascal Layer-4 Multiplicity

Section 50 maps the four-bit local nibble `0x0..0xF` to a bifurcated integrity
surface and a Pascal tetrahedron Layer-4 weight.

Branch split:

```text
0x0..0x7 -> compact Hamming [7,4,3] branch
0x8..0xF -> extended Miquel [8,4,4] branch
```

Weight map:

```text
0x0             -> 0  centroid
0x1,0x7,0xF     -> 1
0x2,0x3,0x5,0x6 -> 4
0x8,0x9,0xC,0xD -> 4
0x4,0xA,0xE     -> 6
0xB             -> 12
```

Conformance targets:

```sh
make test-layer4-types
make layer4-multiplicity-test
make clock-crosscheck
```

The nibble remains the exact digital route. The Pascal weight is an entrainment
metric only; it does not alter identity, validate relations, merge origins, or
issue receipts.
