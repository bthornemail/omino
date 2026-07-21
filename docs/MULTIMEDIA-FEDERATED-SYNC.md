# Multimedia and Federated Sync Layer

Media objects are normalized carriers. They do not carry intrinsic authority.

Seed examples:

```text
(seed.video   . o.h264.o)
(seed.video   . o.mp4.o)
(seed.audio   . o.aac.o)
(seed.audio   . o.wav.o)
(seed.image   . o.jpeg.o)
(seed.image   . o.png.o)
(seed.model3d . o.gltf.o)
(seed.model3d . o.glb.o)
```

The media bridge gates hardware effects only when the carrier has a local receipt-backed authorization and a nonzero carrier hash.

| Effect | Bridge word | Offset | Meaning |
| --- | --- | --- | --- |
| Streaming | `0x1A55` | `0x18` | P2P media stream frame |
| Render | `0x1B55` | `0x1C` | GPU/WebGL render path |
| Capture | `0x1C55` | `0x20` | Sensor capture path |
| Transcode | `0x1D55` | `0x24` | Format transcode path |

Conformance target:

```sh
make test-media-bridge
```

This layer gates effects. It does not validate relations, merge origins, or issue receipts.
