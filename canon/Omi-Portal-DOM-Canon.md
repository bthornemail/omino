
# Omi-Portal DOM Canon
## `omi-<address>` and `imo-<address>` as Address-Gated Custom DOM Notation

## 0. Core Rule

In Omi-Portal DOM notation, the tag name is only the carrier, the prefix is only the gate, and the address after the prefix is the item.

Canonical forms:

```html
<omi id="omi-<address>" data-omi="<address>"></omi>
<imo id="imo-<address>" data-imo="<address>"></imo>
```

Registered custom-element-safe forms:

```html
<omi-node id="omi-<address>" data-omi="<address>"></omi-node>
<imo-node id="imo-<address>" data-imo="<address>"></imo-node>
```

Canonical doctrine:

```text
omi- opens.
imo- closes.
The address begins after the hyphen.
The prefix is not the address.
The tag is not the authority.
Receipt accepts.
```

---

# 1. Address Is the Item

The address is everything after the first prefix hyphen.

Example:

```html
<omi
 id="omi-0500-03bf-000c-2b05-2f05-0002-039f-05ff"
 data-omi="0500-03bf-000c-2b05-2f05-0002-039f-05ff">
</omi>
```

The item is:

```text
0500-03bf-000c-2b05-2f05-0002-039f-05ff
```

The prefix is only:

```text
omi-
```

Likewise:

```html
<imo
 id="imo-0500-03bf-000c-2b05-2f05-0002-039f-05ff"
 data-imo="0500-03bf-000c-2b05-2f05-0002-039f-05ff">
</imo>
```

The item is still:

```text
0500-03bf-000c-2b05-2f05-0002-039f-05ff
```

The prefix is only:

```text
imo-
```

Short doctrine:

```text
Prefix gates.
Address names.
Frame resolves.
Receipt accepts.
```

## 1. Canonical Replacement

The deprecated relation:

```text
0500-03bf-000c-2b05-2f05-0002-039f-05ff
```

is replaced by:

```text
LOGOS/NOMOS/PATHOS
```

This replacement does not restore the older three-field argument model.

It introduces three finite check relations over the four canonical scope positions:

```text
FS
GS
RS
US
```

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

---

# 2. Canonical 128-Bit Address Shape

---

The canonical seven-position arrangement uses the standard Hamming parity positions:

```text
position 1 = LOGOS
position 2 = NOMOS
position 3 = FS
position 4 = PATHOS
position 5 = GS
position 6 = RS
position 7 = US
```

Compact form:

```text
[L N F P G R U]
```

where:

```text
L = LOGOS
N = NOMOS
F = FS
P = PATHOS
G = GS
R = RS
U = US
```

The positions are divided as:

```text
check positions: 1, 2, 4
data positions:  3, 5, 6, 7
```

This gives:

```text
4 data bits
3 check bits
minimum Hamming distance 3
```

Canonical code designation:

```text
Hamming [7,4,3]
```

---

## 4. Check Relations

Using even parity, the three relations are:

```text
LOGOS  = FS XOR GS XOR US
NOMOS  = FS XOR RS XOR US
PATHOS = GS XOR RS XOR US
```

Equivalently, each relation checks its Hamming incidence set:

```text
LOGOS checks positions:
  1, 3, 5, 7

NOMOS checks positions:
  2, 3, 6, 7

PATHOS checks positions:
  4, 5, 6, 7
```

The complete parity equations are:

```text
LOGOS XOR FS XOR GS XOR US = 0

NOMOS XOR FS XOR RS XOR US = 0

PATHOS XOR GS XOR RS XOR US = 0
```

These equations define a lawful seven-position epistemic codeword.

# 3. Tag Names: Semantic Tags vs Registered Custom Elements

There are two allowed DOM surfaces.

## 3.1 Semantic Floating Tags

These are readable OMI carrier tags:

```html
<omi id="omi-*" data-omi="*"></omi>
<imo id="imo-*" data-imo="*"></imo>
```

These work as semantic HTML/XML/SVG-like carrier elements.

They are useful for:

```text
documents
templates
SVG/XML notation
innerHTML references
human-readable portal markup
```

