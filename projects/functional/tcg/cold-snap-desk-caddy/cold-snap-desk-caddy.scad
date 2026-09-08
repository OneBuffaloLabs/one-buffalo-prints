// =============================================================================
// COLD SNAP DESK CADDY - REVERSED LAYOUT
// Layout:
//   - Left-front bay: Sized for toploaders/sleeves with a mid-height retaining lip
//   - Left-rear bay: Full-height slot for semi-rigids
//   - Right bay: Full-depth slot for penny sleeves with a floor-level cutout
// =============================================================================

$fn = 48;
EPS = 0.02;

// --- Primary Dimensions ---
BOX_W = 170.0; // Expanded from 150.0 to clear both widths comfortably
BOX_D = 92.0; // Overall depth (Y)
BOX_H = 70.0; // Rear/side wall height (Z)

WALL_T = 3.2; // Exterior perimeter wall thickness
DIVIDER_T = 3.0; // Internal divider thickness
FLOOR_T = 3.0; // Bottom floor thickness
OUTER_R = 2.5; // Exterior corner fillet radius

// --- Calibrated Compartment Widths & Depths ---
RIGHT_BAY_W = 70.0; // Sized for 67mm penny sleeves (+3.0mm clearance)
LEFT_FRONT_D = 46.0; // Front-to-back depth for toploaders (~20-22 toploaders)

// Left bay width derives automatically:
// 170 - (2 * 3.2) - 3.0 - 70.0 = 90.6mm
// Gives +5.6mm clearance for 85mm semi-rigids, +14.6mm for 76mm toploaders

// --- Front Cutout Geometry (Aligned to New Widths) ---
LEFT_LIP_H = 24.0;
LEFT_NOTCH_W = 70.0; // Widened opening for comfortable finger grab on toploaders

RIGHT_NOTCH_W = 54.0; // Widened floor-level scoop for penny sleeves
RIGHT_POST_W = 8.0;

// --- Internal Derived Variables ---
AVAIL_X = BOX_W - (2 * WALL_T) - DIVIDER_T;
LEFT_BAY_W = AVAIL_X - RIGHT_BAY_W;

AVAIL_Y = BOX_D - (2 * WALL_T);
RIGHT_BAY_D = AVAIL_Y;
LEFT_REAR_D = AVAIL_Y - LEFT_FRONT_D - DIVIDER_T;

// Sub-Module: 2D Rounded Perimeter Base
module rounded_rect_2d(width, depth, radius) {
  hull() {
    for (dx = [radius, width - radius]) {
      for (dy = [radius, depth - radius]) {
        translate([dx, dy]) circle(r=radius);
      }
    }
  }
}

// Sub-Module: Chamfered Internal Cavity Cutter
module pocket_cutter(width, depth, height, chamfer = 2.0) {
  translate([0, 0, chamfer])
    cube([width, depth, height - chamfer + 2 * EPS]);

  hull() {
    translate([chamfer, chamfer, 0])
      cube([width - 2 * chamfer, depth - 2 * chamfer, EPS]);
    translate([0, 0, chamfer])
      cube([width, depth, EPS]);
  }
}

// Sub-Module: Front Face Pass-Through Windows
module front_cutouts() {
  // 1. Left Front Bay Window (stops at retaining lip)
  translate([WALL_T + (LEFT_BAY_W - LEFT_NOTCH_W) / 2, -EPS, LEFT_LIP_H])
    cube([LEFT_NOTCH_W, WALL_T + 2 * EPS, BOX_H]);

  // 2. Right Bay Window (cuts down to floor plate)
  x_right_start = WALL_T + LEFT_BAY_W + DIVIDER_T;
  translate([x_right_start + (RIGHT_BAY_W - RIGHT_NOTCH_W - RIGHT_POST_W), -EPS, FLOOR_T])
    cube([RIGHT_NOTCH_W, WALL_T + 2 * EPS, BOX_H]);
}

// Top-Level Solid Assembly
module cold_snap_desk_caddy() {
  difference() {
    // Outer Solid Shell
    linear_extrude(height=BOX_H)
      rounded_rect_2d(BOX_W, BOX_D, OUTER_R);

    // 1. Left Front Bay Cavity (Toploaders)
    translate([WALL_T, WALL_T, FLOOR_T])
      pocket_cutter(LEFT_BAY_W, LEFT_FRONT_D, BOX_H - FLOOR_T);

    // 2. Left Rear Bay Cavity (Semi-Rigids)
    y_left_rear = WALL_T + LEFT_FRONT_D + DIVIDER_T;
    translate([WALL_T, y_left_rear, FLOOR_T])
      pocket_cutter(LEFT_BAY_W, LEFT_REAR_D, BOX_H - FLOOR_T);

    // 3. Right Bay Cavity (Full-depth for Penny Sleeves)
    x_right = WALL_T + LEFT_BAY_W + DIVIDER_T;
    translate([x_right, WALL_T, FLOOR_T])
      pocket_cutter(RIGHT_BAY_W, RIGHT_BAY_D, BOX_H - FLOOR_T);

    // 4. Front Face Cutouts
    front_cutouts();
  }
}

cold_snap_desk_caddy();
