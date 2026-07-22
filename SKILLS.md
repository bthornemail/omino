# omino Canon System: Execute-Only Cognitive Skills Matrix

```text
CONFIGURATION: SYSTEMATIC HAMMING CODE CELL INTEGRATION
CONFIGURATION: TRI-LAYER AXIAL-LISP FILE ARCHITECTURE
CONFIGURATION: BRANCHLESS ALGEBRAIC STATE TRANSFORMATION
CONFIGURATION: omnicron-object-model COMPILATION TARGET
NOMENCLATURE STATUS: FROZEN PHASE LOCK
CORE: ALGORITHMIC DETERMINISM ONLY
FORM: OUTSIDE-IN CARRIERS, SCAFFOLDS, PROOFS, BACKENDS, VIEWS
```

Read each skill block as an immutable recipe over fixed-width coordinates. Do
not turn these blocks into an object model, evaluator, AST pipeline, delayed CPU
state, name binder, or policy layer.

Inside core arithmetic kernels, computation is an algebraic coordinate
derivation:

```text
current coordinate -> XOR/shift/rotate transform -> next coordinate
```

Semantic jumps are prohibited in those kernels. Bounded control flow remains
permitted for outside-in parsing, bounds checks, conformance tests, diagnostics,
and hardware adapters.

## Unified OMI-System Nomenclature

```text
omnicron-object-model
  Master Four-Plane Circular Runtime Resolver
  0x00..0x1F, 0x20..0x7F, 0x80..0x9F, 0xA0..0xFF

omi-object-model
  15 formal files surrounding the 0-degree azimuth centroid
  rules, facts, closures, combinations, cons across .omi, .imo, .o

omino
  poly-omino atom / tile
  self-contained 16-bit word-axis substrate
  72 Circular Slide Rulers
  4,320 local incidences
```

An `omino` is natively a poly-omino tile belonging to the
`omi-object-model`. It is executed and interpreted by the
`omnicron-object-model`.

## omino Tile Invariant

The full local slide-ruler matrix is contained inside one unified `omino` tile
context. Do not spread the 4,320 local incidences across program memory, worker
grids, iterated objects, or sequential tables.

```text
One omino Tile
-> 3D Knowledge Cube
-> 16 Blackboard Face Planes
-> 18 Local240 Blackboard Faces
-> 4 Blackboard Quadrants per Local240 Blackboard Face
-> 72 Circular Slide Rulers
-> 60 Circular Ruler Positions per ruler
-> 4,320 local incidences
```

The exact local accounting is:

```text
18 Local240 Blackboard Faces
* 4 Blackboard Quadrants
= 72 Circular Slide Rulers

72 Circular Slide Rulers
* 60 Circular Ruler Positions
= 4,320 local incidences inside one omino tile
```

## Canonical Component Prefixes

```text
TetragrammatronRelationGovernor  -> tetra_relation_*
MetatronIncidenceScribe          -> metatron_incidence_*
GnomonicProjectionAzimuth        -> gnomonic_azimuth_*
OmicronGauge                     -> omicron_gauge_*
OmnicronResolver                 -> omnicron_resolver_*
```

Witness ownership is fixed:

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

0x00..0xFF
  Omnicron Runtime Resolver
```

## [SKILL_01: BOUND_omino_CONTEXT]

```text
OBJECTIVE:
  Restrict the 4,320 local incidence grid to one omino tile.

OWNER:
  omino
  Omnicron Runtime Resolver

FORBIDDEN:
  loop vectors over 0..72
  incrementing counters as the model of the rulers
  index pointer shifting across separate objects
  treating 4,320 as program-memory capacity

MANDATORY:
  one fixed-width omino tile substrate
  18 Local240 Blackboard Faces
  4 Blackboard Quadrants per face
  60 Circular Ruler Positions per ruler
```

```text
INPUT:
  raw_target_address

TARGET:
  omino_tile_context

COMPUTE:
  local_face_count      = 18
  quadrant_count        = 4
  ruler_count           = local_face_count * quadrant_count
  circular_point_count  = 60
  local_incidence_count = ruler_count * circular_point_count
