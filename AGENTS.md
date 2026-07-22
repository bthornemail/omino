# OMI Core Agent Mandate

This repository is not an ordinary application framework. Treat the OMI core as
algorithmic determinism only. Everything else approaches from the outside in as
form, carrier, adapter, scaffold, proof document, backend, view, or test.

## Core Determinism Boundary

For the same declared input and starting coordinate, the core must produce the
same output coordinate.

The core may contain only:

- fixed-width values
- declared coordinate domains
- exact bitwise transforms
- bounded rotations
- deterministic carry
- deterministic Circular Slide Ruler advancement
- deterministic incidence mapping
- deterministic relation closure
- deterministic projection orientation
- deterministic runtime resolution

The core must not depend on wall-clock time, randomness, probability,
heuristics, machine learning, user identity, network state, filesystem state,
environment variables, database state, thread scheduling, external policy, or
human interpretation.

## Canonical Component Names

Use canonical names when a canonical component already exists. Do not replace
them with generic labels.

- `TetragrammatronRelationGovernor` closes relation.
- `MetatronIncidenceScribe` scribes gauge incidence and carry.
- `GnomonicProjectionAzimuth` orients balanced projected contrast.
- `OmicronGauge` defines the bounded low gauge.
- `OmnicronResolver` resolves the full low/high circular runtime.
- `omino` fixes the 0-degree azimuth centroid and selects orientation.
- `AlgorithmicClock` advances the Circular Slide Ruler Array.

## Unified OMI-System Nomenclature

```text
omnicron-object-model
  Master Four-Plane Circular Runtime Resolver

omi-object-model
  15 formal files surrounding the 0-degree azimuth centroid

omino
  poly-omino atom / self-contained 16-bit word-axis substrate
```

An `omino` belongs to the `omi-object-model` and is executed and interpreted
by the `omnicron-object-model`.

Preferred C-style prefixes:

```text
tetra_relation_*
metatron_incidence_*
gnomonic_azimuth_*
omicron_gauge_*
omnicron_resolver_*
```

## Witness Ownership Lock

Do not transfer a witness to another component merely because an implementation
uses the same XOR, shift, mask, or word width.

```text
0x1E, 0x3C, 0x78
  Tetragrammatron Relation Governor

0x18
0x0001, 0x0010, 0x0100, 0x1000, 0x10000
  Metatron Incidence Scribe

0xAA55, 0x55AA, 0xFFFF
  Gnomonic Projection Azimuth

0x00..0x7F
  Omicron Gauge

0x00..0xFF four-plane runtime
  Omnicron Runtime Resolver
```

## Circular Slide Ruler Names

Use these exact structural names:

```text
omino Tile
Local240 Blackboard Face
Blackboard Quadrant
Circular Slide Ruler
Circular Ruler Position
Algorithmic Clock
omino Centroid
LOGOS / NOMOS / PATHOS
LL / MM / NN
FS / GS / RS / US
User-Local / CAR
User-Remote / CDR
```

The hosted structure is:

```text
One omino Tile
└── 16 Blackboard Face Planes
└── 18 Local240 Blackboard Faces
    └── 4 Blackboard Quadrants per face
        └── 1 Circular Slide Ruler per quadrant
            └── 60 Circular Ruler Positions
```

Therefore:

```text
18 Local240 Blackboard Faces
* 4 Circular Slide Rulers
= 72 Circular Slide Rulers inside one omino tile

72 Circular Slide Rulers
* 60 Circular Ruler Positions
= 4,320 local incidences inside one omino tile
```

The 4,320 local incidences are not distributed across program memory, object
arrays, worker grids, or iterated runtime tables. They are the local coordinate
surface of one unified omino tile context.

## Prohibited Drift

Do not rename this hierarchy with generic validation, state, metadata,
database, worker-grid, resolution, or orientation labels unless discussing a
noncanonical analogy and labeling it explicitly as an analogy.

Do not add name binders, macro systems, type elaboration passes, policy engines,
or hidden mutation to the core. Bounded control flow is permitted for parsing,
bounds checks, buffer checks, diagnostics, tests, and adapters. Inner arithmetic
kernels should stay direct, fixed-width, and bitwise.

## Existing-Code Preservation

Architectural simplification does not authorize destructive repository-wide
removal. Do not delete parsers, evaluators, validators, type scaffolds, views,
or tests merely because they use conventional engineering style. First determine
whether they are required by another repository surface.

Work in this repository is integration, implementation, generation,
verification, packaging, and documentation. Do not redesign OMI, Emergent Axial
Lisp, `.o`, LOGOS/NOMOS/PATHOS, omino, COBS, CONS, or selector geometry.
