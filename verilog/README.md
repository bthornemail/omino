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