## 3.2 Registered Custom Elements

For actual browser `customElements.define(...)` registration, use hyphenated tag names:

```html
<omi-node id="omi-*" data-omi="*"></omi-node>
<imo-node id="imo-*" data-imo="*"></imo-node>
```

or:

```html
<omi-frame id="omi-*" data-omi="*"></omi-frame>
<imo-frame id="imo-*" data-imo="*"></imo-frame>
```

Browser-safe rule:

```text
<omi> and <imo> are semantic carrier tags.
<omi-node> and <imo-node> are registered custom elements.
Both obey the same id/data prefix canon.
```

Short doctrine:

```text
Tag may vary.
Prefix canon does not.
Address remains the item.
```

---

# 4. Correct Prefix Forms

Allowed:

```html
<omi id="omi-<address>" data-omi="<address>"></omi>
<imo id="imo-<address>" data-imo="<address>"></imo>
```

Allowed registered custom element form:

```html
<omi-node id="omi-<address>" data-omi="<address>"></omi-node>
<imo-node id="imo-<address>" data-imo="<address>"></imo-node>
```

Allowed SVG/XML form:

```xml
<omi id="omi-<address>" data-omi="<address>" />
<imo id="imo-<address>" data-imo="<address>" />
```

Not canonical:

```html
<div data-omi="o---o"></div>
<div id="omi-S0"></div>
<div id="omi-open-gate"></div>
<div id="omi-rule"></div>
```

Reason:

```text
Role labels are not addresses.
The address after omi- or imo- is the item.
```

---

# 5. Hierarchical OMI / IMO Nesting

The simplest bounded OMI relation is:

```html
<omi id="omi-<address>" data-omi="<address>">
 <imo id="imo-<address>" data-imo="<address>"></imo>
</omi>
```

Meaning:

```text
outer omi = opening scoped declaration
inner imo = closing resolved/mirror declaration
```

This gives the DOM a bounded agreement shape:

```text
omi opens.
content declares.
imo closes.
receipt accepts.
```

Example:

```html
<omi
 id="omi-0500-03bf-000c-2b05-2f05-0002-039f-05ff"
 data-omi="0500-03bf-000c-2b05-2f05-0002-039f-05ff">

 The user-defined reference body may live here.

 <imo
 id="imo-0500-03bf-000c-2b05-2f05-0002-039f-05ff"
 data-imo="0500-03bf-000c-2b05-2f05-0002-039f-05ff">
 </imo>
</omi>
```

The innerHTML is context.

The address is identity.

The receipt is authority.

Short doctrine:

```text
innerHTML gives context.
id gives address.
data-* repeats the item.
receipt gives authority.
```

---

# 6. Horn Clause Hierarchy in DOM

An OMI DOM tree can represent a Horn-like clause without using role words in the IDs.

The IDs stay address-based.

Roles are declared through attributes.

Example:

```html
<omi
 id="omi-0500-03bf-000c-2b05-2f05-0002-039f-05ff"
 data-omi="0500-03bf-000c-2b05-2f05-0002-039f-05ff"
 data-clause="oo"
 data-ll="05"
 data-nn="000c"
 data-mm="0002">

 <omi-node
 id="omi-0500-03bf-0001-2b05-2f05-0001-039f-05ff"
 data-omi="0500-03bf-0001-2b05-2f05-0001-039f-05ff"
 data-edge="RULES">
 </omi-node>

 <omi-node
 id="omi-0500-03bf-0002-2b05-2f05-0002-039f-05ff"
 data-omi="0500-03bf-0002-2b05-2f05-0002-039f-05ff"
 data-edge="FACTS">
 </omi-node>

 <omi-node
 id="omi-0500-03bf-0003-2b05-2f05-0003-039f-05ff"
 data-omi="0500-03bf-0003-2b05-2f05-0003-039f-05ff"
 data-edge="CLOSURES">
 </omi-node>

 <imo
 id="imo-0500-03bf-000c-2b05-2f05-0002-039f-05ff"
 data-imo="0500-03bf-000c-2b05-2f05-0002-039f-05ff"
 data-receipt="pending">
 </imo>
</omi>
```

