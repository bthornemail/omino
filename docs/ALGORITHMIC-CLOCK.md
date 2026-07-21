# Algorithmic Clock

The algorithmic clock is a deterministic state machine. The C runtime currently demonstrates reset, tick sequence, band fingerprint, and centroid-relative comparison.

The optional Verilog backend must match C vectors exactly before it can be treated as a conforming implementation of the clock law.

## Lambda Canon Interlock Backend

`verilog/eal_lambda_canon_core.v` implements the optional Section 12 interlock:

```text
Q(x, y) = (4x + 2y)^2
0x0000 checks the void centroid
0x80 marks the shifted observer boundary
OMNION parity gates admissibility
```

Run:

```sh
make verilog-test
make clock-crosscheck
```

If `iverilog` and `vvp` are unavailable, the Verilog simulation is skipped explicitly. Vector shape validation still runs when `jq` is available.
