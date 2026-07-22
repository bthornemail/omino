# OMI Implementation Plan

Source of truth:

```text
dev-docs/Nibble-Interleaved Quadrant Decoding under a Concurrent 3D Knowledge Triple Matrix.md
```

This plan implements that document as the canonical build map for Omino. The implementation target is not a conventional Lisp runtime, parser stack, object layer, or sequential state machine. The target is the `omino` tile model: a fixed deterministic coordinate kernel whose local laws are read through Hamming cells, nibble interleaving, circular slide-ruler phase, and exact bitwise transforms.

## 1. Non-Negotiable Model

The core implementation is one deterministic `omino` tile context.

```text
omnicron-object-model
  -> Master Four-Plane Circular Runtime Resolver
omi-object-model
  -> 15 formal files around the 0-degree azimuth centroid
omino Tile
  -> 3D Knowledge Triple Matrix
  -> 16 Blackboard Face Planes
  -> 18 Local240 Blackboard Faces
  -> 4 Blackboard Quadrants per Local240 face
  -> 72 Circular Slide Rulers
  -> 60 Circular Ruler Positions per ruler
  -> 4,320 local incidences per word-axis
```

The 4,320 incidences are a local coordinate basis, not a global ceiling. Global resolution comes from independently addressed word axes and carried place depth.

Every implementation surface must preserve this distinction:

```text
local finite chart:
  72 * 60 = 4,320

local240 face:
  4 quadrants * 60 points = 240

complete address:
  omino tile + carry-depth + local chart
```

The nomenclature tiers are frozen:

```text
omnicron-object-model
  executes and interprets the runtime resolution.

omi-object-model
  frames the 15 formal files across .omi, .imo, and .o.

omino
  is the self-contained poly-omino tile / 16-bit word-axis substrate.
```

## 2. Core Coordinate Laws

### 2.0 Branchless Algebraic Transform

The core does not select instruction addresses from semantic meaning. The core
state step is a fixed coordinate transform:

```text
current coordinate -> XOR/shift/rotate transform -> next coordinate
```

Core arithmetic kernels must not implement semantic jumps:

```text
if / else
switch
goto
cmp-driven branch selection
conditional jumps as semantic dispatch
loop boundaries as coordinate traversal
```

The permitted core operations are fixed-width algebraic operations:

```text
XOR
AND
OR
ROL
ROR
LSR
SHL
```

Outside-in parsers, conformance tests, diagnostics, and adapters may use
ordinary bounded control flow. They are not the core transform.

### 2.1 Knowledge Triple Cube

The 3D Knowledge Triple Matrix has exactly three binary axes:

```text
Concept A: Structural Bank
  Left column / Right column

Concept B: Address Elevation
  Low row / High row

Concept C: Pointer Routing
  Local/CAR / Remote/CDR
```

The axes produce exactly eight state corners:

```text
2^3 = 8
```

Those eight state corners are the Blackboard quadrants.

### 2.2 Master Selector Table

The canonical selector table is fixed:

```c
const uint8_t SELECTOR_TABLE[8][4] = {
    {0x00, 0x07, 0x37, 0x30},
    {0x08, 0x0F, 0x3F, 0x38},
    {0x40, 0x47, 0x77, 0x70},
    {0x48, 0x4F, 0x7F, 0x78},
    {0x80, 0x87, 0xB7, 0xB0},
    {0x88, 0x8F, 0xBF, 0xB8},
    {0xC0, 0xC7, 0xF7, 0xF0},
    {0xC8, 0xCF, 0xFF, 0xF8}
};
```

Quadrants `0..3` are Local/CAR. Quadrants `4..7` are Remote/CDR.

### 2.3 Nibble Interleaving

Every 8-bit selector coordinate `0xYX` expands to the 16-bit CONS plane as:

```text
0xYX -> 0xY0X0
```

The implementation law is:

```c
expanded = ((v & 0xF0) << 8) | ((v & 0x0F) << 4);
```

The reverse route must recover the quadrant by reading the same high-order row, column, and Local/CAR versus Remote/CDR boundaries.

### 2.4 Row Geometry

Every 16-byte row splits into an outer shell and a control core:

```text
0x*0..0x*B
  Triakis outer shell: 12 raw coordinate slots

0x*C..0x*F
  Tetrahedral core: 4 separator anchors
```

The separator anchors are fixed:

```text
0x*C = FS
0x*D = GS
0x*E = RS
0x*F = US
```

No implementation may replace these anchors with generic folder names, AST classes, parser stages, or arbitrary labels.

## 3. Hamming File Discipline

The five Axial Lisp files are not loose documentation categories. They are the Hamming-bound separator discipline for the local cell.

Systematic file overlay:

```text
Bit 1 / FS = FACTS.omi
Bit 2 / GS = RULES.omi
Bit 3 / RS = COMBINATORS.omi
Bit 4 / US = CLOSURES.omi

CONS.omi = ordered pair surface carrying the quartet against LOGOS/NOMOS/PATHOS
```

