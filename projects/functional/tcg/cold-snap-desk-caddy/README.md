# Cold Snap Desk Caddy

A tiered, functional 3D printed workstation organizer designed to keep primary card-prep supplies upright, separated, and instantly accessible during box breaks and grading prep.

![Hero Image](images/hero-shot.jpg)

## 🖨️ Recommended Print Settings

To get the best results, especially if this is a functional part, we recommend the following settings:

- **Material:** PLA or PETG (PETG recommended if your setup gets direct sunlight or sits near hot PC exhausts)
- **Layer Height:** 0.20mm
- **Infill:** 15% (Gyroid or Grid)
- **Wall Loops (Perimeters):** 3-4 for extra strength
- **Supports:** None required (oriented flat on the build plate)
- **Brim:** Not necessary unless you have bed warping issues

## 🔩 Hardware Required

100% 3D Printed - No extra hardware needed!

## 🛠️ Customizing with OpenSCAD

Because this design is parametric, you can easily adjust the dimensions to fit your specific needs using the included `.scad` file.

**Key Variables You Can Change:**

- `SLOT_SLEEVE_W` / `SLOT_SLEEVE_D` - Adjusts the front penny sleeve pocket size (Default: 74mm x 42mm)
- `SLOT_TOPLOADER_W` / `SLOT_TOPLOADER_D` - Adjusts the middle toploader pocket size (Default: 85mm x 56mm)
- `SLOT_SEMIRIGID_W` / `SLOT_SEMIRIGID_D` - Adjusts the rear semi-rigid card saver pocket size (Default: 94mm x 50mm)
- `WALL_T` - Outer structural perimeter thickness (Default: 3.0mm)
- `ENABLE_SCOOP` - Set to `false` if you want a flat front wall with no thumb notch

_To modify, simply open the file in [OpenSCAD](https://openscad.org/), change the variables at the top of the script, press `F6` to render, and `F7` to export your new STL._

## 🧩 Assembly Instructions

1. Remove the finished print from your build plate (no support cleanup needed).
2. Load 100+ standard penny sleeves into the front pocket.
3. Drop ~30 standard 35pt toploaders into the middle tier.
4. Slide ~45 standard semi-rigid card savers into the tall rear pocket.
5. Enjoy a clean, organized grading prep and rip station!

---

*Part of the [Cold Front Forge](https://github.com/OneBuffaloLabs/ColdFrontForge) open-source collection. Licensed under CC BY-NC-SA 4.0.*
*Looking for finished physical prints or custom colors? Visit our shop: [coldfrontforge.etsy.com](https://coldfrontforge.etsy.com/)*