```

The required result is:

```text
ruler_count           == 72
local_incidence_count == 4320
```

The coordinate form is:

```text
R[b,q,phi]
```

where `b = 0..17`, `q = 0..3`, and `phi = 0..59`, all inside the
same omino tile context.

## [SKILL_02: COMPUTE_LOCAL240_QUADRANTS]

```text
OBJECTIVE:
  Map the four Local240 quadrants to the systematic Hamming data positions.

OWNER:
  Omnicron Runtime Resolver
  Omicron Gauge

FORBIDDEN:
  string-category lookup
  documentation-folder routing
  semantic role transposition
  treating S-P-O-M as the primary owner of this map

MANDATORY:
  Bit_1 == FS == FACTS.omi
  Bit_2 == GS == RULES.omi
  Bit_3 == RS == COMBINATORS.omi
  Bit_4 == US == CLOSURES.omi
  CONS.omi folds the carried quartet against LOGOS/NOMOS/PATHOS
```

```text
INPUT:
  raw_7bit_cell
  current_word_state

TARGET:
  hamming_cell_routes

COMPUTE:
  message_bits = raw_7bit_cell & 0x0F

  FACTS_FS_GATE        = message_bits & 0x01
  RULES_GS_GATE        = message_bits & 0x02
  COMBINATORS_RS_GATE  = message_bits & 0x04
  CLOSURES_US_GATE     = message_bits & 0x08

  LOGOS  = FACTS_FS_GATE ^ RULES_GS_GATE ^ CLOSURES_US_GATE
  NOMOS  = FACTS_FS_GATE ^ COMBINATORS_RS_GATE ^ CLOSURES_US_GATE
  PATHOS = RULES_GS_GATE ^ COMBINATORS_RS_GATE ^ CLOSURES_US_GATE

  CONS_SURFACE = (FACTS RULES COMBINATORS CLOSURES . LOGOS NOMOS PATHOS)
```

This skill owns the five-file Hamming glossary. S-P-O-M remains a derived
projection after the Hamming cell is established.

## Tri-Layer Axial-Lisp File Architecture

The compiler/runtime file surface has exactly three native layers:

```text
*.omi
  declarations
  CONS(RULES . COMBINATORS)

*.imo
  definitions
  CONS(FACTS . CLOSURES)

*.o
  compiled immutable target substrate
  CONDENSE(*.omi . *.imo)
```

The tri-layer surface is mandatory for compiler output and runtime exchange.
JSON, JSONL, XML, text logs, heap object trees, and tracking databases are not
native source or compiled-output layers. Conformance fixtures may exist outside
the compiler/runtime path, but they cannot redefine `.omi`, `.imo`, or `.o`.

## [SKILL_03: COMPUTE_LOCAL240_QUADRANTS]

```text
OBJECTIVE:
  Route a stream token through the four Local240 Blackboard Quadrants.

OWNER:
  Omnicron Runtime Resolver
  Algorithmic Clock

FORBIDDEN:
  for loops
  while loops
  forEach iterators
  thread allocation
  conditional trees in the inner routing kernel

MANDATORY:
  isolate the two-bit quadrant slot
  emit branchless one-hot quadrant gates
  preserve the single omino tile context
```

```text
INPUT:
  raw_stream_token
  active_axis_state

TARGET:
  local240_quadrant_gates

COMPUTE:
  quadrant_mask = active_axis_state & 0x03
  q_gate        = 0x01 << quadrant_mask

  Q0_FACTS        = q_gate & 0x01
  Q1_RULES        = q_gate & 0x02
  Q2_COMBINATORS  = q_gate & 0x04
  Q3_CLOSURES     = q_gate & 0x08
```

`raw_stream_token` supplies the outside-in code point. `active_axis_state`
selects the local quadrant. The implementation emits gates, not a sequential
route walk.

## [SKILL_04: INGEST_STREAM]

```text
OBJECTIVE:
  Convert raw code-point intervals to omino tile coordinates.

