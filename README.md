# Omino

Omino is the native implementation and projection package for the Emergent Axial Lisp / Meta-CONS / Omnicron coproduct model.

The native runtime preserves `.o` declarations as source carriers. It resolves Emergent Axial Lisp declarations, composes through Meta-CONS, checks integrity with LOGOS/NOMOS/PATHOS and Miquel profiles, frames with COBS, preserves continuation with CONS, accepts through validation, records through receipt, and projects through HTML, Canvas, DOT, and SVG.

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
```

The first guardrail is `tests/golden/c-runtime-output.txt`, a byte-for-byte fixture for the current C runtime output. Refactors must preserve that output unless the fixture is intentionally updated with a documented semantic change.

## Source Lifecycle

```text
.o declaration
-> Emergent Axial Lisp resolution
-> Meta-CONS composition
-> LOGOS/NOMOS/PATHOS integrity check
-> COBS frame
-> CONS continuation
-> validation decision
-> receipt record
-> projection
```

## Authority

Authoritative source carriers:

```text
.o files
canonical docs under canon/
native C runtime behavior protected by golden tests
validation witnesses
receipts
```

Projection artifacts:

```text
HTML
Canvas
DOT
SVG
browser DOM renderings
generated diagrams
```

Projection artifacts may describe or inspect state. They do not accept state, replace `.o`, or define a parallel schema.

## Native Views

```sh
make views
make view-path
```

The current static projection package lives under `public/`.
