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

`o_is_admissible` is an interlock signal. It is not a attestation and does not replace validation.

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

The BQF output is a diagnostic place-value metric. The resolver does not validate relations, merge origins, or issue attestations.

Run:

```sh
make omnicron-bqf-test
make clock-crosscheck
```

## Fano Slot Scheduler

`fano_slot_scheduler.v` implements the optional Section 38 scheduler projection:

```text
slot5040 = fano7 * 720 + role3 * 240 + local240
fano7    = 0..6
role3    = 0..2
local240 = 0..239
```

Out-of-range inputs assert `o_bounds_fault` and force `o_slot5040` to zero.

Run:

```sh
make fano-slot-test
make clock-crosscheck
```

## EAL Meta Assembler

`eal_meta_assembler.v` implements the optional Section 39 assembler projection:

```text
machine word = opcode[15:12] || slot5040[11:0]
ready        = slot5040 < 5040 and character_token <= 0x7F
```

Invalid slots or tokens force the output to the `0x0000` centroid word. This is a lowering interlock, not validation or attestation authority.

Run:

```sh
make meta-assembler-test
make clock-crosscheck
```

## Backplane Interlock Monitor

`backplane_interlock_monitor.v` implements the optional backplane monitor:

```text
phase mirror = local_azimuth XOR remote_azimuth == 0x80
tetra sum    = i_tetra_sum == 120
lockout      = active-low on phase, tetra, or Hamming double-error fault
priority     = Hamming > Tetragrammatron > phase
```

`o_lockout_n` is an interlock signal. It does not validate relations, merge origins, or issue attestations.

Run:

```sh
make backplane-monitor-test
make clock-crosscheck
```

## Layer-4 Multiplicity Calculator

`eal_layer4_multiplicity_calc.v` implements the optional Section 50 nibble
multiplicity projection:

```text
0x0..0x7 -> compact Hamming [7,4,3] branch
0x8..0xF -> extended Miquel [8,4,4] branch
0x0      -> weight 0
0x1,0x7,0xF -> weight 1
0x4,0xA,0xE -> weight 6
0xB      -> weight 12
all other non-root nibbles -> weight 4
```

The weight is an entrainment metric. It does not validate relations, merge
origins, or issue attestations.

Run:

```sh
make layer4-multiplicity-test
make clock-crosscheck
```

## Metamorphic Export Validator

`eal_metamorphic_export_validator.v` implements the optional Sections 51-52
byte-stream comparator:

```text
compare only when both streams are valid
matching bytes keep identity_ok high
mismatched valid bytes drive identity_ok low and latch bus_interlock_lock high
reset clears the sticky interlock
```

This interlock detects export drift. It does not prove compiler correctness,
validate relations, merge origins, or issue attestations.

Run:

```sh
make metamorphic-export-test
make clock-crosscheck
```

## Visual Matrix Projector

`omino_visual_matrix_projector.v` implements the optional Section 53 flat
projection:

```text
row = nibble[3:2]
col = nibble[1:0]
o_view_is_inert = 1
```

This is an inert display mapper only.

Run:

```sh
make visual-matrix-test
make clock-crosscheck
```

## Lagrange Space Resolver

`eal_lagrange_space_resolver.v` implements the optional Section 54 fold/unfold
layout profile:

```text
UNFOLD(x) = (x[6:5], x[4:0])
FOLD(b,s) = {0,b,s}
```

Bytes above `0x7F` assert `o_byte_bounds_fault`. Canvas coordinates are
projection-only.

Run:

```sh
make lagrange-space-test
make clock-crosscheck
```
