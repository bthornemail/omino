# Omino Boot Envelope

The boot envelope is a bounded 512-bit carrier profile for flash targets such as eMMC, SPI flash, or microcontroller boot blocks.

```text
64 bytes = 512 bits
0x00..0x1F = gauge / orientation prefix
0x20..0x3F = first OMI---IMO bootstrap frame
```

The canonical gauge pre-header is:

```text
FF 00 1C 1D 1E 1F 20 FF
```

The bootstrap half contains:

```text
8 x 16-bit scopes:
  S0 S1 S2 S3    active FS/GS/RS/US scopes
  S4 S5 S6 S7    inverse carrier scopes

4 x 32-bit words:
  REGISTER STACK CAR CDR
```

All bootstrap fields are parsed big-endian from the 64-byte envelope.

## Tetrahedral Face Map

| Face | Storage role | Meaning |
| --- | --- | --- |
| 0 | BOOT0 | Primary boot candidate |
| 1 | BOOT1 | Fallback / recovery candidate |
| 2 | SECURE / RPMB | Receipt and rollback witness |
| 3 | USER | Carrier content |

BOOT0 and BOOT1 stage candidates. SECURE/RPMB holds receipt and rollback witnesses. USER carries ordinary data.

## Acceptance Boundary

Boot read is not acceptance. Header match is not acceptance. Frame parse is not acceptance.

The implementation exposes a separate candidate resolution function that requires an explicit secure receipt flag before returning `BOOT_OK`. Without that flag, a structurally parsed candidate returns `BOOT_ERROR_SECURE_REJECTION`.

Conformance target:

```sh
make test-boot-envelope
```

This profile does not validate relations, merge origins, or issue receipts.