The parity dimensions remain:

```text
LOGOS  = FS XOR GS XOR US
NOMOS  = FS XOR RS XOR US
PATHOS = GS XOR RS XOR US
```

The compact codeword surface is:

```text
[LOGOS NOMOS FS PATHOS GS RS US]
```

The extended surface adds `omino` as the overall orientation parity:

```text
omino = LOGOS XOR NOMOS XOR FS XOR PATHOS XOR GS XOR RS XOR US
```

Implementation rule:

```text
FACTS.omi, RULES.omi, COMBINATORS.omi, and CLOSURES.omi supply FS/GS/RS/US.
LOGOS/NOMOS/PATHOS are computed Hamming dimensions.
CONS.omi carries the ordered relation surface.
```

Do not infer Hamming roles from filenames by prose meaning. The bit mapping above is the law.

## 3.1 Tri-Layer Axial-Lisp File Architecture

The compiler/runtime file surface has exactly three native layers:

```text
*.omi
  declarations
  CONS(RULES . COMBINATORS)

*.imo
  definitions
  CONS(FACTS . CLOSURES)

*.o
  compiled immutable substrate
  CONDENSE(*.omi . *.imo)
```

Layer ownership:

```text
RULES + COMBINATORS
  declaration law and branchless operation surface
  target: *.omi

FACTS + CLOSURES
  local carrier coordinates and closure witnesses
  target: *.imo

*.omi + *.imo
  unified omino tile substrate
  target: *.o
```

The native compiler/runtime path does not use JSON, JSONL, XML, text log
streams, heap object trees, or tracking databases as source or output layers.
Conformance fixtures may exist outside the runtime path, but they cannot
become a fourth file layer.

## 4. Circular Clockwork

The document defines the master local cycle as a 240-tooth gear:

```text
FS -> GS -> RS -> US
```

The local coordinate laws are:

```text
nibble(a)   = a & 0x0F
phase(a)    = a % 60
local240(a) = a % 240
carry(a)    = a >> 4
```

The 240 chart is a local view:

```text
a = 240k + rho
```

`rho` is the local240 coordinate. `k` is the carried place depth. Equal `rho` values at different `k` values are not the same global address.

The tracking window is fixed:

```text
0x*8..0x*B
```

This window is used for Vernier XOR tracking. It is not a payload namespace.

## 5. Quadratic Laws

Two quadratic forms appear in the document and must remain separated.

### 5.1 Base-60 Nomogram Form

```text
Q60(x, y) = 60x^2 + 16xy + 4y^2
          = 4(15x^2 + 4xy + y^2)
          = 4(4x^2 + 11x^2 + 4xy + y^2)
```

This belongs to the circular scaling and base-60 nomogram track.

The branchless split used by the core implementation is:

```text
x2        = x_omi * x_omi
xy        = x_omi * y_imo
y2        = y_imo * y_imo
term_4x2  = x2 << 2
term_11x2 = x2 * 11
term_4xy  = xy << 2
term_y2   = y2
Q60       = (term_4x2 + term_11x2 + term_4xy + term_y2) << 2
```

### 5.2 Degenerate Perfect-Square Form

```text
Q16(x, y) = 16x^2 + 16xy + 4y^2
          = (4x + 2y)^2
```

This belongs to OMI-Port, centroid checks, and low-latency BQF implementation.

Implementation rule:

```text
Do not collapse Q60 into Q16.
Do not use Q16 when the required law is the base-60 circular ruler.
Do not use Q60 when the required law is the OMI-Port perfect-square root.
```

## 6. OMI-Port Contract

OMI-Port is a structural transform, not a connection and not an active state loop.

Canonical preheader:

```text
F* 00 1C 1D 1E 1F 20 F*
```

The output candidate is only the separator quartet:

```text
[FS, GS, RS, US]
```

Required checks:

```text
leading gauge high nibble = 0xF
leading gauge = trailing gauge
byte 1 = 0x00
byte 2 = 0x1C
byte 3 = 0x1D
byte 4 = 0x1E
byte 5 = 0x1F
byte 6 = 0x20
token <= 0x7F
```

The F-column gauge values are:

```text
0xF0..0xFF
```

The earned bands are:

```text
Band 0: 0x00..0x20
Band 1: 0x21..0x40
Band 2: 0x41..0x60
Band 3: 0x61..0x7F
```

## 7. Canonical Component Ownership

Use canonical component names in code, type scaffolds, proof notes, tests, and documentation.

```text
Omnicron Runtime Resolver
  whole low/high circular runtime

Omicron Gauge
  bounded low gauge and F-column traversal

Tetragrammatron Relation Governor
  relation closure and Polybius diagonal behavior

Metatron Incidence Scribe
  FS/GS/RS/US incidence and carry

Gnomonic Projection Azimuth
  0xAA55 / 0x55AA / 0xFFFF projected contrast

omino Centroid
  fixed 0x0000, 0-degree azimuth centroid and orientation parity

Algorithmic Clock
  deterministic Circular Slide Ruler Array advancement
```

