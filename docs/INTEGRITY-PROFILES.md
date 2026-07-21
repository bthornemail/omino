# Integrity Profiles

## Hamming [7,4,3]

```text
position 1 = LOGOS
position 2 = NOMOS
position 3 = FS
position 4 = PATHOS
position 5 = GS
position 6 = RS
position 7 = US
```

```text
LOGOS  = FS XOR GS XOR US
NOMOS  = FS XOR RS XOR US
PATHOS = GS XOR RS XOR US
```

FS/GS/RS/US carries scope. LOGOS/NOMOS/PATHOS checks scope.

## Miquel [8,4,4]

The extended point adds OMNION as an overall parity/orientation point. It is not a fifth scope level and does not accept state.
