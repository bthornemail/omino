# ESP32 P2P Gossip Sync

The ESP32 gossip profile transports sparse 256-bit board contributions over bounded COBS frames.

```text
port profile: 5040
raw frame:    64 bytes
wire cap:     66 bytes
```

The raw frame layout is:

| Field | Size |
| --- | ---: |
| Source node ID | 4 bytes |
| Step accumulator | 8 bytes |
| OMNION phase | 1 byte |
| Reserved pad | 3 bytes |
| Board payload | 32 bytes |
| Transport metadata | 16 bytes |

All multibyte integer fields are serialized little-endian explicitly. No `malloc` is used.

COBS encoding removes internal zeros and appends one delimiter byte. The maximum encoded frame is 66 bytes for a fully nonzero 64-byte raw frame.

The decoder checks the peer step accumulator before committing to the output packet. A sync mismatch leaves the caller output untouched, matching the atomic preflight posture used by the runtime.

Conformance target:

```sh
make test-esp32-gossip
```

This profile is transport only. It does not validate relations, merge origins, or issue receipts.