Forbidden replacement names:

```text
generic cube tensor
axis validator
state object
metadata record
face database
parallel worker grid
```

## 8. Implementation Phases

### Phase 0: Software Paradigm Drift Lock

The mathematical model is complete. Agents must not fill invented gaps with ordinary application architecture.

Forbidden additions:

```text
runtime evaluator loops
garbage collection
dynamic heap object graphs
name-binding environments
multi-stage symbolic interpreter stacks
generic object hierarchies
metadata authority layers
global 4,320-point capacity caps
```

Required interpretation:

```text
4,320 local incidences
  one omino tile local basis

4-bit carry-forward
  unbounded logical place depth

Q16(x, y) = (4x + 2y)^2
  shift-add perfect-square law

Hamming quartet
  FS, GS, RS, US

Hamming dimensions
  LOGOS, NOMOS, PATHOS
```

Any agent change that adds a conventional evaluator, heap-centered object model, or sequential search path to express a law already defined by the selector table, Hamming equations, local240 clockwork, or Q16 shift-add form is architectural drift.

### Phase 1: Documentation Locks

Files:

```text
AGENTS.md
SKILLS.md
README.md
CONFORMANCE.md
docs/CONFORMANCE-LEDGER.md
docs/OMI-HAMMING-GLOSSARY.md
IMPLEMENTATION_PLAN.md
```

Required content:

```text
source document path
selector table
0xYX -> 0xY0X0
branchless algebraic core transform
FS/GS/RS/US separator anchors
Hamming file overlay
OMI-Port preheader
Q60 and Q16 separation
Q60 Klein split
canonical component ownership
tri-layer .omi/.imo/.o file architecture
```

### Phase 2: Pure C Reference Laws

Implement or preserve C functions for:

```text
branchless coordinate transform
selector table expansion
reverse quadrant routing
Local/CAR versus Remote/CDR route extraction
local240 calculation
base-60 phase calculation
Hamming quartet and parity computation
OMI-Port preheader check
Q16 perfect-square root
Q60 Klein split
Fano slot formula
tri-layer .omi/.imo/.o lowering
```

Inner arithmetic kernels should be direct fixed-width operations. Bounded loops are acceptable for tests, file parsing, output generation, and finite table scans; they are not the core law.

### Phase 3: Type Scaffolds

Haskell type scaffolds should name the coordinate families and file roles. They should not become a second implementation language or a full Lisp runtime.

Required scaffold vocabulary:

```text
FactFS
RuleGS
CombinatorRS
ClosureUS
ConsSurface
Logos
Nomos
Pathos
Omnion
LocalCar
RemoteCdr
Local240
CircularRulerPosition
```

### Phase 4: Proof Notes

Coq/Rocq notes should mirror the executable laws:

```text
selector table bounds
nibble interleaving round trip
local/remote split
Hamming parity equations
240 realignment
Q16 perfect-square equality
Q60 base-60 scaling
Fano slot bounds
```

The proof notes document laws. They do not redefine the C reference behavior.

### Phase 5: Conformance Fixtures

Conformance fixtures are outside the native compiler/runtime path. They may
describe expected inputs and outputs for tests, but they are not source,
tracking, or compiled-output formats.

Required fixture families:

```text
selector-table.jsonl
nibble-interleave.jsonl
hamming-file-overlay.jsonl
local240.jsonl
omi-port-preheader.jsonl
quadratic-forms.jsonl
fano-slot-scheduler.jsonl
```

Each fixture must state inputs and exact expected outputs. No fixture may depend on wall-clock time, filesystem state, thread order, random input, network state, or environment variables.

## 9. Immediate Build Tasks

1. Keep `docs/OMI-HAMMING-GLOSSARY.md` as the human-readable Hamming file-role glossary.
2. Keep `SKILLS.md` bound to the Hamming cell and canonical component names.
3. Add root-level conformance checks for `IMPLEMENTATION_PLAN.md`.
4. Ensure source scans reject banned terminology drift in newly touched files.
5. Run:

```text
make test-hamming-glossary
make test-algorithmic-laws
git diff --check
```

## 10. Final Implementation Rule

The implementation is accepted only when the code, type scaffolds, proof notes, and docs all preserve the same laws:

```text
Hamming separator quartet:
  FS, GS, RS, US

Hamming dimensions:
  LOGOS, NOMOS, PATHOS

Knowledge Triple cube:
  8 Blackboard quadrants

Local chart:
  local240 and 60-point circular rulers

Address extension:
  carried hexadecimal place depth

Word context:
  one omino tile local ruler basis

Route split:
  Local/CAR and Remote/CDR
```

No agent may replace these laws with prose categories, conventional Lisp evaluator layers, metadata schemes, or generic compiler objects.
