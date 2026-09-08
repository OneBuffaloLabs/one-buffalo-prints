// =============================================================================
// COLD SNAP DESK CADDY - EXACT SPECIFICATION MODEL
// Layout:
//   - Left bay: Full-depth slot with floor-level front cutout
//   - Right-front bay: Sized for toploaders/sleeves with a mid-height lip
//   - Right-rear bay: Full-height slot for semi-rigids
// =============================================================================

$fn = 48;
EPS = 0.02;

// --- Primary Dimensions ---
BOX_W          = 150.0;   // Overall width (X)
BOX_D          = 92.0;    // Overall depth (Y)
BOX_H          = 70.0;    // Rear/side wall height (Z)

WALL_T         = 3.2;     // Exterior perimeter wall thickness
DIVIDER_T      = 3.0;     // Internal divider thickness
FLOOR_T        = 3.0;     // Bottom floor thickness
OUTER_R        = 2.5;     // Exterior corner fillet radius

// --- Compartment Widths & Depths ---
LEFT_BAY_W     = 58.0;    // Sized for semi-rigids / cards placed sideways
RIGHT_FRONT_D  = 46.0;    // Front-to-back depth of front-right pocket

// --- Front Cutout Geometry ---
// Left bay cuts all the way down to floor level
LEFT_NOTCH_W   = 44.0;    // Front opening width
LEFT_POST_W    = 7.0;     // Retention ears left & right of the front opening

// Right bay cutout (leaves a retaining lip at the bottom)
RIGHT_LIP_H    = 24.0;    // Height of front retaining lip
RIGHT_NOTCH_W  = 62.0;    // Width of opening above the lip
RIGHT_POST_W   = 6.0;     // Retention ear width on the outer right edge

// --- Internal Derived Variables ---
AVAIL_X        = BOX_W - (2 * WALL_T) - DIVIDER_T;
RIGHT_BAY_W    = AVAIL_X - LEFT_BAY_W;

AVAIL_Y        = BOX_D - (2 * WALL_T);
LEFT_BAY_D     = AVAIL_Y;
RIGHT_REAR_D   = AVAIL_Y - RIGHT_FRONT_D - DIVIDER_T;

// Sub-Module: 2D Rounded Perimeter Base
module rounded_rect_2d(width, depth, radius) {
    hull() {
        for (dx = [radius, width - radius]) {
            for (dy = [radius, depth - radius]) {
                translate([dx, dy]) circle(r = radius);
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
    // 1. Left Bay Full-Height Pass-Through (down to floor plate)
    translate([WALL_T + LEFT_POST_W, -EPS, FLOOR_T])
        cube([LEFT_NOTCH_W, WALL_T + 2 * EPS, BOX_H]);

    // 2. Right Front Bay Pass-Through (stops at retaining lip)
    x_right_start = WALL_T + LEFT_BAY_W + DIVIDER_T;
    translate([x_right_start + (RIGHT_BAY_W - RIGHT_NOTCH_W)/2, -EPS, RIGHT_LIP_H])
        cube([RIGHT_NOTCH_W, WALL_T + 2 * EPS, BOX_H]);
}

// Top-Level Solid Assembly
module cold_snap_desk_caddy() {
    difference() {
        // Outer Solid Shell
        linear_extrude(height = BOX_H)
            rounded_rect_2d(BOX_W, BOX_D, OUTER_R);

        // 1. Left Bay (Full-depth cavity)
        translate([WALL_T, WALL_T, FLOOR_T])
            pocket_cutter(LEFT_BAY_W, LEFT_BAY_D, BOX_H - FLOOR_T);

        // 2. Right Front Bay Cavity
        x_right = WALL_T + LEFT_BAY_W + DIVIDER_T;
        translate([x_right, WALL_T, FLOOR_T])
            pocket_cutter(RIGHT_BAY_W, RIGHT_FRONT_D, BOX_H - FLOOR_T);

        // 3. Right Rear Bay Cavity
        y_rear = WALL_T + RIGHT_FRONT_D + DIVIDER_T;
        translate([x_right, y_rear, FLOOR_T])
            pocket_cutter(RIGHT_BAY_W, RIGHT_REAR_D, BOX_H - FLOOR_T);

        // 4. Front Face Finger/Grab Slots
        front_cutouts();
    }
}

cold_snap_desk_caddy();