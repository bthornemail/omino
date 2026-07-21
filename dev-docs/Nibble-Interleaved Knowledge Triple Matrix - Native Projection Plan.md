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

---

## 16. Octahedral Face Router Projection

Section 33 maps the canonical 8-selector table onto an octahedral face projection:

```text
faces 0..3 = Local/CAR  = User-Local 6:4 interface
faces 4..7 = Remote/CDR = User-Remote 8:3 interface
```

The projection is another view of the same selector law:

```text
compressed = {address[15:12], address[7:4]}
face[2:1] = compressed[7:6]
face[0]   = compressed[3]
```

The `XOR 0x80` mirror remains the local/remote pairing witness:

```text
face 0 <-> face 4
face 1 <-> face 5
face 2 <-> face 6
face 3 <-> face 7
```

Implementation artifacts:

```text
docs/OCTAHEDRAL-FACE-ROUTER.md
verilog/eal_octahedral_face_router.v
verilog/tb_eal_octahedral_face_router.v
vectors/octahedral-face-router.jsonl
```

Conformance target:

```sh
make octahedral-router-test
make clock-crosscheck
make test-octahedral-types
```

This router is projection and routing support. It does not validate, receipt, merge origins, or change the C runtime selector authority.

The Haskell type-level octahedral harness mirrors the same law under `tests/octahedral-types`. It intentionally rejects `0xA080 -> Face4`: `0xA080` compresses to row nibble `0xA`, column nibble `0x8`, and therefore resolves to Face 5.

---

## 17. Canonical Authority Namespace Guard

Section 35 is implemented as a separate Haskell type-level harness under `tests/canonical-types`. It keeps the principal authority namespaces disjoint:

```text
TetragrammatronGovernor -> relation closure witnesses
MetatronScribe          -> route/place inscription witnesses
GnomonicAzimuth         -> projection orientation witnesses
OmicronGauge            -> bounded gauge namespace
OmnicronResolver        -> 256-position runtime namespace
```

The accepted witness families are:

```text
Tetragrammatron: 0x1E, 0x3C, 0x78
Metatron:        0x18, 0x0001, 0x0010, 0x0100, 0x1000, 0x10000
Gnomonic:        0xAA55, 0x55AA
```

The byte-plane classifier covers `0x00..0xFF` only. Values outside that range are rejected by the type-level harness.

Conformance target:

```sh
make test-canonical-types
```

This target compiles valid authority envelopes, then requires GHC to reject:

```text
Tetragrammatron owning 0xAA55
Metatron owning 0x3C
address plane 0x100
```

These are namespace/category checks for the Haskell reference surface. They do not replace runtime validation, receipts, or source provenance.

---

## 18. Metatron Incidence Scribe RTL

Section 36 is integrated as an isolated optional RTL block:

```text
verilog/metatron_incidence_scribe.v
verilog/tb_metatron_incidence_scribe.v
vectors/metatron-incidence-scribe.jsonl
```

The block owns inscription, not validation:

```text
i_step_cmd       -> o_gauge_register <<= 4
i_sector_prefix  -> sector-gated 0x18 incidence witness
i_gauge_polarity -> 24-bit pairwise plane flags
```

The raw witness expression:

```text
B XOR (B XOR 0x1B) XOR (B XOR 0x1C) XOR (B XOR 0x1F) = 0x18
```

cancels `B` for every input. Therefore the RTL also checks that `B` is one of the valid sector prefixes:

```text
0x00, 0x20, 0x40, 0x60
```

Malformed prefixes such as `0x15` are rejected to `0x00` even though the raw XOR expression still algebraically yields `0x18`.

Conformance target:

```sh
make metatron-scribe-test
make clock-crosscheck
```

This block is separated from Tetragrammatron closure. It logs route/place state and carries, but it does not accept relations or issue receipts.

---

## 19. Omnicron COBS-CONS BQF Runtime Layer

Section 37 is integrated as a bounded Omnicron runtime and optional RTL projection:

```text
examples/esp32/omnicron_epistemic_core.c
tests/esp32/omnicron_epistemic_core_test.c
verilog/omnicron_bqf_resolver.v
verilog/tb_omnicron_bqf_resolver.v
vectors/omnicron-bqf-resolver.jsonl
```

The C layer implements the stream-surface law:

```text
0x00       -> preserved boundary / zero-leak error
0x01..0x1F -> control, separator, delta-operation band
0x20..0x7F -> readable observer surface
0x80..0xAF -> lazy .o carrier band
0xB0..0xFF -> high-bit sparse lazy surface
```

The `11 + 5` split is encoded as a high-nibble delineation flag:

```text
high nibble 0x0..0xA -> declared local field
high nibble 0xB..0xF -> delineation / escape / frame field
```

The BQF energy metric is:

