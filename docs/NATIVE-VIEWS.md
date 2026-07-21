# Native Views

Native views render `.o` declarations or resolved runtime state. They do not define a parallel data model.

## HTML

HTML uses Omi-Portal DOM carriers:

```html
<omi-node id="omi-<address>" data-omi="<address>"></omi-node>
<imo-node id="imo-<address>" data-imo="<address>"></imo-node>
```

## JSON Canvas

Canvas uses standard `.canvas` fields:

```text
nodes
edges
id
type
x
y
width
height
text
fromNode
toNode
fromSide
toSide
label
```

Native metadata belongs under `omi`.

## DOT and SVG

DOT source must be deterministic. SVG generated from DOT must be reproducible and treated as projection only.
