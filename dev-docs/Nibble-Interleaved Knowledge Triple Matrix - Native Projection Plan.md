# Nibble-Interleaved Knowledge Triple Matrix - Native Projection Plan

**Status:** Reinvigorated implementation plan  
**Scope:** Dev-doc plan for Omino native runtime, projection geometry, and conformance  
**Source Restored From:** `Nibble-Interleaved Quadrant Decoding under a Concurrent 3D Knowledge Triple Matrix.md`

---

## 1. Mission

Turn the Nibble-Interleaved Knowledge Triple Matrix into the native projection and conformance spine for Omino:

```text
Emergent Axial Lisp
+ Meta-CONS Runtime
+ Omnicron Coproduct Partition
+ LOGOS/NOMOS/PATHOS Hamming-Coded COBS-CONS
+ OMNION deterministic clock and centroid
```

This plan does not replace `.o`.

```text
.o files declare.
Emergent Axial Lisp resolves.
Meta-CONS composes.
Hamming/Miquel checks integrity.
COBS frames.
CONS preserves continuation.
Validation accepts.
Receipt records.
HTML/Canvas/DOT/SVG project.
```

---

## 2. Authority Boundary

The existing `.o` format remains the declaration and source-carrier format.

Projection artifacts are not authorities:

```text
HTML != authority
Canvas != authority
DOT != authority
SVG != authority
innerHTML != receipt
rendering != validation
```

Native views must retain:

```text
.o source path
origin identifier
address
CAR
CDR
CONS
selector
scope
integrity state
validation state
receipt state
```

Overlapping contributions must remain distinct. Validated equivalence may appear as an edge or witness, but must not collapse source nodes automatically.

---

## 3. Canonical Selector Geometry

The 16-bit CONS plane is viewed as a `256 x 256` grid. The high-order address nibbles define eight state-corners of the 3D Knowledge Triple Cube.

Here, `3D` means concurrent Knowledge Triple state space, not a claim that authority comes from physical spatial layout. The three selector bits process three binary semantic axes at once, yielding `2^3 = 8` logical corners.

Axes:

```text
Axis A: Structural Bank      Left / Right
Axis B: Address Elevation    Low / High
Axis C: Pointer Routing      Local/CAR / Remote/CDR
```

Selector bit law:

```text
selector bit 0 = Left/Right bank
selector bit 1 = Low/High elevation
selector bit 2 = Local/CAR or Remote/CDR
```

Canonical selectors:

```text
0 = Local  / Low  / Left
1 = Local  / Low  / Right
2 = Local  / High / Left
3 = Local  / High / Right
4 = Remote / Low  / Left
5 = Remote / Low  / Right
6 = Remote / High / Left
7 = Remote / High / Right
```

Canonical corners:

```text
0: 00 07 37 30
1: 08 0F 3F 38
2: 40 47 77 70
3: 48 4F 7F 78
4: 80 87 B7 B0
5: 88 8F BF B8
6: C0 C7 F7 F0
7: C8 CF FF F8
```

Nibble interleave:

```text
0xYX -> 0xY0X0
```

C expression:

```c
((V & 0xF0) << 8) | ((V & 0x0F) << 4)
```

Mirror law:

```text
Remote selector base = Local selector base XOR 0x80
```

---

## 4. Canvas Cube Projection

The native HTML canvas view must render the Knowledge Triple Cube as the first-class visual projection of selector geometry.

Required cube labels:

```text
Q0 Local / Low  / Left
Q1 Local / Low  / Right
Q2 Local / High / Left
Q3 Local / High / Right
Q4 Remote / Low  / Left
Q5 Remote / Low  / Right
Q6 Remote / High / Left
Q7 Remote / High / Right
```

Required visible geometry:

```text
front face  = Local/CAR selectors 0..3
back face   = Remote/CDR selectors 4..7
horizontal  = Left/Right bank axis
vertical    = Low/High elevation axis
depth       = Local/Remote route axis
```

Each cube node must display:

```text
selector index
route
row band
bank
selector corner base
```

Canvas rendering remains projection only. The renderer must read selector data from one shared tested table or generated conformance artifact, not from an untested hand-maintained parallel law.

---

## 5. Circular Slide Rule Projection

Each selector quadrant projects to a concentric circular slide rule:

```text
4 rows    -> 4 concentric rings
8 columns -> 8 radial ticks at 45 degree intervals
```

Ring row offsets:

```text
Ring 0 = +0x00
Ring 1 = +0x10
Ring 2 = +0x20
Ring 3 = +0x30
```