```text
Q(x,y) = 60x^2 + 16xy + 4y^2
       = 4(15x^2 + 4xy + y^2)
```

The host conformance test also rejects `local_field_x >= 240`, preserving the local `15 x 16` sparse field boundary.

Conformance targets:

```sh
make test-omnicron-epistemic
make omnicron-bqf-test
make clock-crosscheck
```

This layer is transport and diagnostic routing support. It does not replace `.o`, does not validate relations, does not merge coproduct origins, and does not issue receipts.

---

## 20. Fano 5040 Scheduler and Meta-Compiler Reference Layer

Sections 38-39 are integrated as optional RTL blocks plus a Haskell reference harness:

```text
verilog/fano_slot_scheduler.v
verilog/tb_fano_slot_scheduler.v
vectors/fano-slot-scheduler.jsonl

verilog/eal_meta_assembler.v
verilog/tb_eal_meta_assembler.v
vectors/eal-meta-assembler.jsonl

tests/meta-compiler-types/EmergentAxialLisp/MetaCompilerCore.hs
```

The Fano scheduler implements:

```text
slot5040 = fano7 * 720 + role3 * 240 + local240
```

with hard bounds:

```text
fano7    <= 6
role3    <= 2
local240 <= 239
slot5040 <= 5039
```

The meta-assembler packs modeled Core IR fields into a 16-bit instruction word:

```text
machine_instruction = opcode[15:12] || slot5040[11:0]
ready = slot5040 < 5040 AND character_token <= 0x7F
```

Invalid slots or character tokens force the output word to the `0x0000` centroid and deassert readiness.

The Haskell reference surface models:

```text
Surface  -> Parsed
Resolved -> Lowered
```

and uses type families to reject invalid Fano/local slot bounds and invalid assembler token bounds.

Conformance targets:

```sh
make fano-slot-test
make meta-assembler-test
make test-meta-compiler-types
make clock-crosscheck
```

These layers schedule and lower modeled instruction coordinates. They do not replace `.o`, do not validate relations, do not merge coproduct origins, and do not issue receipts.

---

## 21. Absolute System Conformance Ledger

Section 40 is integrated as an aggregate guardrail ledger plus a Haskell reference harness:

```text
docs/CONFORMANCE-LEDGER.md
tests/conformance-guardrail-types/Omino/ConformanceGuardrail.hs
```

The ledger maps the 27 checklist items to one of three statuses:

```text
PASS          executable guard runs under make check or a named target
PASS_OPTIONAL executable guard runs when optional tools such as GHC or Icarus are installed
DEFINED_MODEL documented architecture profile without repository-level proof
```

The Haskell guardrail harness models:

```text
MirrorAxis(selector) = selector + 128
ComputeSlot(fano, role, local) = fano * 720 + role * 240 + local
```

and rejects:

```text
local240 > 239
fano7 > 6
non-matching XOR-0x80 mirror assignments
assembler token > 0x7F
```

Conformance target:

```sh
make test-conformance-guardrail-types
```

This is an aggregate reference-surface check. It does not turn documented backplane profiles, projection inertness, or optional RTL simulations into validation authority.

---

## 22. Externalized Proof Complex Bibliography

Section 41 is integrated as a proof-boundary document:

```text
docs/EXTERNAL-PROOF-COMPLEX.md
```

Omino remains the runtime/projection/conformance repository. Formal proof authority is external:

```text
repo:   bthornemail/axiomatic-sovereignty
path:   /home/main/omi/axiomatic-sovereignty
commit: 12ad1d4f860c400c2b6304a68dd6c45469ed41d9
```

The external repository owns the five admission gates:

```text
LOGIC_PROOFS
STRUCTURAL_TYPES
PROCEDURAL_SEQUENCES
CANONICAL_AXIOMS
SOCIAL_CONTRACTS
```

The proof bibliography maps active external Coq modules to Omino concerns, including earned control bands, Miquel incidence, closure, BQF projection, deterministic replay, and authority preservation.

Proof checks are run from outside Omino:

```sh
make -C /home/main/omi/axiomatic-sovereignty/LOGIC_PROOFS -f coq/Makefile proof
```

Omino `make check` intentionally does not require Coq, the sibling proof repository, or generated proof artifacts. The bibliography does not replace runtime validation, `.o` provenance, or receipt authority.

---

## 23. Backplane Interlock Monitor RTL

The backplane interlock monitor is integrated as an optional RTL block:

```text
verilog/backplane_interlock_monitor.v
verilog/tb_backplane_interlock_monitor.v
vectors/backplane-interlock-monitor.jsonl
```

The monitor checks three signatures:

```text
phase mirror  -> local_azimuth XOR remote_azimuth == 0x80
tetra sum     -> i_tetra_sum == 120
hamming fault -> i_hamming_double_err asserted
```

