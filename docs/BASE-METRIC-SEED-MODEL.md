# BASE(n) Metric Seed Model

The `base.metric.seed.model` profile models bounded radix parsing for carrier
tokens.

Supported bases:

```text
BASE(2)
BASE(8)
BASE(10)
BASE(16)
BASE(58)
BASE(64)
```

Power-of-two bases use shift shortcuts:

| Base | Shift |
| --- | --- |
| `2` | `1` |
| `8` | `3` |
| `16` | `4` |
| `64` | `6` |

Base 10 and Base 58 use bounded multiply-add scaling. Every digit must be less
than the active base, and accumulator updates fail before overflowing the
32-bit register.

Conformance target:

```sh
make test-base-metric
```

This model parses carrier notation only. It does not validate relations, merge
origins, or issue receipts.