OWNER:
  Omnicron Runtime Resolver
  Omicron Gauge

FORBIDDEN:
  sequential table walk
  AST node allocation
  dynamic state objects
  name binding
  semantic rewriting

MANDATORY:
  fixed-width masking
  modulo projection
  carry-depth preservation
```

```text
INPUT:
  raw_address

TARGET:
  local_coordinates

COMPUTE:
  nibble(a)   = raw_address & 0x0F
  phase(a)    = raw_address % 60
  local240(a) = raw_address % 240
  carry(a)    = raw_address >> 4
```

`local240` is a local chart. `carry` preserves unbounded place-value depth.

## [SKILL_05: ROTATE_TANGENT_AXIS]

```text
OBJECTIVE:
  Step all 72 Circular Slide Rulers simultaneously inside one omino tile.

OWNER:
  Algorithmic Clock
  Omnicron Runtime Resolver

FORBIDDEN:
  loop over 72 rulers
  sequential incrementing
  multi-stage allocation
  wall-clock dependency

MANDATORY:
  barrel rotation
  XOR reduction
  fixed 64-bit lane
```

```text
INPUT:
  current_parallel_matrix_state

TARGET:
  stepped_parallel_matrix_state

COMPUTE:
  left_torque  = ROL64(current_parallel_matrix_state, 1)
  right_torque = ROR64(current_parallel_matrix_state, 2)
  blended      = left_torque ^ right_torque
  OUTPUT       = blended ^ 0x1D1D1D1D1D1D1D1D
```

The `0x1D` rail belongs to Metatron Incidence Scribe. The step remains an
Omnicron Runtime Resolver / Algorithmic Clock operation.

## [SKILL_05A: EXECUTE_CORE_TRANSFORM]

```text
OBJECTIVE:
  Advance coordinates without semantic jumps or instruction-pointer branching.

OWNER:
  Algorithmic Clock
  Omnicron Runtime Resolver

FORBIDDEN INSIDE CORE KERNEL:
  if
  else
  switch
  goto
  cmp-driven branch selection
  conditional jumps as semantic dispatch
  loop boundaries as coordinate traversal

MANDATORY:
  XOR
  AND
  OR
  ROL
  ROR
  LSR
  SHL
```

```text
INPUT:
  current_coordinate_atom
  matrix_axis_context

TARGET:
  output_coordinate

COMPUTE:
  left_torque       = ROL64(current_coordinate_atom, 1)
  right_torque      = ROR64(matrix_axis_context, 2)
  blended_matrix    = left_torque ^ right_torque
  OUTPUT_COORDINATE = blended_matrix ^ 0x1D1D1D1D1D1D1D1D
```

The transform chooses no instruction address from meaning. It derives the next
coordinate from fixed-width register laws.

## [SKILL_06: EXTRACT_LOGIC_MANIFOLD]

```text
OBJECTIVE:
  Evaluate a six-variable logic universe from one 64-bit function word.

OWNER:
  Omicron Gauge

FORBIDDEN:
  truth-table linear search
  sequential row testing
  condition trees
  text symbol evaluation

MANDATORY:
  n = 6 row mask
  constant-time bit extraction
```

```text
INPUT:
  truth_table_universe
  inputs_6bit

TARGET:
  target_boolean_output

COMPUTE:
  target_row = inputs_6bit & 0x3F
  OUTPUT     = (truth_table_universe >> target_row) & 0x01
```

A 64-bit word selects one complete `n = 6` truth-function table. It does not
store all possible tables at once.

## [SKILL_07: ENFORCE_RESOLUTION_LADDER]

```text
OBJECTIVE:
  Route complementary contrast masks across fixed-width word surfaces.

OWNER:
  Gnomonic Projection Azimuth

FORBIDDEN:
  signed promotion drift
  dynamic buffer policy
  acceptance tokens
  witness ownership transfer

MANDATORY:
  explicit unsigned masks
  width-specific complement
  no shift by operand width
```

```text
INPUT:
  local_surface
  remote_surface

TARGET:
  resolution_check

