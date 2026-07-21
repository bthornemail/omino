# TCG Backend Specification

This document records the Section 44 QEMU TCG backend profile for the OMI-IMO core architecture.

The backend is a specification surface only. Omino does not vendor QEMU, does not build a QEMU target, and does not include this profile in runtime validation.

## Target Profile

```text
TCG_TARGET_REG_BITS = 64
TCG_TARGET_NB_REGS  = 16
TCG_REG_ZERO        = R0
TCG_REG_TMP         = R15
division            = unsupported
vector operations    = unsupported
stack alignment      = 16
```

The register model reserves `R0` as the zero/constraint register and `R15` as scratch for signed 32-bit offset overflow handling.

## Lowering Profile

The target profile allows these modeled operations:

```text
loads/stores  -> register address forms
add/sub/xor   -> register-register forms
move          -> register copy
store offset  -> scratch register path when offset is outside signed 32-bit range
```

Unsupported operations abort translation in the backend profile. The BQF/perfect-square tracking path is lowered through shift/add style register operations; no division operator is part of the target profile.

## Files

The repository stores the profile as non-compiled examples:

```text
examples/tcg/tcg-target.h
examples/tcg/tcg-target.c.inc
```

`make test-tcg-backend-spec` performs static conformance checks over those files. It does not compile QEMU.

## Boundary

The TCG profile is a virtualization/backend specification. It does not validate relations, merge origins, issue attestations, or replace the native C runtime.
