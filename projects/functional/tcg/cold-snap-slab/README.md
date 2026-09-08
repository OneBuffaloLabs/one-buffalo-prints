# Cold Snap Slab

<p align="center">
<img src="images/hero.png" alt="Cold Snap Slab" width="600">
</p>

Give your favorite raw cards the premium look of a graded slab while keeping them safely protected in standard toploaders.

The **Cold Snap Slab** is a magnetic, two-piece display frame sized to match standard universal grading slabs (PSA and TAG). Designed with an open-back window to showcase both sides of the card, it features a swappable magnetic header system that lets you snap in fun custom tags—whether you are rocking the house "Cold Snap Gem 10", repping "Pack Fresh / Raw", or dropping in your own custom label with an active, scannable QR code.

## ✨ Features

* **Universal Slab Footprint:** Sized at 81.5 × 136.0 × 6.5mm to match PSA and TAG slabs, fitting standard slab stands and display cases.
* **Toploader Protection:** Built around standard 35pt toploaders (76 × 101mm) so your raw cards never touch bare 3D-printed walls.
* **Dual-Sided Viewing:** Open viewing cutouts on both front and back plates keep card art, text, and conditions fully visible.
* **Swappable Magnetic Headers:** Front header recess lets you swap out custom-grade parody labels on the fly using built-in 5x2mm magnets.
* **Scannable QR System:** Every label variant carries a scannable QR code matrix rendered directly into the extruded design.
* **Fingernail Release Notch:** Integrated side notch makes swapping label tags effortless without scratching the frame.

## 📦 What's Included / Models

* `cold-snap-slab.scad` — Enclosure file for the magnetic front and back slab shells
* `cold-snap-labels.scad` — Parametric generator for the swappable header tags
* `qr-matrices.scad` — Auto-generated binary matrix data for QR code geometry
* `generate-qr.js` — Node CLI tool to compile standard and custom URLs into OpenSCAD data

## ⚡ Generating QR Code Matrices

OpenSCAD cannot convert raw string URLs into QR codes natively. We use a lightweight Node script via `pnpm` to compile the URLs into a binary matrix lookup table (`qr-matrices.scad`).

### 1. First-time Setup
Run inside the `cold-snap-slab` project folder:
```bash
pnpm install

```

### 2. Generate Standard Presets

Generates genuine QR codes pointing to `https://coldfrontforge.com/cold-snap-slab/{designation}`:

```bash
pnpm run generate-qr

```

### 3. Generate a Custom URL for Someone Specific

Pass any custom URL directly to populate the `custom` preset:

```bash
node generate-qr.js "[https://my-custom-link.com/profile](https://my-custom-link.com/profile)"

```

Then open `cold-snap-labels.scad`, set `preset = "custom"`, configure your title and grade, and render!

## 🖨️ Recommended Print Settings

* **Material:** PLA+ or PETG
* **Layer Height:** 0.20mm for the slab body; 0.12mm–0.16mm recommended for label tags for crisp text and QR readability.
* **Walls/Perimeters:** 3–4 walls for solid magnet sockets.
* **Infill:** 15%–20% (Gyroid or Grid).
* **Print Orientation:**
* **Back Plate:** Print flat, exterior textured/smooth face on the bed.
* **Front Plate:** Flip 180° so the front face lies flat on the build plate (prints 100% support-free).
* **Labels:** Print face-up. Use a single color swap at layer height 2.20mm (from white base to accent color) to print the border, text, QR code, and snowflake in one pass.


* **Supports:** None required.

## 🔩 Hardware Required

* **Magnets:** Twelve (12) 5x2mm round neodymium disc magnets
* 8× for the slab corners (front & back clamping)
* 4× for the header system (2 in the front plate, 2 in the tag)


* **Adhesive:** CA glue (Super Glue) to seat magnets flush into pockets

## 🛠️ Making Adjustments

* **Slab Enclosure:** Open `cold-snap-slab.scad` to adjust card clearances, magnet dimensions, or wall thicknesses.
* **Labels:** Open `cold-snap-labels.scad` to toggle presets, test custom titles and grades, or adjust QR placement.

Update values at the top of either file, hit `F5` to preview or `F6` to render, and export your updated STLs.

## 🧩 Assembly & Setup

1. **Check Polarity:** Before applying adhesive, test magnet poles so the front and back shells attract cleanly, and ensure the label tag snaps into the front recess.
2. **Install Frame Magnets:** Add a drop of CA glue into each of the 4 corner pockets on both the front and back plates. Press in the 5x2mm magnets flush.
3. **Install Tag Magnets:** Glue two magnets into the front plate header pocket and the matching two magnets into the back of your label tag.
4. **Cure:** Let the adhesive fully cure before closing the shells to prevent CA fumes from fogging the plastic toploader.
5. **Load Card:** Place your sleeved card inside a standard 35pt toploader, insert it into the back pocket, snap the front frame in place, and pop in your header tag.

*(Cards and toploaders shown in photos are for demonstration purposes only and not included.)*

---

Part of the [Cold Front Forge](https://github.com/OneBuffaloLabs/ColdFrontForge) open-source collection. Licensed under CC BY-NC-SA 4.0.

*Looking for finished physical prints or custom colors? Visit our shop: [coldfrontforge.etsy.com*](https://www.google.com/search?q=https://coldfrontforge.etsy.com)
