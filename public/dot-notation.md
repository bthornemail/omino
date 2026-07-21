# Emergent Axial Lisp Native Dot-Notation View

This file records the readable OMI CONS surface for the static native view.
Projection is contextual. Receipt remains external and explicit.

## Lambda Canon Block

```lisp
(
  (subject . notation)
  (predicate . citation)
  (object . attestation)
  (computational_ontology . annotation)
  (systematic_epistemology . interpretation)
)
```

## LOGOS/NOMOS/PATHOS Hamming Surface

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

Compact codeword:

```text
[L N F P G R U]
```

## Full OMI Relation

```lisp
(o
 . ((scope . (FS . (GS . (RS . US))))
    (path . (LOGOS . (NOMOS . PATHOS)))
    (query . (REGISTER . STACK))
    (close . (CAR . CDR)))))
```

## Knowledge Triple Cube

```text
Quadrant 0 = (Local/CAR  . (Low  . Left))
Quadrant 1 = (Local/CAR  . (Low  . Right))
Quadrant 2 = (Local/CAR  . (High . Left))
Quadrant 3 = (Local/CAR  . (High . Right))
Quadrant 4 = (Remote/CDR . (Low  . Left))
Quadrant 5 = (Remote/CDR . (Low  . Right))
Quadrant 6 = (Remote/CDR . (High . Left))
Quadrant 7 = (Remote/CDR . (High . Right))
```

Selector table:

```c
{0x00, 0x07, 0x37, 0x30}
{0x08, 0x0F, 0x3F, 0x38}
{0x40, 0x47, 0x77, 0x70}
{0x48, 0x4F, 0x7F, 0x78}
{0x80, 0x87, 0xB7, 0xB0}
{0x88, 0x8F, 0xBF, 0xB8}
{0xC0, 0xC7, 0xF7, 0xF0}
{0xC8, 0xCF, 0xFF, 0xF8}
```

## Native View Rule

```text
omi- opens.
imo- closes.
Address names.
Hyphens delineate.
Segments triangulate.
DOM nests.
Horn proves.
Receipt accepts.
```