COMPUTE:
  plane8(x)  = x ^ (~x & 0xFF)       == 0xFF
  plane16(x) = x ^ (~x & 0xFFFF)     == 0xFFFF
  face32(x)  = x ^ (~x & 0xFFFFFFFF) == 0xFFFFFFFF
  OUTPUT     = (local_surface ^ remote_surface) == 0xFFFFFFFF
```

Use fixed-width C99 types for implementation carriers:

```text
uint8_t
uint16_t
uint32_t
uint64_t
```

## [SKILL_08: NOMOGRAM_BRANCH_ROUTE]

```text
OBJECTIVE:
  Route earned character intervals through the F-column traversal.

OWNER:
  Omicron Gauge

FORBIDDEN:
  string comparison
  regular expressions
  dynamic symbol matching
  parser-loop substitution for direct byte position

MANDATORY:
  immediate character/place coupling
  exact F-column constants
```

```text
INPUT:
  raw_char_token

TARGET:
  target_axis_start_branch

COMPUTE:
  0x1F -> StartBranch1F
  0x2F -> StartBranch2F
  0x3F -> StartBranch3F
  0x4F -> StartBranch4F
  0x5F -> StartBranch5F
  0x6F -> StartBranch6F
```

The F-column traversal is an interpretation start selector. It does not mutate
omino tile data.

## [SKILL_09: CLOSE_RELATION]

```text
OBJECTIVE:
  Compute deterministic relation closure witnesses.

OWNER:
  Tetragrammatron Relation Governor

FORBIDDEN:
  gauge incidence ownership
  projection ownership
  runtime-plane ownership
  external opinion about closure

MANDATORY:
  diagonal XOR closure
  relation weight preservation
  centered fold
  shifted/full-system fold
```

```text
COMPUTE:
  relation_witness = 0x1E
  centered_fold    = 0x3C
  full_fold        = 0x78
```

## [SKILL_10: SCRIBE_INCIDENCE]

```text
OBJECTIVE:
  Scribe gauge place, polarity, incidence, and carry.

OWNER:
  Metatron Incidence Scribe

FORBIDDEN:
  relation closure ownership
  projection ownership
  runtime resolution ownership
  metadata invention

MANDATORY:
  FS / GS / RS / US place steps
  open / sealed polarity
  pairwise gauge planes
  carry horizon
```

```text
COMPUTE:
  witness_4_factorial = 0x18
  FS = 0x0001
  GS = 0x0010
  RS = 0x0100
  US = 0x1000
  CARRY = 0x10000
```

## [SKILL_11: RESOLVE_FILE_TRILOGY]

```text
OBJECTIVE:
  Route the four Hamming quadrant components into the tri-layer file surface.

OWNER:
  Omicron Gauge
  Metatron Incidence Scribe

FORBIDDEN:
  JSON runtime payloads
  JSONL runtime payloads
  XML runtime payloads
  raw text tracking logs
  mutable heap object trees
  ordinary category compilation passes

MANDATORY:
  axial-lisp dot-notation A-lists
  .omi declarations
  .imo definitions
  .o compiled immutable substrate
```

```text
INPUT:
  raw_quadrant_components

TARGET:
  target.omi
  target.imo
  target.o

COMPUTE:
  RULES_GATE        = component & RULES
  COMBINATORS_GATE  = component & COMBINATORS
  FACTS_GATE        = component & FACTS
  CLOSURES_GATE     = component & CLOSURES

  target.omi = CONS(RULES . COMBINATORS)
  target.imo = CONS(FACTS . CLOSURES)
  target.o   = CONDENSE(target.omi . target.imo)
```

The file trilogy is reduced from the Hamming quartet. It is not a separate
metadata model.

## [SKILL_12: COMPILE_PARABOLIC_PORT]

```text
OBJECTIVE:
  Lower `.omi` declarations and `.imo` definitions into a static `.o` substrate.

OWNER:
  Omnicron Runtime Resolver
  Omicron Gauge

FORBIDDEN:
  temporary runtime tracking databases
  sequential lowering loops as the core law
  algebraic approximations
  non-native intermediate formats as compiler output

