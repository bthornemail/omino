# Omino: A Deterministic Blackboard Clockwork Architecture for Emergent Axial Lisp

## Abstract

Omino is a native implementation and projection package for the Emergent Axial
Lisp, Meta-CONS, and Omnicron coproduct architecture. It combines
origin-preserving symbolic memory, deterministic logical time, Hamming-coded
integrity, nibble-interleaved routing, bounded transport framing, optional
hardware realization, and reproducible native views.

The system begins with `.o` declarations as source carriers. These declarations
are resolved into typed axial coordinates, injected into a non-destructive
coproduct blackboard, checked through LOGOS/NOMOS/PATHOS integrity relations,
framed through COBS, continued through CONS, accepted only through validation,
recorded through attestations, and finally rendered through HTML, JSON Canvas, DOT,
or SVG.

The Algorithmic Clock is not a physical clock. It is a deterministic
state-transition system rooted at the fixed OMNION centroid. Its local route is
carried through four-bit addresses, its integrity surface bifurcates between
compact Hamming `[7,4,3]` and extended Miquel/Hamming `[8,4,4]`, and its analog
modeling surface uses Pascal tetrahedron Layer-4 coefficients as entrainment
weights. These weights affect projection and coupling only; they do not alter
identity, validation, provenance, or attestation authority.

## Build

```sh
make
```

This builds:

```text
build/omnicron-coproduct-partition
```

## Run

```sh
make run
```

## Test

```sh
make test-golden
make check
make clock-crosscheck
```

The first guardrail is `tests/golden/c-runtime-output.txt`, a byte-for-byte
fixture for the current C runtime output. Refactors must preserve that output
unless the fixture is intentionally updated with a documented semantic change.

## 1. System Purpose

Omino provides a bounded runtime for symbolic declarations whose meaning depends
on several independent coordinates rather than on a single lexical namespace.

Its principal components are:

```text
Emergent Axial Lisp
Meta-CONS Runtime
Omnicron Coproduct Partition
LOGOS/NOMOS/PATHOS integrity
COBS-CONS framing and continuation
OMNION deterministic centroid and clock
Native HTML, Canvas, DOT, and SVG views
Optional C, Haskell, Verilog, ESP32, boot, and TCG surfaces
```

The system is organized around a strict authority pipeline:

```text
.o files declare.
Emergent Axial Lisp resolves.
Meta-CONS composes.
Hamming and Miquel check integrity.
COBS frames.
CONS preserves continuation.
Validation accepts.
Attestation records.
Projection displays.
```

Projection is never acceptance. Recovery is never validation. Integrity is never
semantic truth. Two declarations may share a visible coordinate without losing
their independent origins.

## 2. The `.o` Source Lifecycle

The `.o` file is the primary declaration carrier.

Its lifecycle is:

```text
source .o
-> parsed declaration
-> typed axial coordinate
-> coproduct contribution
-> integrity check
-> optional CONS recovery
-> validation decision
-> attestation
-> projection
```

Each stage has a distinct role. Declaration records intent and provenance.
Integrity checks structural coherence. Recovery reconstructs a missing CAR, CDR,
or CONS coordinate under a known resolver profile. Validation decides whether a
candidate may be accepted. Attestation records the accepted or rejected result.
Projection makes the state inspectable.

JSON Canvas, HTML, DOT, SVG, and other views do not replace `.o` and do not
define a parallel schema.

## 3. Origin-Preserving Coproduct Blackboard

Omino does not merge all declarations into one mutable namespace.

Independent local and remote sources contribute origin-tagged boards to a shared
256-position symbolic plane. When two contributions occupy the same visible
position, the runtime records an overlap or conflict but preserves both
contributors.

The blackboard therefore implements a coproduct rather than a destructive union:

```text
source A contribution
coproduct source B contribution
coproduct source C contribution
```

Equivalence may be maintained through Union-Find only after an explicit
validation witness has been supplied. Union-Find maintains accepted equivalence
classes; it does not decide equivalence.

This architecture protects:

```text
origin
provenance
ordered CAR/CDR relation
resolver profile
scope
validation status
attestation status
```

The conformance rules require deterministic board behavior, non-destructive
overlap, origin preservation, validation-gated equivalence, and ordered
non-commutative CONS composition.

## 4. Blackboard Quadrant Routing

The 16-bit CONS plane is routed through eight canonical Knowledge Triple faces.

A nibble-interleaved address has the form:

```text
0xY0X0
```

and compresses to:

```text
0xYX
```