The shared tracking window:

```text
0x*8..0x*B
```

This window is rendered as a Vernier XOR tracking corridor. It may show synchronization state, but it does not prove universal zero-drift synchronization without tests or proof. Mechanical language in projections is a visualization/implementation metaphor over the semantic triple state space; it is not a replacement authority.

---

## 6. Row-Level Structural Geometry

Every 16-byte row is split as:

```text
0x*0..0x*B = Triakis outer shell / data surface
0x*C..0x*F = Tetrahedral core / control anchors
```

Control anchors:

```text
0x*C -> FS
0x*D -> GS
0x*E -> RS
0x*F -> US
```

Projection may render this as a stellated tetrahedron, but the implementation must keep the concrete byte-level boundary and Knowledge Triple selector law as the authority.

---

## 7. Integrity Surface

The complete epistemic code surface is:

```text
FS/GS/RS/US
+
LOGOS/NOMOS/PATHOS
=
7-position relational codeword
```

Canonical statement:

```text
FS/GS/RS/US carries scope.
LOGOS/NOMOS/PATHOS checks scope.
```

Hamming arrangement:

```text
position 1 = LOGOS
position 2 = NOMOS
position 3 = FS
position 4 = PATHOS
position 5 = GS
position 6 = RS
position 7 = US
```

Equations:

```text
LOGOS  = FS XOR GS XOR US
NOMOS  = FS XOR RS XOR US
PATHOS = GS XOR RS XOR US
```

The extended Miquel `[8,4,4]` view may add OMNION as the eighth point. OMNION is not a fifth scope level.

---

## 8. OMNION Clock and Centroid

The deterministic clock remains a runtime law, not a projection law.

Canonical centroid:

```text
address = 0x0000
azimuth = 0 degrees
```

Required projection views:

```text
OMNION centroid
240 active marks
16 reserved control rail
4 concentric rings
60 marks per ring
centroid-relative sync fingerprint
drift rejection state
```

The Verilog clock is optional. It must match C vectors before being treated as a conforming backend.

---

## 9. Implementation Track

Baseline already established:

```text
tests/golden/c-runtime-output.txt
make test-golden
make check
reference/omnicron-coproduct-partition.c
```

Next implementation steps:

1. Extract selector geometry into one reusable C module.
2. Generate a selector conformance table from that module.
3. Make HTML/Canvas/DOT/SVG renderers consume the shared selector table.
4. Add `.o` parsing without changing `.o` authority.
5. Add CLI projection commands:

```text
omino route 0xA080
omino project html file.o
omino project canvas file.o
omino project dot file.o
```

6. Add conformance tests proving projection outputs preserve origin/provenance and do not collapse overlaps.

---

## 10. Claim Status Guardrail

Do not mark these as proved without formal proof or benchmark:

```text
hardware acceleration
universal zero-drift synchronization
mathematical impossibility of leakage
```

Current safe classifications:

```text
nibble round-trip              implemented
selector routing               implemented
XOR-0x80 mirror                implemented
Hamming [7,4,3]                implemented
Miquel [8,4,4]                 defined_model
algorithmic clock sequence     implemented
zero-drift synchronization     interpretation
hardware acceleration          interpretation
leakage impossibility          interpretation
```

---

## 11. Definition of Ready for Refactor

The C source may be extracted only after:

```text
make check passes
golden runtime output is current
reference source is preserved
selector geometry tests are in place
projection artifacts are documented as non-authoritative
```

This keeps the restored Knowledge Triple Matrix alive as an implementation plan without allowing it to overwrite Omino authority boundaries.

---

## 12. Master Core Architecture: Lambda Canon Block and Epistemic Hamming COBS-CONS

This section seals the production-facing architecture for Emergent Axial Lisp inside Omino.

It replaces loose object structures with the unified Lambda Canon Block unary a-list while preserving the existing source and authority boundaries:

```text
.o files remain declarations.
The Lambda Canon Block is the resolved declaration form.
COBS frames but does not validate.
CONS preserves ordered continuation.
Hamming/Miquel checks integrity but does not accept.
Validation accepts.
Receipt records.
Projection displays.
```

Every coordinate, operation, and bitwise transformation is interpreted relative to the fixed `0x0000` and `0 degree` OMNION centroid:

```text
0x0000 = NULL . NULL
0 degrees = reference phase
0x80 = shifted high-contrast observer boundary
```

### 12.1 Lambda Canon Block Structure