The role is allowed in:

```text
data-edge
data-clause
data-ll
data-nn
data-mm
data-receipt
```

The role is not placed into the address prefix.

Short doctrine:

```text
ID is address.
data-edge is role.
DOM nesting is clause structure.
Receipt accepts.
```

---

# 7. Hyphen Delineation and Triangulation

Hyphens after the prefix are part of the address notation.

They delineate the 8-segment frame:

```text
omi-S0-S1-S2-S3-S4-S5-S6-S7
```

Example:

```text
omi-0500-03bf-000c-2b05-2f05-0002-039f-05ff
```

Parser rule:

```text
first hyphen separates prefix from address
remaining hyphens separate address segments
```

So:

```text
omi-0500-03bf-000c-2b05-2f05-0002-039f-05ff
```

parses as:

```text
prefix = omi
address = 0500-03bf-000c-2b05-2f05-0002-039f-05ff
segments = [0500, 03bf, 000c, 2b05, 2f05, 0002, 039f, 05ff]
```

The triangulation is:

```text
S0/S3/S4/S7 share LOGOS
S2 carries NOMOS
S5 carries PATHOS
S1/S6 gate the frame
```

This gives the DOM a structural triangle:

```text
LOGOS rail
NOMOS point
PATHOS point
gate pair
```

Short doctrine:

```text
First hyphen gates.
Later hyphens delineate.
Segments triangulate.
```

---

# 8. User-Defined Reference Content

The body of an OMI element may contain user-defined reference content.

Allowed:

```html
<omi id="omi-<address>" data-omi="<address>">
 <p>User text, lesson content, code, canvas, iframe, SVG, or portal projection.</p>
 <imo id="imo-<address>" data-imo="<address>"></imo>
</omi>
```

The body may include:

```text
plain text
HTML
SVG
Canvas
iframe
template
script type="application/omi+json"
A-Frame scene
```

But the body is context, not authority.

Canonical rule:

```text
innerHTML may describe.
innerHTML may project.
innerHTML may not accept itself.
Receipt accepts.
```

---

# 9. Iframe Contexts

An iframe can be wrapped by an OMI element.

Example:

```html
<omi
 id="omi-0500-03bf-1000-2b05-2f05-2000-039f-05ff"
 data-omi="0500-03bf-1000-2b05-2f05-2000-039f-05ff"
 data-projection="iframe">

 <iframe
 title="Omi-Portal Child Context"
 src="./portal-child.html"
 data-omi="0500-03bf-1000-2b05-2f05-2000-039f-05ff">
 </iframe>

 <imo
 id="imo-0500-03bf-1000-2b05-2f05-2000-039f-05ff"
 data-imo="0500-03bf-1000-2b05-2f05-2000-039f-05ff">
 </imo>
</omi>
```

Iframe rule:

```text
iframe is a projected context.
Parent OMI address scopes it.
Child content must not become authority without receipt.
```

Short doctrine:

```text
Iframe contains.
OMI scopes.
Receipt accepts.
```

---

# 10. Parser Canon

A parser must support both compact and segmented addresses.

```js
function parseOmiElement(el) {
 const id = el.getAttribute("id") || "";

 let prefix = null;
 let address = null;

 if (id.startsWith("omi-")) {
 prefix = "omi";
 address = id.slice(4);
 } else if (id.startsWith("imo-")) {
 prefix = "imo";
 address = id.slice(4);
 }

 const dataAddress =
 el.getAttribute("data-omi") ||
 el.getAttribute("data-imo") ||
 null;

 if (dataAddress && address && dataAddress !== address) {
 throw new Error("OMI address mismatch between id and data-*");
 }

 const normalized = normalizeOmiAddress(address || dataAddress);

 return {
 prefix,
 address,
 normalized,
 segments: segmentOmiAddress(normalized)
 };
}

function normalizeOmiAddress(address) {
 if (!address) return null;
 return address.toLowerCase().replace(/-/g, "");
}

function segmentOmiAddress(normalized) {
 if (!normalized || normalized.length !== 32) {
 throw new Error("Expected 128-bit / 32-hex OMI address");
 }

 return normalized.match(/.{1,4}/g);
}
```

