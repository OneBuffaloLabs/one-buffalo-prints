# TCG Supply & Card Dimensions Reference

Reference specifications measured via digital caliper for CAD modeling, clearance checks, and parametric OpenSCAD scripts.

> **Note:** Dimensions represent raw physical items. When modeling slots or bays, add your required clearance/tolerance (typically **+0.8mm to +1.5mm** depending on fit preference and print shrinkage).

| Item / Supply | Width ($X$) | Height ($Y$) | Thickness ($Z$) | Typical Tolerance Added |
| :--- | :--- | :--- | :--- | :--- |
| **Penny Sleeves** | 67.0 mm | 92.0 mm | Variable | +1.5 mm to +2.0 mm |
| **Top Loaders (35pt)** | 76.0 mm | 101.0 mm | ~2.0 mm | +1.0 mm to +1.5 mm |
| **Semi-Rigid Holders** | 85.0 mm | 122.0 mm | ~1.5 mm | +1.2 mm to +1.5 mm |
| **Magnetic One-Touch** | 44.0 mm | 110.0 mm | ~8.0 mm | +0.8 mm to +1.2 mm |

---

## OpenSCAD Variable Snippet

Ready-to-use variable definitions for parametric inclusion in `.scad` scripts:

```openscad
// ==========================================
// TCG RAW REFERENCE DIMENSIONS (mm)
// ==========================================
PENNY_SLEEVE_DIM      = [67.0, 92.0];
TOPLOADER_35PT_DIM    = [76.0, 101.0, 2.0];
SEMI_RIGID_DIM        = [85.0, 122.0, 1.5];
MAGNETIC_HOLDER_DIM   = [44.0, 110.0, 8.0];

// Default recommended slot clearance
TCG_CLEARANCE = 1.2;
```