The Lambda Canon Block is a complete, non-divisible block. It stores local declaration pairs as a five-level unary association list inside the CONS plane:

```lisp
(
  (subject                 . notation)        ; Level -1: Relation precedes identity
  (predicate               . citation)        ; Level  0: Distinction precedes counting
  (object                  . attestation)     ; Level  1: Boundary makes form inspectable
  (computational_ontology  . annotation)      ; Level  2: Projection is not validation
  (systematic_epistemology . interpretation)  ; Level  3: Structural truth access lane
)
```

This block is the declaration carrier after parsing and resolution. It is not a receipt, not a projection, and not an automatic equivalence proof.

### 12.2 Architectural Space Partitioning

```text
ONTOLOGICAL CENTROID CORE [0x0000]
  -> ( ) aka NULL . NULL, 0 degree reference phase
  -> shifted neutral observer at 0x80 high-contrast boundary window
  -> LOGOS / NOMOS / PATHOS SECDED interlock
```

Definitions:

```text
Absolute centroid 0x0000:
  Master anchor and unallocated foundation boundary.

Shifted observer boundary 0x80:
  High-contrast annotative tangent boundary separating local declaration space
  from external backplane sync routines.

Perfect square form:
  Q(x, y) = 16x^2 + 16xy + 4y^2 = (4x + 2y)^2
```

The square form is a tracking model. It may be implemented as a check or projection aid, but it does not replace validation witnesses.

### 12.3 Optional Synthesizable RTL Block

The Verilog form is an optional backend candidate for the deterministic clock and Lambda Canon interlock. It must be cross-checked against C vectors before it is considered conforming.

```verilog
`timescale 1ns / 1ps