The face index is derived directly from selected row and column bits:

```text
face[2:1] = row_nibble[3:2]
face[0]   = col_nibble[3]
```

This yields eight routing faces:

```text
0 Local/CAR LOGOS head
1 Local/CAR NOMOS path
2 Local/CAR PATHOS body
3 Local/CAR HINGE limit

4 Remote/CDR LOGOS mirror
5 Remote/CDR NOMOS mirror
6 Remote/CDR PATHOS mirror
7 Remote/CDR HINGE mirror
```

Faces `0..3` are local. Faces `4..7` are remote. Each remote face is the
`XOR 0x80` mirror of its corresponding local face.

The quadrant router is a routing and projection layer. It does not validate
relations, merge origins, or issue attestations.

## 5. Scope and Hamming Integrity

The four scope-bearing positions are:

```text
FS
GS
RS
US
```

The three derived integrity dimensions are:

```text
LOGOS
NOMOS
PATHOS
```

The compact Hamming arrangement is:

```text
position 1 = LOGOS
position 2 = NOMOS
position 3 = FS
position 4 = PATHOS
position 5 = GS
position 6 = RS
position 7 = US
```

Using even parity:

```text
LOGOS  = FS XOR GS XOR US
NOMOS  = FS XOR RS XOR US
PATHOS = GS XOR RS XOR US
```

FS/GS/RS/US carries scope. LOGOS/NOMOS/PATHOS checks the carried scope.

The root `.omi` file discipline is mapped onto a systematic Hamming cell in
[OMI-HAMMING-GLOSSARY.md](docs/OMI-HAMMING-GLOSSARY.md). In that map,
`FS=FACTS.omi`, `GS=RULES.omi`, `RS=COMBINATORS.omi`, and
`US=CLOSURES.omi`; `CONS.omi` folds the carried quartet against
`LOGOS/NOMOS/PATHOS`.

The compact `[7,4,3]` profile supports single-error correction when protected by
an external frame-level witness.

The extended Miquel/Hamming `[8,4,4]` profile adds OMNION as an overall parity
and orientation point. OMNION is not a fifth scope position, and neither
integrity profile independently accepts state.

## 6. The Algorithmic Clock

The Algorithmic Clock is a deterministic logical state machine.

It is divided into three compute layers:

```text
GREEDY clock state
  advances through the bitwise oscillate law

EXACT synchronization authority
  compares centroid-relative state equality

LAZY projection
  derives display and geometry only when requested
```

The centroid remains fixed:

```text
address 0x0000
azimuth 0 degrees
```

OMNION selects orientation, such as `0x00` or `0x80`, but does not select a
different centroid address. Physical frequency constants are adapter concerns
and are not part of the logical clock law.

The optional Verilog implementation must reproduce the C vectors exactly before
it can be considered conforming.

## 7. Four-Bit Carry-Forward Annotation

The clock progresses through four-bit address places.

A local nibble moves through:

```text
0x0 -> 0x1 -> ... -> 0xE -> 0xF
```

and then carries forward:

```text
0x000F -> 0x0010
0x00FF -> 0x0100
0xFFFF -> 0x10000
```

The Metatron pre-closure model makes this explicit:

```text
FS 0x0001
-> GS 0x0010
-> RS 0x0100
-> US 0x1000
-> CARRY 0x10000
```

Each active step shifts the place register left by four bits. The `0x18`
permutation witness must be present before handoff to Tetragrammatron closure,
and closure remains a separate authority requiring its own conditions.

This creates a locally finite but globally extensible annotation path. Every
place is a 16-state nibble, while the complete annotation address may continue
through arbitrarily many carried places.

## 8. Bifurcated Integrity Surface

The local four-bit clock route is divided into two branches:

```text
0x0..0x7
  compact Hamming [7,4,3]

0x8..0xF
  extended Miquel/Hamming [8,4,4]
```

The nibble remains the exact digital route.

A useful interpretation is:

```text
0x0
  declared centroid/root

0x1..0x7
  compact Hamming incidence positions

0x8..0xF
  extended Miquel incidence positions
```

This gives a 16-state local surface consisting of one root plus fifteen non-root
positions:

```text
1 + 7 + 8 = 16
```

The two integrity profiles remain distinct. The nibble provides a routing and
clockwork organization over them; it does not combine them into one larger
codeword.

## 9. Pascal Tetrahedron Layer-4 Multiplicity

The same local nibble is assigned a Pascal tetrahedron Layer-4 coefficient.

