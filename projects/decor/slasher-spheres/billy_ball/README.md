# Slasher Spheres: Billy the Puppet Pokéball

<p align="center">
  <img src="images/billy-ball-hero.png" alt="Billy the Puppet Pokéball" width="600">
</p>

A multi-part, support-free 3D model merging the classic Pokéball with the eerie features of Billy the Puppet from the *Saw* franchise. Designed entirely in OpenSCAD for high-precision assembly, featuring **recessed eye sockets**, signature **red cheek spirals**, and a **mechanical jaw-line** aesthetic consistent with the puppet's iconic design.

## 📂 Project Structure

- `billy_ball.scad` — The core parametric OpenSCAD model.
- `billy-ball-top.stl` — The white top hemisphere featuring recessed eye sockets and cheek spiral pockets.
- `billy-ball-bottom.stl` — The black bottom hemisphere with a **flattened base** for stability and the chin/jaw section.
- `billy-ball-ring.stl` — The main black equatorial band.
- `billy-ball-front-ring.stl` — The outer black button housing.
- `billy-ball-button.stl` — The stepped center red button (matching Billy's bow tie).
- `billy-ball-filler.stl` — The rectangular internal alignment peg.
- `billy-chips-red.stl` — The red spiral inserts for the cheeks and eye pupils.
- `billy-chips-black.stl` — The black eye socket backings.
- `images/`
  - `billy-ball-exploded.png` — Exploded assembly preview.
  - `billy-ball-hero.png` — Final assembled hero shot.
- `README.md` — This file.

## 🛠 Print Instructions

This model is designed to be printed in separate color batches and assembled.

### Slicer Settings

- **Material:** PLA or PETG.
- **Layer Height:** 0.2mm.
- **Seam Position:** **Back (REQUIRED).** Keep the Z-seam away from the cheeks and eyes for a smooth "porcelain mask" finish.
- **Orientation / Supports:** **NO SUPPORTS REQUIRED.** All parts feature flat mating surfaces designed for easy bed adhesion.
- **Wall Perimeters:** **3 to 4 walls.** Essential for ensuring the recessed pockets have a solid floor.
- **Wall Generator:** **Arachne (REQUIRED).** This is critical for the fine lines of the cheek spirals.
- **Infill:** 15% Gyroid for shells; **100% Infill for all Chips** (spirals and eyes) to ensure durability during press-fitting.
- **Elephant Foot Compensation:** 0.15mm. **CRITICAL!** The spirals are high-tolerance parts; any "squish" on the first layer will prevent them from seating.

---

## 🧩 Assembly & Fit Guide

This model utilizes a **full friction-fit assembly** designed for a clean, glue-less look.

1. **The "Mechanical Puppet" Look:** The eye sockets are deep-set, while the cheek spirals sit slightly proud or flush depending on your settings, mimicking the applied paint/carving of the original puppet.
2. **Installation Steps:**
   - **Step 1 (The Face):** Press the red spirals into the circular cheek pockets on the top shell. Insert the black eye backings and the red pupil chips into the orbital sockets.
   - **Step 2 (The Core):** Insert the rectangular filler peg into the flattened black bottom shell. Slide the center ring over the peg, then snap the white top shell into place.
   - **Step 3 (The Button):** Press the red button into the black front ring, then press that assembly into the front cutout of the sphere.

3. **Troubleshooting:**
   - **Spiral Fit:** If the spirals are too tight, ensure your **Arachne** wall generator is on. You can also lightly sand the outer edge of the red insert.
   - **Too Loose?** Use a tiny dab of CA glue behind the spirals. Since they are circular, they may spin if the fit isn't perfectly snug.
   - **Alignment:** Ensure the spirals are oriented correctly before pressing; once seated, the friction makes them difficult to rotate.

---

## 🔧 Customization

To adjust the tightness for your specific printer, open `billy_ball.scad` and tweak the clearance variables:

- `mechanical_clearance = 0.05;` (Controls internal peg and button assembly)
- `spiral_clearance = 0.02;` (Tighter tolerance for the circular cheek inserts)
- `eye_pocket_depth = 4.0;` (Controls the depth of the "staring" eye effect)

---

_Disclaimer: This is a fan-art project provided for personal use only. It is not affiliated with, authorized by, or endorsed by the Saw franchise, Lionsgate Films, Twisted Pictures, Pokémon, or Nintendo._