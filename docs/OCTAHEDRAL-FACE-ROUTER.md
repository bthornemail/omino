# Octahedral Face Router

The octahedral face router is an optional RTL projection of the canonical 8-selector table. It maps each nibble-interleaved 16-bit CONS address to one of eight Knowledge Triple faces.

This is a projection/router layer:

- It does not validate relations.
- It does not merge coproduct origins.
- It does not emit receipts.
- It must stay equivalent to the runtime selector law.

## Face Law

Compress a 16-bit `0xY0X0` address to `0xYX`:

```text
compressed = {address[15:12], address[7:4]}
row_nibble = compressed[7:4]
col_nibble = compressed[3:0]
```

The face is selected without division or threshold chains:

```text
face[2:1] = row_nibble[3:2]
face[0]   = col_nibble[3]
```

Faces `0..3` route to the User-Local `6:4` interface. Faces `4..7` route to the User-Remote `8:3` interface. Remote faces are the `XOR 0x80` mirror of the corresponding local faces.

## Face Table

| Face | Selector Code | Domain | Interface | Role |
| --- | --- | --- | --- | --- |
| 0 | `00 07 37 30` | Local/CAR | User-Local `6:4` | LOGOS head |
| 1 | `08 0F 3F 38` | Local/CAR | User-Local `6:4` | NOMOS path |
| 2 | `40 47 77 70` | Local/CAR | User-Local `6:4` | PATHOS body |
| 3 | `48 4F 7F 78` | Local/CAR | User-Local `6:4` | HINGE limit |
| 4 | `80 87 B7 B0` | Remote/CDR | User-Remote `8:3` | LOGOS mirror |
| 5 | `88 8F BF B8` | Remote/CDR | User-Remote `8:3` | NOMOS mirror |
| 6 | `C0 C7 F7 F0` | Remote/CDR | User-Remote `8:3` | PATHOS mirror |
| 7 | `C8 CF FF F8` | Remote/CDR | User-Remote `8:3` | HINGE mirror |

## RTL

The optional Verilog backend is:

```text
verilog/eal_octahedral_face_router.v
verilog/tb_eal_octahedral_face_router.v
vectors/octahedral-face-router.jsonl
```

Run:

```sh
make octahedral-router-test
make test-octahedral-types
```

If `iverilog` and `vvp` are unavailable, the target skips explicitly.

The type-level Haskell harness under `tests/octahedral-types` uses the same selector law. In particular, `0xA080` resolves to Face 5 because its row nibble is `0xA` and its column nibble is `0x8`.
