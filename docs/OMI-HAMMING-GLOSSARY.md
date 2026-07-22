# OMI Hamming Glossary

This glossary locks the five root `.omi` files to the systematic file overlay
on the Hamming `[7,4,3]` cell used by the OMI declarative structure. The files
are not fuzzy documentation buckets and must not be remapped through ordinary
compiler categories.

## Source Anchors

The glossary is grounded in these source surfaces:

```text
/home/main/omi/omino/dev-docs/Nibble-Interleaved Quadrant Decoding under a Concurrent 3D Knowledge Triple Matrix.md
/home/main/omi/omi---imo/declarations/omi-system.omilisp
/home/main/omi/omi---imo/docs/LEXICON.omi
/home/main/omi/omi---imo/docs/RULES_GUIDE.md
/home/main/omi/omi-canon/truth-gates/RULES.omi
/home/main/omi/omi-canon/truth-gates/FACTS.omi
/home/main/omi/omi-canon/truth-gates/COMBINATORS.omi
/home/main/omi/omi-canon/truth-gates/CLOSURES.omi
/home/main/omi/omi-canon/truth-gates/CONS.omi
/home/main/omi/omi-portal/RULES.omi
/home/main/omi/omi-portal/FACTS.omi
/home/main/omi/omi-portal/COMBINATORS.omi
/home/main/omi/omi-portal/CLOSURES.omi
/home/main/omi/omi-portal/CONS.omi
```

## Systematic File Overlay

The model first fixes the separator quartet:

```text
FS = 0x1C at 0x*C
GS = 0x1D at 0x*D
RS = 0x1E at 0x*E
US = 0x1F at 0x*F
```

The five-file discipline is then overlaid onto that data quartet:

```text
data positions:
  Bit 1 = FS = FACTS.omi
  Bit 2 = GS = RULES.omi
  Bit 3 = RS = COMBINATORS.omi
  Bit 4 = US = CLOSURES.omi

check positions:
  Bit 5 = LOGOS
  Bit 6 = NOMOS
  Bit 7 = PATHOS
```

The data quartet is carried by `FS/GS/RS/US`. The check triad is derived by
`LOGOS/NOMOS/PATHOS`. Agents must not transpose these positions.

## File Roles

```text
FACTS.omi
  FS data position.
  Grounds the source substrate.

RULES.omi
  GS data position.
  Constrains source law.

COMBINATORS.omi
  RS data position.
  Defines branchless operation composition.

CLOSURES.omi
  US data position.
  Bounds the completed closure surface.

CONS.omi
  Pair surface.
  Folds the four carried data positions against the three derived checks.
```

The existing root-file discipline remains:

```text
RULES constrain.
FACTS ground.
CLOSURES bound.
COMBINATORS transform.
CONS folds.
```

## Derived Hamming Checks

Using the systematic file mapping, the integrity triad is:

```text
LOGOS = FACTS XOR RULES XOR CLOSURES
NOMOS = FACTS XOR COMBINATORS XOR CLOSURES
PATHOS = RULES XOR COMBINATORS XOR CLOSURES
```

Equivalently, each check includes its own check bit:

```text
LOGOS XOR FACTS XOR RULES XOR CLOSURES = 0
NOMOS XOR FACTS XOR COMBINATORS XOR CLOSURES = 0
PATHOS XOR RULES XOR COMBINATORS XOR CLOSURES = 0
```

## CONS Lowering

`CONS.omi` represents the paired Hamming lowering:

```text
(
  FACTS RULES COMBINATORS CLOSURES
  .
  LOGOS NOMOS PATHOS
)
```

Canonical interpretation:

```text
CAR = FACTS RULES COMBINATORS CLOSURES
CDR = LOGOS NOMOS PATHOS
```

The pair is lawful only when the three derived checks vanish.

## Projection Boundary

S-P-O-M is a derived projection surface declared by `omi-system.omilisp`. It is
not the primary owner of the five-file role map. Agents must establish the
Hamming cell first, then may describe S-P-O-M as a downstream projection.
