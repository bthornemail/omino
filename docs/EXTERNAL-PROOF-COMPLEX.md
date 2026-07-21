# External Proof Complex

Omino keeps formal proof authority outside the runtime repository.

```text
Omino                         axiomatic-sovereignty
runtime and projection    ->  external Coq proof authority
tests and vectors         ->  LOGIC_PROOFS / Rocq prover
docs and ledgers          ->  proof bibliography
```

The observed local proof repository is:

```text
repo:   git@github.com:bthornemail/axiomatic-sovereignty.git
path:   /home/main/omi/axiomatic-sovereignty
commit: 12ad1d4f860c400c2b6304a68dd6c45469ed41d9
```

Omino does not vendor Coq sources, generated `.vo` artifacts, or proof logs. `make check` does not require Coq, the sibling repository, or proof artifacts.

## Admission Gates

The external repository owns the five admission gates described by its protocol:

| Gate | External directory | Omino boundary |
| --- | --- | --- |
| Logic | `LOGIC_PROOFS/` | Formal proof authority lives outside Omino. |
| Type | `STRUCTURAL_TYPES/` | Haskell reference surfaces in Omino are conformance checks, not proof ownership. |
| Procedure | `PROCEDURAL_SEQUENCES/` | Omino tests deterministic procedures locally. |
| Canonical | `CANONICAL_AXIOMS/` | Omino records architectural alignment only. |
| Social | `SOCIAL_CONTRACTS/` | Omino does not enforce community admission. |

All five gates are separate from Omino runtime validation and receipt records.

## Proof Bibliography

The active external Coq proof index maps to Omino concerns as follows:

| Omino concern | External Coq owner |
| --- | --- |
| Claim-status ordering | `ProofStatusOrdersClaims.v` |
| Finite sets and exact finite arithmetic | `FiniteBasicsEnumeratesSets.v`, `RationalVectorsDefineOperations.v` |
| Earned byte/control bands | `EarnedControlBandsEncode.v` |
| Hamming/Miquel integrity profile | `FiniteIncidenceBalancesFlags.v`, `MiquelIncidenceBalancesFlags.v` |
| Closure and 240-state arithmetic | `DiagonalGaugeCloses.v`, `NullRingCloses.v`, `ComplexityBoundsArity.v` |
| BQF and projection bridges | `BQFBridgePreservesForms.v`, `MetricProjectionPreservesBounds.v`, `PiProjectionPreservesWitnesses.v` |
| Replay and deterministic execution | `AtomicKernelDefinesReplay.v`, `Delta16HasExactPeriodEight.v`, `OmiPiBridgeConnectsKernel.v` |
| Admission and authority preservation | `AuthorityPipelinePreservesDecision.v`, `SabbathProtocolRejectsRestAttestation.v` |

The external proof index is the source of truth. Admitted or illustrative snippets in architecture drafts are not imported into Omino as proof authority.

## Outside Proof Checks

Run proof checks from outside Omino:

```sh
make -C /home/main/omi/axiomatic-sovereignty/LOGIC_PROOFS -f coq/Makefile proof
```

For a lightweight source/artifact count:

```sh
make -C /home/main/omi/axiomatic-sovereignty/LOGIC_PROOFS -f coq/Makefile proof-status
```

`proof-strict` is intentionally not wired from Omino. In the observed external Makefile, that target needs invocation repair before it can be treated as the strict command.

## Non-Authority

This bibliography does not accept relations, merge origins, issue receipts, or alter runtime memory. Omino remains responsible for executable behavior; the external proof repository remains responsible for formal logic.
