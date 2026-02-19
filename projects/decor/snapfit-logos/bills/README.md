# SnapFit Logo: Buffalo Bills

<p align="center">
  <img src="images/snapfit-bills-hero.png" alt="Buffalo Bills SnapFit Logo" width="600">
</p>

A multi-part, glue-less friction-fit 3D model of the Buffalo Bills logo. Designed in OpenSCAD for high-precision tolerances.

## 📂 Project Structure

- `snapfit_bills.scad` — The core parametric OpenSCAD model.
- `snapfit-bills-base-white.stl` — The main 6mm backing plate with recessed pockets.
- `snapfit-bills-insert-blue.stl` — The main buffalo body and legs.
- `snapfit-bills-insert-red.stl` — The red streak insert.
- `images/`
  - `bills_master.svg` — The source vector file with defined path IDs.
  - `snapfit-bills-hero.png` — High-resolution preview image.
- `README.md` — This file.

## 🛠 Print Instructions

This model is designed to be printed in three separate color stages and snapped together.

### Slicer Settings

- **Material:** PLA (recommended for stiffness).
- **Layer Height:** 0.2mm
- **Base Thickness:** 6.0mm (Premium heft)
- **Wall Generator:** **Arachne (REQUIRED)**. Classic wall generators will struggle with the thin gaps around the eye and the red streak's narrow tail
- **Elephant Foot Compensation:** 0.15mm. *CRITICAL for the snap fit! If the first layer squishes out, the pieces will not fit into the base*
- **Top Surface Pattern:** Concentric (provides a professional, sweeping finish that follows the logo's curves)
- **Infill:** 15% Gyroid

## 🧩 Assembly & Fit Guide

This model is a **SnapFit** design, meaning it relies on friction and precise tolerances to hold together.

1. **Dual-Tolerance Design:** Because the red streak is much thinner than the blue body, this model uses two different clearances:
   - **Blue Body:** 0.10mm clearance
   - **Red Streak:** 0.05mm clearance
2. **Installation:** Lay the white base on a flat, hard surface. Position the blue body first, then the red streak. Press down firmly with the flat of your thumb
3. **Troubleshooting:**
   - **Too Tight?** If you cannot press the pieces in, double-check that your Wall Generator is set to Arachne. You can also lightly scrape/sand the bottom edges of the inserts
   - **Too Loose?** Every printer handles tolerances differently. If the pieces fall out, a single tiny drop of CA glue (Super Glue) in the pocket will secure them permanently

## 🔧 Customization

To structurally adjust the tightness of the fit, open `snapfit_bills.scad` and tweak the clearance variables:

- `clearance = 0.10;` (Main body fit)
- `red_clearance = 0.05;` (Thin streak fit)

---

*Disclaimer: This is a fan-art project provided for personal use only. It is not affiliated with, authorized by, or endorsed by the Buffalo Bills or the National Football League (NFL).*