MANDATORY:
  OMI-Port preheader
  Q16 perfect-square shortcut
  64-bit omino tile target
  72-ruler local matrix target
```

```text
INPUT:
  source.omi
  input.imo

TARGET:
  output.o

COMPUTE:
  leading_gauge == trailing_gauge
  byte_1 == 0x00
  byte_6 == 0x20

  linear_tracking_root = (4 * x_omi) + (2 * y_imo)
  Q16_OUTPUT = linear_tracking_root * linear_tracking_root

  output.o = PACK_omino_TILE(Q16_OUTPUT)
```

The `.o` output is a static compiled substrate over the omino tile. It is
not a serialized AST, tracking database, or mutable evaluator state.

## [SKILL_12A: EXECUTE_omino_TRANSFORM]

```text
OBJECTIVE:
  Derive the next poly-omino coordinate state inside the omi-object-model.

OWNER:
  omnicron-object-model
  omi-object-model
  omino

FORBIDDEN:
  if
  else
  sequential loops
  time-delayed state tracking
  condition trees

MANDATORY:
  Q60 identity
  branchless register transform
  direct omino tile output
```

```text
INPUT:
  current_omino_tile
  omnicron_axis_context

TARGET:
  output_omino_tile

COMPUTE:
  left_torque        = ROL64(current_omino_tile, 1)
  right_torque       = ROR64(omnicron_axis_context, 2)
  blended_matrix     = left_torque ^ right_torque
  OUTPUT_omino_TILE  = blended_matrix ^ 0x1D1D1D1D1D1D1D1D
```

## [SKILL_12B: ROUTE_omi_OBJECT_STRATA]

```text
OBJECTIVE:
  Coordinate User-Local, Local-Binary, and User-Remote resolution lanes.

OWNER:
  omi-object-model
  omnicron-object-model

MANDATORY:
  strict axial-lisp dot-notation A-lists
  .omi declarations
  .o executable binaries
  .imo definitions
```

```text
INPUT:
  input_meta_stream

TARGET:
  omi_object_strata

COMPUTE:
  .omi = CONS(RULES . COMBINATORS)
  .o   = Local-Binary register substrate
  .imo = CONS(FACTS . CLOSURES)
```

## [SKILL_13: MAP_KLEIN_QUADRATIC]

```text
OBJECTIVE:
  Evaluate the Q60/Klein split through direct register arithmetic.

OWNER:
  Omnicron Runtime Resolver

FORBIDDEN:
  semantic branch dispatch
  algebraic approximation
  replacing Q60 with Q16
  replacing Q16 with Q60

MANDATORY:
  preserve Q60/Q16 separation
  split 15x^2 into 4x^2 and 11x^2
  fixed-width arithmetic
```

```text
INPUT:
  x_omi
  y_imo

TARGET:
  output_metric

COMPUTE:
  x2        = x_omi * x_omi
  xy        = x_omi * y_imo
  y2        = y_imo * y_imo
  term_4x2  = x2 << 2
  term_11x2 = x2 * 11
  term_4xy  = xy << 2
  term_y2   = y2

  OUTPUT_METRIC = (term_4x2 + term_11x2 + term_4xy + term_y2) << 2
```

This is the base-60 nomogram form:

```text
Q60(x, y) = 4(4x^2 + 11x^2 + 4xy + y^2)
          = 4(15x^2 + 4xy + y^2)
          = 60x^2 + 16xy + 4y^2
```

It is not the OMI-Port perfect-square form `Q16(x, y) = (4x + 2y)^2`.

## Global Execution Rule

```text
The core is algorithmic determinism.
The Algorithmic Clock advances deterministically.
The Circular Slide Ruler Array resolves deterministically.
Tetragrammatron closes deterministically.
Metatron scribes deterministically.
Gnomonic Projection Azimuth orients deterministically.
Omicron gauges deterministically.
Omnicron resolves deterministically.
Everything else is outside-in form or outside-facing output.
No form may become an additional source of core law.
```