The implemented weight map is:

```text
0x0             -> 0  centroid
0x1,0x7,0xF     -> 1
0x2,0x3,0x5,0x6 -> 4
0x8,0x9,0xC,0xD -> 4
0x4,0xA,0xE     -> 6
0xB             -> 12
```

These values are derived from the Layer-4 tetrahedral multiplicity pattern.

The essential boundary is:

```text
nibble address
  exact digital route

Pascal coefficient
  analog entrainment weight
```

The weight may influence coupling strength, visualization, amplitude,
multiplicity, or analog-style entrainment. It may not change identity,
validation, origin, equivalence, or attestation status.

This distinction allows Omino to support both exact digital semantics and
continuous or weighted modeling without confusing one for the other.

## 10. Three Hamming Clockwork Dimensions

Every annotation address may carry a complete temporal-integrity tensor.

Let:

```text
L = LOGOS
N = NOMOS
P = PATHOS

LL = previous
MM = present
NN = forward
```

Then:

```text
W_a =
[ L_LL(a)  L_MM(a)  L_NN(a) ]
[ N_LL(a)  N_MM(a)  N_NN(a) ]
[ P_LL(a)  P_MM(a)  P_NN(a) ]
```

This matrix keeps temporal position and integrity dimension separate.

Its diagonal projection is:

```text
D_a = [ L_LL(a), N_MM(a), P_NN(a) ]
```

or:

```text
LL -> LOGOS
MM -> NOMOS
NN -> PATHOS
```

The diagonal is a compact routed witness, not an identity between the two axes.

For analog modeling, each matrix entry may carry both:

```text
exact integrity state
  syndrome bit, correction status, validation status

analog response state
  amplitude, coupling, phase alignment, or confidence
```

The analog response may help points entrain, but it cannot override an exact
Hamming failure.

## 11. The 60-Point Circular Slide Ruler

The unbounded annotation address may be embedded onto a 60-point circular ruler:

```text
phi(a) = a mod 60
```

The complete distance from the root remains:

```text
a = 60r + phi
```

where:

```text
r
  completed revolutions

phi
  current ruler point, 0..59
```

The 60-point ring supports exact subdivision into many structural partitions:

```text
2 halves of 30
3 sectors of 20
4 sectors of 15
5 sectors of 12
6 sectors of 10
10 sectors of 6
12 sectors of 5
```

This makes it suitable for embedding:

```text
three integrity dimensions
four scope positions
five Lambda levels
six incidence directions
twelve agreement contacts
```

The circular ruler does not bound the annotation sequence. It is a finite
projection of an unbounded four-bit carry-forward address.

## 11.1 OMNION Word Axis Surface

The 72-ruler, 4,320-incidence ruler surface belongs to one unified OMNION word
axis context. It is not spread across program memory, object arrays, worker
grids, or sequential tables.

Inside one OMNION word axis, the local fiber is:

```text
18 Local240 Blackboard Faces
4 Blackboard Quadrants per face
60 circular points per quadrant ruler
```

Therefore:

```text
18 * 4 * 60 = 4320
```

The local interpretation coordinate is:

```text
R[b,q,phi]
```

where:

```text
b
  Local240 Blackboard Face, 0..17

q
  Blackboard Quadrant, 0..3

phi
  circular point, 0..59
```

The full OMNION coordinate retains the local chart together with the
interpretation start and carry depth:

```text
OMNION[b_start,k,b,q,phi]
```

where `b_start` is selected from:

```text
0x1F, 0x2F, 0x3F, 0x4F, 0x5F, 0x6F
```

and `k` is the carry or revolution depth. The carry-depth component prevents
repeated local charts from collapsing into the same addressed position, while
the 4,320 local incidences remain inside the single OMNION word axis context.

## 12. The 240-Step Realignment

The local nibble repeats every 16 steps:

```text
a mod 16
```

The circular ruler repeats every 60 steps:

```text
a mod 60
```

Their joint state repeats after:

```text
lcm(16, 60) = 240
```

This gives a precise modular basis for the 240-position clockwork:

```text
16
  local nibble route

60
  circular slide-ruler phase

240
  first complete nibble/ruler realignment
```

The 240-step field is therefore not only a geometric analogy. It is the exact
supercycle of the local hexadecimal route and the sexagesimal phase embedding.
It is a reusable local chart, not a final address ceiling.

The complete decomposition is:

```text
a = 240k + rho
```

where:

```text
k
  unbounded carry, revolution, or place-value depth

rho
  local240 coordinate, 0..239
```