module eal_lambda_canon_core (
    input  wire        clk,
    input  wire        rst_n,

    input  wire [15:0] i_x_omi,
    input  wire [15:0] i_y_imo,
    input  wire [7:0]  i_character_token,
    input  wire        i_received_omnion,

    output reg  [31:0] o_parabolic_eval,
    output reg         o_is_void_centroid,
    output reg         o_observer_boundary,
    output reg         o_is_admissible
);

    reg [17:0] w_4x;
    reg [17:0] w_2y;
    reg [17:0] w_linear_sum;
    reg        w_void_check;
    reg        w_obs_check;
    reg        w_omnion_check;

    always @(*) begin
        w_4x = {i_x_omi, 2'b00};
        w_2y = {1'b0, i_y_imo, 1'b0};
        w_linear_sum = w_4x + w_2y;

        w_void_check = (w_linear_sum == 18'd0);
        w_obs_check = (i_character_token == 8'h80);
        w_omnion_check = (i_received_omnion == ^{i_x_omi, i_y_imo, i_character_token});
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            o_parabolic_eval    <= 32'd0;
            o_is_void_centroid  <= 1'b1;
            o_observer_boundary <= 1'b0;
            o_is_admissible     <= 1'b0;
        end else begin
            o_is_void_centroid  <= w_void_check;
            o_observer_boundary <= w_obs_check;

            if (i_character_token <= 8'h7F && w_omnion_check) begin
                o_is_admissible  <= 1'b1;
                o_parabolic_eval <= w_linear_sum * w_linear_sum;
            end else begin
                o_is_admissible  <= 1'b0;
                o_parabolic_eval <= 32'd0;
            end
        end
    end
endmodule
```

Notes for implementation:

```text
i_received_omnion is used as an integrity witness input.
o_is_admissible is an interlock signal, not a receipt.
The RTL must not become mandatory for the default C build.
The C runtime remains the first conformance target until cross-check vectors pass.
```

### 12.4 Functional Core Execution Invariants

Transactional atomicity:

```text
Preflight every target coordinate before mutating the blackboard.
Capacity failure leaves the coproduct unchanged.
```

Pure logical cadence:

```text
The clock is a deterministic state machine driven by the greedy bitwise oscillation law.
It is isolated from physical wall-clock time.
```

Decoupled verification paths:

```text
6:4 user-local sliding dials and 8:3 user-remote triple blocks resolve relative to 0x0000.
Projection may show this geometry.
Validation still requires explicit witnesses.
```

### 12.5 Production Phase Expansion

The next production phase should add these tracks in order:

1. Haskell/dependent-type design notes for the five-level Lambda Canon Block.
2. C conformance vectors for the perfect square tracking model.
3. Optional Verilog testbench for `eal_lambda_canon_core`.
4. Cross-check vectors comparing C and RTL outputs.
5. Native projection updates showing the Lambda Canon Block beside the Knowledge Triple Cube.

Do not implement this by replacing `.o`, creating a new JSON authority, or bypassing validated Union-Find.

---

## 13. Coproduct Composition and Quasigroup Recovery Mechanics

Section 24 recovery is implemented as an inverse layer around the existing CONS fold. It does not replace `.o`, does not collapse coproduct origins, and does not promote projection witnesses into validation authority.

`.o` sources enter the runtime as sparse, origin-tagged blackboard contributions:

```text
source .o
-> origin-tagged sparse board
-> CAR/CDR contribution coordinates
-> ordered CONS continuation
-> optional recovery of a missing coordinate
-> validation and receipt only when explicit witnesses accept
```

The lawful resolver profile is the existing rotate/XOR fold:

```text
salt = resolver_profile repeated into both 16-bit halves
CONS = rotl32(CAR, 1) XOR rotl32(CDR, 3) XOR salt
```

Recovery is only the inverse of that law under the same resolver profile:

```text
CAR = rotr32(CONS XOR rotl32(CDR, 3) XOR salt, 1)
CDR = rotr32(CONS XOR rotl32(CAR, 1) XOR salt, 3)
```

This reconstructs a missing coordinate when the other coordinate, the CONS word, and the resolver profile are already known. It does not validate equivalence, does not receipt acceptance, and does not give Union-Find permission to merge origins.

The square tracking line remains diagnostic:

```text
Q16(CAR, CDR) = (4 * low16(CAR) + 2 * low16(CDR))^2 mod 2^16
```

`Q16` may be emitted as a tracking/interlock witness, including for hardware or slide-rule projections. It is not sufficient for unique recovery because squaring modulo `2^16` has collisions; conformance vectors include a collision witness to keep this boundary explicit.

---

## 14. Type-Level Lambda Canon Block Reference Surface

The five-level Lambda Canon Block now has an optional Haskell type-level reference harness under `tests/lambda-types`. Its purpose is to make the modeled structural invariants compile-time visible without claiming that GHC proves the complete physical or hardware system.

The harness encodes:

```text
LinearRoot(x, y) = 4x + 2y
EvaluateQ(x, y) = LinearRoot(x, y)^2

Level -1 = subject / notation
Level  0 = predicate / citation
Level  1 = object / attestation
Level  2 = ontology / annotation
Level  3 = epistemology / interpretation
```

`LambdaCanonBlock` is a GADT assembled from exactly five typed pairs. A caller cannot construct the modeled block through this API without providing all five levels.

The harness also models two boundary guards:

```text
RequireAscii7 token       rejects token > 127
IsObserverBoundary token  accepts only token == 128
```

Conformance target:

```sh
make test-lambda-types
```

When GHC is installed, this target:

1. Builds and runs a valid Lambda Canon type-level example.
2. Requires an invalid mux-band module using token `135` to fail type-checking.
3. Requires an invalid observer-boundary module using token `127` to fail type-checking.

These checks are reference-surface constraints. They do not replace runtime validation, receipt authority, `.o` provenance, or the C recovery/conformance tests.

---

## 15. Physical Backplane, ESP32 Adapter, and Runtime Lock

Sections 30-32 are integrated as bounded implementation profiles:

```text
docs/HARDWARE-BACKPLANE.md       physical connector and signal profile
examples/esp32/esp32_omi_core.c  fixed-buffer ESP32-style adapter example
docs/ARCHITECTURAL-LOCK.md       greedy/exact/lazy runtime lock statement
```

Backplane status:

```text
DIN 41612 J1/J2 pinout       defined_model
100 ohm differential targets defined_model
LOCKOUT_N behavior           hardware profile
```

The backplane profile does not validate relations and does not replace `.o` provenance, runtime validation, or receipts.

ESP32 adapter status:

```text
no malloc
bounded 128-bit address parser
bounded COBS decoder
7-bit mux band rejection
Q(x,y) = (4x + 2y)^2 diagnostic tracking
```

The ESP32 code is an adapter/example layer. Its parabolic form remains a tracking witness, not recovery authority and not validation authority.

Runtime lock status:

```text
GREEDY -> omi_clock_tick() advances state
EXACT  -> centroid-relative state equality decides sync
LAZY   -> geometric projection is read-only display
```

Conformance targets:

```sh
make test-esp32
make test-runtime-lock
```

These targets preserve the golden C runtime output while adding focused regression coverage for the new profiles.