Fault priority is deterministic:

```text
11 Hamming double-error
10 Tetragrammatron sum drift
01 phase mirror drift
00 no fault
```

Any fault drives `o_lockout_n` low. This is a hardware interlock monitor only; it does not validate relations, merge origins, or issue receipts.

Conformance targets:

```sh
make backplane-monitor-test
make clock-crosscheck
```

---

## 24. ESP32 P2P Gossip and TCG Backend Profiles

Sections 43-44 are integrated as bounded implementation profiles:

```text
examples/esp32/esp32_p2p_gossip.c
tests/esp32/esp32_p2p_gossip_test.c
docs/TCG-BACKEND-SPEC.md
examples/tcg/tcg-target.h
examples/tcg/tcg-target.c.inc
```

The gossip layer uses:

```text
UDP port profile: 5040
raw frame:        64 bytes
COBS wire cap:    66 bytes
board payload:    32 bytes
metadata:         16 bytes
```

The raw frame is fixed at 64 bytes. The COBS wire cap is `raw + 2` because an arbitrary nonzero 64-byte payload requires one leading code byte plus one trailing `0x00` delimiter.

The decoder verifies the step accumulator before committing to the caller output packet, preserving preflight rollback on sync mismatch.

The TCG profile is static specification only:

```text
64-bit target registers
16 target registers
R0 zero register alias
R15 scratch register
division disabled
unsupported operations abort translation
```

Conformance targets:

```sh
make test-esp32-gossip
make test-tcg-backend-spec
```

The gossip layer transports sparse board contributions; the TCG profile records a virtualization lowering surface. Neither layer validates relations, merges origins, or issues receipts.

---

## 25. eMMC-Style Boot Envelope and Tetrahedral Carrier Profile

Section 45 is integrated as a bounded flash boot-envelope parser:

```text
examples/esp32/omi_boot_envelope.c
tests/esp32/omi_boot_envelope_test.c
docs/BOOT-ENVELOPE.md
```

The carrier envelope is exactly 64 bytes:

```text
0x00..0x1F -> gauge / orientation prefix
0x20..0x3F -> first OMI---IMO bootstrap frame
```

The canonical gauge pre-header is:

```text
FF 00 1C 1D 1E 1F 20 FF
```

The bootstrap half parses:

```text
8 x 16-bit big-endian scopes
4 x 32-bit big-endian words: REGISTER, STACK, CAR, CDR
```

The tetrahedral storage face map is:

```text
0 BOOT0
1 BOOT1
2 SECURE / RPMB
3 USER
```

Boot read is not acceptance. Header match is not acceptance. Frame parse is not acceptance. The candidate resolution API returns `BOOT_ERROR_SECURE_REJECTION` unless an explicit secure receipt flag is supplied.

Conformance target:

```sh
make test-boot-envelope
```

This profile stages boot candidates only. It does not validate relations, merge origins, or issue receipts.

---

## 26. BASE(n), Multimedia Bridge, and Metatron Pre-Closure Profiles

Sections 46, 48, and 49 are integrated as bounded implementation profiles:

```text
examples/radix/base_metric_seed_model.c
tests/radix/base_metric_seed_model_test.c
docs/BASE-METRIC-SEED-MODEL.md

examples/media/omi_media_bridge.c
tests/media/omi_media_bridge_test.c
docs/MULTIMEDIA-FEDERATED-SYNC.md

examples/metatron/metatron_preclosure.c
tests/metatron/metatron_preclosure_test.c
docs/METATRON-PRECLOSURE.md
```

The BASE(n) model supports:

```text
BASE(2), BASE(8), BASE(10), BASE(16), BASE(58), BASE(64)
```

Power-of-two bases use shift shortcuts. Non-power-of-two bases use bounded
multiply-add scaling. Digit injection rejects values outside the active base and
fails before 32-bit accumulator overflow.

The multimedia bridge recognizes:

```text
streaming -> 0x1A55 @ 0x18
render    -> 0x1B55 @ 0x1C
capture   -> 0x1C55 @ 0x20
transcode -> 0x1D55 @ 0x24
```

The bridge authorizes hardware effect lanes only when the carrier is
receipt-backed and has a nonzero carrier hash. Media data remains a carrier, not
truth.

The Metatron pre-closure profile models:

```text
0x0001 -> 0x0010 -> 0x0100 -> 0x1000 -> 0x10000 carry
```

Metatron confirms the `0x18` permutation witness before handoff. The
Tetragrammatron closure harness remains separate and only grants closure when
the witness is present and the supplied diagonal sum is `120`.

Conformance targets:

```sh
make test-base-metric
make test-media-bridge
make test-metatron-preclosure
```

These profiles parse carrier notation, gate effects, and inscribe pre-closure
paths. They do not validate relations, merge origins, or issue receipts.