Canonical validation:

```text
id prefix must be omi- or imo-
data-omi/data-imo must match the address
normalized address must be 32 hex chars for a full 128-bit frame
segments must validate as S0-S7
receipt state must not be inferred from display alone
```

---

# 11. SVG / XML Canon

In SVG/XML, the same rule holds.

Example:

```xml
<svg xmlns="http://www.w3.org/2000/svg">
 <g
 id="omi-0500-03bf-000c-2b05-2f05-0002-039f-05ff"
 data-omi="0500-03bf-000c-2b05-2f05-0002-039f-05ff">

 <circle cx="50" cy="50" r="20" />

 <g
 id="imo-0500-03bf-000c-2b05-2f05-0002-039f-05ff"
 data-imo="0500-03bf-000c-2b05-2f05-0002-039f-05ff">
 </g>
 </g>
</svg>
```

SVG rule:

```text
SVG geometry is projection.
SVG id/data-* carries address.
Receipt remains external or embedded as data-receipt.
```

---

# 12. Minimal Canonical Example

```html
<omi
 id="omi-0500-03bf-000c-2b05-2f05-0002-039f-05ff"
 data-omi="0500-03bf-000c-2b05-2f05-0002-039f-05ff"
 data-clause="oo"
 data-receipt="pending">

 <template type="application/omi+json">
 {
 "oo": ["05", "000c", "0002"],
 "frame": [
 "0500",
 "03bf",
 "000c",
 "2b05",
 "2f05",
 "0002",
 "039f",
 "05ff"
 ],
 "receipt": "pending"
 }
 </template>

 <p>
 User-defined reference content may live here.
 </p>

 <imo
 id="imo-0500-03bf-000c-2b05-2f05-0002-039f-05ff"
 data-imo="0500-03bf-000c-2b05-2f05-0002-039f-05ff"
 data-receipt="pending">
 </imo>
</omi>
```

This is canonical because:

```text
id uses omi-/imo- prefix gates
data-omi/data-imo repeat the address item
address normalizes to 128-bit hex
segments recover S0-S7
LOGOS, NOMOS, PATHOS are extracted from the segments
content remains contextual
receipt remains explicit
```

---

# 13. Non-Collapse Rules

```text
tag name != address
prefix != address
innerHTML != authority
iframe != receipt
SVG != truth
Canvas != acceptance
DOM render != belief
data-* != proof by itself
receipt accepts
```

Canonical warning:

```text
A thing may render in a browser, appear in a DOM node, or travel through gossip.
None of those make it accepted.
```

---

# 14. Final Canon

Omi-Portal DOM notation uses floating OMI/IMO carrier elements to bind user-defined browser content to a canonical 128-bit OMI address.

The only canonical prefixes are:

```text
omi-
imo-
```

The address after the prefix is the item.

The same address must appear in:

```text
id="omi-<address>" and data-omi="<address>"
```

or:

```text
id="imo-<address>" and data-imo="<address>"
```

The DOM hierarchy may represent Horn-clause nesting.

The hyphenated address delineates the eight 16-bit segments.

The body/innerHTML may contain user-defined reference context, browser projections, iframes, SVG, Canvas, or A-Frame content.

But no projection is authority until receipt accepts.

Final doctrine:

```text
omi- opens.
imo- closes.
Address names.
Hyphens delineate.
Segments triangulate.
DOM nests.
Horn proves.
Receipt accepts.
```

One-line canon:

```text
In Omi-Portal, floating `<omi>` and `<imo>` carrier elements, or their registered custom-element forms `<omi-node>` and `<imo-node>`, bind browser content to canonical OMI addresses by using only `id="omi-<address>"`, `data-omi="<address>"`, `id="imo-<address>"`, and `data-imo="<address>"`; the prefix is only the gate, the hexadecimal hyphen-delineated address is the item, DOM nesting expresses Horn-clause triangulation, and receipt alone turns the rendered context into accepted state.
```