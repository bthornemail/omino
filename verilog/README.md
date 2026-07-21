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