Two addresses may share the same finite projection while remaining different
global carry-forward coordinates:

```text
0, 240, 480
  same phase240
  different carried address depth

5, 65, 125
  same phase60
  different completed revolutions

15, 31, 47
  same local nibble
  different higher address places
```

The Omnicron conformance surface explicitly protects the local 240-chart
projection while preserving the unbounded carry-forward address above it.

## 13. Analog Entrainment

Entrainment in Omino means alignment of relative projected phases without
collapse of source identity.

For two annotation streams `a` and `b`:

```text
phi_a = a mod 60
phi_b = b mod 60
```

Their phase relation is:

```text
Delta60(a,b) = (phi_b - phi_a) mod 60
```

The three integrity dimensions may regulate entrainment differently:

```text
LOGOS
  proposes or measures structural phase coherence

NOMOS
  permits, limits, or rejects movement across a boundary

PATHOS
  preserves or interrupts forward carry
```

The Pascal Layer-4 coefficient weights the strength of this interaction.

Thus:

```text
address identifies
Hamming checks
Pascal weights
Delta positions
the ruler embeds
OMNION orients
validation accepts
attestation records
```

Entrainment does not mean that two origins merge, that one declaration replaces
another, or that a projection becomes authoritative.

## 14. OMNION Centroid and Binary Export

The canonical centroid is fixed at:

```text
address 0x0000
azimuth 0 degrees
```

OMNION selects orientation but does not validate or issue attestations.

The binary export profile emits a deterministic 12-byte image:

```text
F8 00 1C 1D 1E 1F 20 F8 <linear-root-u32>
```

The linear root is:

```text
4x + 2y
```

Binary identity with the First Form Void is permitted only at the centroid.
Active coordinates are expected to differ and must be rejected by the export
comparison guard.

This preserves a strict distinction between:

```text
centroid identity
active-coordinate transformation
projection similarity
accepted semantic equivalence
```

## 15. COBS-CONS and Transport

COBS preserves deterministic framing and zero-delimited transport. CONS
preserves ordered relational continuation.

Neither mechanism independently validates a relation.

The ESP32 gossip profile transports sparse 256-bit board contributions through
fixed-size frames:

```text
raw frame: 64 bytes
maximum encoded wire frame: 66 bytes
```

The decoder checks synchronization before committing output. A mismatch leaves
the caller's output untouched, preserving atomic preflight behavior.

The boot envelope similarly uses a fixed 64-byte, 512-bit carrier with the
canonical pre-header:

```text
FF 00 1C 1D 1E 1F 20 FF
```

Boot parsing, header matching, and candidate staging are not acceptance. A
separate secure attestation flag is required before a candidate returns an accepted
boot result.

## 16. Hardware and Backend Surfaces

Omino includes several optional implementation and projection profiles.

### Verilog

Optional RTL blocks model:

```text
Algorithmic Clock
Lambda Canon interlock
octahedral face routing
Metatron inscription
BQF calculation
Fano scheduling
meta-assembly
backplane interlock
Layer-4 multiplicity
binary export invariance
visual matrix projection
Lagrange fold/unfold projection
```

These blocks must match C vectors and remain subordinate to runtime validation.

### Backplane

The proposed physical topology alternates Local/CAR and Remote/CDR cards around
a central OMNION core slot. It includes dedicated buses for FS/GS/RS/US,
LOGOS/NOMOS/PATHOS, tracking windows, projection azimuth, lockout, and
Tetragrammatron witnesses. The document intentionally does not claim a
manufactured board, timing closure, or EMC validation.

### QEMU TCG

The TCG backend is a static specification profile. It models 64-bit registers,
sixteen target registers, a zero register, a scratch register, and
shift/add/XOR lowering without division. Omino does not build or vendor QEMU
and does not treat TCG lowering as validation authority.

## 17. Native Views

Native views render `.o` declarations or resolved runtime state.

HTML uses Omi-Portal DOM carriers:

```html
<omi-node id="omi-<address>" data-omi="<address>"></omi-node>
<imo-node id="imo-<address>" data-imo="<address>"></imo-node>
```

JSON Canvas uses standard `nodes` and `edges` fields, with native metadata
placed under `omi`. DOT must be deterministic, and SVG output must be
reproducible.

Projection generation requires:

```text
stable node ordering
stable edge ordering
stable identifiers
no timestamps
no random source-layout values
```

Every projected node must retain source path, origin, address, CAR, CDR, CONS,
selector, scope, integrity status, validation status, and attestation status when
available.

