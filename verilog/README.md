# Verilog Backend

This directory contains optional RTL backends for Omino deterministic interlocks.

The default C build does not require Verilog.

## Lambda Canon Core

`eal_lambda_canon_core.v` implements the Section 12 Lambda Canon interlock:

```text
Q(x, y) = (4x + 2y)^2
centroid check = linear sum equals zero
observer boundary = token equals 0x80
admissible = declaration-range token and matching OMNION parity
```

`o_is_admissible` is an interlock signal. It is not a receipt and does not replace validation.

## Test

```sh
make verilog-test
```

If `iverilog` and `vvp` are unavailable, the target prints a clear skip.

## Octahedral Face Router

`eal_octahedral_face_router.v` implements the optional Section 33 router projection:

```text
compressed = {address[15:12], address[7:4]}
face[2:1] = compressed[7:6]
face[0]   = compressed[3]
```

Faces `0..3` drive the local `6:4` interface. Faces `4..7` drive the remote `8:3` interface. `o_centroid_lock` is high only for `0x0000`.

Run:

```sh
make octahedral-router-test
make clock-crosscheck
```

## Metatron Incidence Scribe

`metatron_incidence_scribe.v` implements the optional Section 36 inscription block:

```text
i_step_cmd          -> gauge register <<= 4
i_sector_prefix     -> 0x18 incidence witness when prefix is 00/20/40/60
i_gauge_polarity    -> 24-bit pairwise plane flags
o_gauge_carry       -> high when 0x1000 steps past the 16-bit register
```

The raw XOR expression cancels the sector prefix for any input, so the RTL also checks sector membership before committing `0x18`.

Run:

```sh
make metatron-scribe-test
make clock-crosscheck
```

## Omnicron BQF Resolver

`omnicron_bqf_resolver.v` implements the optional Section 37 COBS-CONS/BQF projection:

```text
Q(x, y) = 60x^2 + 16xy + 4y^2
0x00    -> null boundary trap
0x00..0x1F -> control band
0x20..0x7F -> readable observer band
0x80..0xAF -> lazy .o carrier band
0xB0..0xFF -> high-bit sparse lazy band, high-nibble delineation active
```

The BQF output is a diagnostic place-value metric. The resolver does not validate relations, merge origins, or issue receipts.

Run:

```sh
make omnicron-bqf-test
make clock-crosscheck
```
