# Absolute System Conformance Ledger

This ledger maps the Section 40 checklist to executable targets, backend profiles, external proof authority, and physical-model boundaries.

Status meanings:

```text
PASS
  The canonical algorithm is executable and checked by default.

PASS_SCOPED
  The algorithm passes exactly within its deliberately bounded domain.

BACKEND_OPTIONAL
  A secondary realization may be absent. If present, it must reproduce the canonical vectors exactly.

DEFINED_MODEL
  A structural proposal has not yet been lowered into a complete deterministic algorithm.

EXTERNAL_PROOF
  Formal proof authority is intentionally owned by another repository.

PHYSICAL_PROFILE
  Connector, PCB, timing, signal-integrity, or manufactured-hardware claims.
```

| # | Guardrail | Status | Target / Authority |
| --- | --- | --- | --- |
| 01 | Nibble round-trip | PASS | `make test-golden` |
| 02 | Selector routing | PASS | `make test-golden` |
| 03 | XOR-0x80 involution | PASS | `make test-golden`, `make test-conformance-guardrail-types` |
| 04 | Hamming [7,4,3] | PASS | `make test-golden` |
| 05 | Miquel [8,4,4] | PASS | `make test-algorithmic-laws` extended parity law |
| 06 | Single-error correction | PASS | `make test-golden` |
| 07 | Double-error trap | PASS | `make test-golden` |
| 08 | Algorithmic clock | PASS | `make test-golden`, `make test-runtime-lock` |
| 09 | Exact centroid-relative peer sync | PASS | `make test-runtime-lock` equal seed/tick/orientation law |
| 10 | Hardware shift laws | PASS | `make test-algorithmic-laws`, `make test-metatron-preclosure`, `make test-base-metric` |
| 11 | Origin-preserving coproduct partition | PASS | `make test-golden`, `make test-recovery` |
| 12 | `.o` source lifecycle | PASS | `make test-o-lifecycle`, `docs/O-SOURCE-LIFECYCLE.md`, `examples/o/*.o` |
| 13 | COBS zero trapping | PASS | `make test-esp32`, `make test-omnicron-epistemic` |
| 14 | Projection inertness | PASS_SCOPED | `make views`, `make canvas`, `make dot` |
| 15 | Lambda Canon index | PASS | `make test-algorithmic-laws`, `make test-lambda-types` |
| 16 | RTL backend vector reproduction | BACKEND_OPTIONAL | `make clock-crosscheck` |
| 17 | Quasigroup recovery | PASS | `make test-recovery` |
| 18 | Lambda GADT rules | PASS | `make test-lambda-types` |
| 19 | Octahedral selector routing | PASS | `make test-algorithmic-laws`, `make test-octahedral-types` |
| 20 | Canonical namespaces | PASS | `make test-algorithmic-laws`, `make test-canonical-types` |
| 21 | Metatron inscription | PASS | `make test-algorithmic-laws`, `make test-metatron-preclosure` |
| 22 | Omnicron local 240 field | PASS | `make test-omnicron-epistemic` |
| 23 | Omnicron BQF logic | PASS | `make test-algorithmic-laws`, `make test-omnicron-epistemic` |
| 24 | Fano slot engine | PASS | `make test-algorithmic-laws`, `make test-conformance-guardrail-types` |
| 25 | EAL meta-assembler | PASS | `make test-algorithmic-laws`, `make test-meta-compiler-types` |
| 26 | Pure compiler core | PASS | `make test-meta-compiler-types` |
| 27 | Electrical backplane connector profile | PHYSICAL_PROFILE | `docs/HARDWARE-BACKPLANE.md` |
| 28 | Backplane logical interlock | PASS | `make test-algorithmic-laws` |
| 29 | ESP32 P2P gossip sync | PASS | `make test-esp32-gossip` |
| 30 | TCG lowering rules | PASS | `make test-tcg-backend-spec` static profile check |
| 31 | eMMC-style boot envelope | PASS | `make test-boot-envelope` |
| 32 | BASE(n) metric seed model | PASS | `make test-base-metric` |
| 33 | P2P multimedia media bridge | PASS | `make test-media-bridge` |
| 34 | Metatron pre-closure pipeline | PASS | `make test-metatron-preclosure` |
| 35 | Pascal Layer-4 multiplicity | PASS | `make test-algorithmic-laws`, `make test-layer4-types` |
| 36 | Binary export invariance | PASS | `make test-binary-export`, `make test-metamorphic-types` |
| 37 | Visual matrix coordinate projection | PASS | `make test-algorithmic-laws` |
| 38 | Lagrange fold/unfold space | PASS | `make test-algorithmic-laws`, `make test-lagrange-types` |
| 39 | Verilog Lambda Canon backend | BACKEND_OPTIONAL | `make verilog-test`, `make clock-crosscheck` |
| 40 | Verilog octahedral router backend | BACKEND_OPTIONAL | `make octahedral-router-test`, `make clock-crosscheck` |
| 41 | Verilog Metatron scribe backend | BACKEND_OPTIONAL | `make metatron-scribe-test`, `make clock-crosscheck` |
| 42 | Verilog Omnicron BQF backend | BACKEND_OPTIONAL | `make omnicron-bqf-test`, `make clock-crosscheck` |
| 43 | Verilog Fano scheduler backend | BACKEND_OPTIONAL | `make fano-slot-test`, `make clock-crosscheck` |
| 44 | Verilog meta-assembler backend | BACKEND_OPTIONAL | `make meta-assembler-test`, `make clock-crosscheck` |
| 45 | Verilog backplane monitor backend | BACKEND_OPTIONAL | `make backplane-monitor-test`, `make clock-crosscheck` |
| 46 | Verilog Layer-4 multiplicity backend | BACKEND_OPTIONAL | `make layer4-multiplicity-test`, `make clock-crosscheck` |
| 47 | Verilog metamorphic export backend | BACKEND_OPTIONAL | `make metamorphic-export-test`, `make clock-crosscheck` |
| 48 | Verilog visual matrix backend | BACKEND_OPTIONAL | `make visual-matrix-test`, `make clock-crosscheck` |
| 49 | Verilog Lagrange resolver backend | BACKEND_OPTIONAL | `make lagrange-space-test`, `make clock-crosscheck` |
| 50 | External Coq proof complex | EXTERNAL_PROOF | `docs/EXTERNAL-PROOF-COMPLEX.md` |

## External Proof Boundary

Section 41 proof authority is external to this ledger. Omino records the bibliography in `docs/EXTERNAL-PROOF-COMPLEX.md`; Coq checks are run from `bthornemail/axiomatic-sovereignty`, not from Omino `make check`.

The ledger does not grant validation authority. Runtime validation, attestation records, and `.o` provenance remain separate from projections, backend checks, and Haskell reference-surface checks.