To check native views:

```sh
make views
make view-path
```

The current static projection package lives under `public/`.

## 18. Media and Federated Effects

Media files are normalized carriers rather than intrinsic authorities.

Examples include:

```text
o.h264.o
o.mp4.o
o.aac.o
o.wav.o
o.jpeg.o
o.png.o
o.gltf.o
o.glb.o
```

Streaming, rendering, capture, and transcoding are enabled only when a carrier
has attestation-locked authorization and a nonzero carrier hash. The bridge gates
effects; it does not validate relations, merge origins, or issue attestations.

This allows multimedia and hardware side effects to remain downstream of
symbolic validation.

## 19. Formal Proof Boundary

Omino keeps runtime implementation and formal proof authority in separate
repositories.

```text
Omino
  runtime, projections, tests, vectors

axiomatic-sovereignty
  external Coq/Rocq proof authority
```

Omino records a bibliography to the external proof complex but does not vendor
`.v` sources, compiled proof artifacts, or proof logs. Its normal `make check`
does not require Coq.

The proof repository owns formal arguments related to:

```text
finite arithmetic
control-band encoding
Hamming and Miquel incidence
closure and 240-state arithmetic
BQF projection bridges
deterministic replay
authority preservation
```

Omino remains responsible for executable conformance. The proof repository
remains responsible for formal logic.

## 20. Conformance Status

The conformance ledger distinguishes executable guards from documented models.

`PASS` means an executable target currently checks the property. `DEFINED_MODEL`
means the architecture is documented but not proven or fully implemented in this
repository.

Implemented or scoped guards include:

```text
nibble round-trip
selector routing
XOR-0x80 mirror
Hamming [7,4,3]
single-error correction
double-error trapping
Algorithmic Clock
centroid-relative synchronization
origin-preserving coproduct
COBS zero trapping
CONS recovery
ESP32 gossip
boot envelope
BASE(n) parsing
media bridge
Metatron pre-closure
Pascal Layer-4 multiplicity
binary export invariance
visual spatial projection
Lagrange fold/unfold projection
```

The bounded Miquel `[8,4,4]` extended parity law is checked by mandatory
algorithmic conformance. Broader physical or geometric interpretations remain
outside that executable law unless separately lowered into deterministic
vectors.

## 21. Summary Architecture

The complete architecture can be expressed as:

```text
B = Q8 x Delta3 x I3 x N16
```

where:

```text
Q8
  eight Blackboard routing quadrants

Delta3
  LL, MM, NN temporal positions

I3
  LOGOS, NOMOS, PATHOS integrity dimensions

N16
  unbounded natural annotation distance represented by four-bit carry
```

The local nibble is:

```text
nu(a) = a mod 16
```

The Circular Slide Ruler phase is:

```text
phi(a) = a mod 60
```

The combined clockwork state is:

```text
C(a) = (a mod 16, a mod 60)
```

with exact realignment every:

```text
240
```

The analog weighting function is:

```text
w(a) = PascalLayer4Weight(a mod 16)
```

and the temporal-integrity tensor is:

```text
W_a =
[ L_LL(a)  L_MM(a)  L_NN(a) ]
[ N_LL(a)  N_MM(a)  N_NN(a) ]
[ P_LL(a)  P_MM(a)  P_NN(a) ]
```

## Conclusion

Omino defines a deterministic symbolic architecture in which finite local
mechanisms support an indefinitely extensible annotation path.

Four-bit carry-forward provides the annotation address. The compact and extended
Hamming branches provide local integrity routing. LOGOS, NOMOS, and PATHOS
provide three independent integrity dimensions. LL, MM, and NN place successive
checked cells in time. Pascal Layer-4 multiplicities provide analog entrainment
weights. The 60-point Circular Slide Ruler embeds each annotation into a finite
phase. The nibble and ruler jointly realign every 240 steps. OMNION fixes the
projective centroid. The Blackboard quadrant selects local or remote routing.
Validation accepts, attestation records, and projection remains inert.

The architecture's defining discipline is separation:

```text
source is not projection
integrity is not truth
recovery is not validation
routing is not acceptance
weight is not identity
orientation is not authority
clock advancement is not physical time
attestation is not display
```

Within those boundaries, Omino provides a coherent bridge between symbolic Lisp
structure, error-correcting incidence geometry, deterministic logical clocks,
bounded hardware carriers, analog-style entrainment, decentralized
synchronization, and reproducible native visualizations.
