# Multi-Board Backplane Clustering

This document records the Section 30 physical backplane proposal as an implementation boundary. It is a hardware integration profile, not a new runtime authority. The C runtime, `.o` provenance, validation gate, and attestation layer remain authoritative for accepted relations.

## Topology

The proposed chassis uses alternating Local/CAR and Remote/CDR processing cards around a central OMNION core engine slot:

```text
Slot 0      Slot 1      Slot 2       Slot 3      Slot 4
Local CAR   Remote CDR  OMNION Core  Local CAR   Remote CDR
```

Baseline card profile:

- Form factor: 3U Eurocard, `100 mm x 160 mm`.
- Connector family: DIN 41612 triple-row, 96-pin, named `J1` and `J2`.
- Bus shape: point-to-point differential star centered on the OMNION core engine.
- Signal-integrity target: differential routing with continuous ground return.

The repository does not claim a manufactured board, impedance coupon, timing closure, or EMC validation from this profile.

## J1 Primary Core Routing

| Pin | Row A Signal | Row B Signal | Row C Signal | Allocation |
| --- | --- | --- | --- | --- |
| 1-3 | `+5V_VCC` | `+5V_VCC` | `+5V_VCC` | Core logic power |
| 4 | `GND` | `GND` | `GND` | Ground return |
| 5 | `CLK_P` | `CLK_N` | `GND` | 100 MHz differential reference clock |
| 6 | `RST_N` | `SYS_ERR` | `GND` | Reset and fault flag |
| 7 | `OMNION_P` | `OMNION_N` | `GND` | OMNION phase selection |
| 8 | `BUS_DISC` | `BOARD_ID` | `GND` | CAR/CDR discriminator and slot ID |
| 9 | `FS_D0_P` | `FS_D0_N` | `GND` | FS data bit 0 |
| 10 | `FS_D1_P` | `FS_D1_N` | `GND` | FS data bit 1 |
| 11 | `GS_D0_P` | `GS_D0_N` | `GND` | GS data bit 0 |
| 12 | `GS_D1_P` | `GS_D1_N` | `GND` | GS data bit 1 |
| 13 | `RS_D0_P` | `RS_D0_N` | `GND` | RS data bit 0 |
| 14 | `RS_D1_P` | `RS_D1_N` | `GND` | RS data bit 1 |
| 15 | `US_D0_P` | `US_D0_N` | `GND` | US data bit 0 |
| 16 | `US_D1_P` | `US_D1_N` | `GND` | US data bit 1 |
| 17-30 | `TRACK_V[0..13]_P` | `TRACK_V[0..13]_N` | `GND` | Vernier alignment window channels |
| 31-32 | `GND` | `GND` | `GND` | Shield boundary |

## J2 Extended Coproduct Fiber Interconnect

| Pin | Row A Signal | Row B Signal | Row C Signal | Allocation |
| --- | --- | --- | --- | --- |
| 1-2 | `+12V_AUX` | `+12V_AUX` | `GND` | Auxiliary expansion power |
| 3-10 | `LOGOS_B[0..7]` | `GND` | `NOMOS_B[0..7]` | Epistemic verification buses |
| 11-18 | `PATHOS_B[0..7]` | `GND` | `INTERLOCK_B` | Syndrome and interlock lines |
| 19-24 | `CAR_ADR[0..5]` | `GND` | `CDR_ADR[0..5]` | Sub-quadrant address buses |
| 25 | `TETRA_SUM_P` | `TETRA_SUM_N` | `GND` | Tetragrammatron 120-sum witness |
| 26 | `CHIRAL_OK` | `LOCKOUT_N` | `GND` | Chirality lock and bus isolation |
| 27-30 | `PROJ_AZ[0..3]` | `GND` | `COBS_ERR` | Azimuth projection and frame reset |
| 31-32 | `GND` | `GND` | `GND` | Chassis frame bond |

## Electrical Constraints

- Differential impedance target: `100 ohm +/- 10%`.
- In-pair length matching target: `+/- 0.1 mm`.
- `TRACK_V[0..13]` bundle skew target: `+/- 0.5 mm`.
- Receiver termination: `100 ohm` thin-film termination adjacent to receiver pins.

`LOCKOUT_N` is modeled as a shared active-low isolation line. A hardware implementation may pull it low after uncorrectable integrity failure or Tetragrammatron witness failure. In this repository that behavior remains a hardware profile; runtime validation still decides accepted relations.
