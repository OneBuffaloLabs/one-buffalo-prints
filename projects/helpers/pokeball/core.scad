/* SHARED POKÉBALL CORE CHASSIS */

// --- CORE DIMENSIONS ---
ball_radius = 40;
ring_height = 6;

// --- FRONT ASSEMBLY DIMENSIONS ---
front_ring_outer_r = 13;
front_ring_inner_r = 9;
front_ring_depth = 4;
button_inner_radius = 7;
front_pocket_depth = 6;

// --- TOLERANCES & CLEARANCES (From Jason) ---
mechanical_clearance = 0.05;
chip_clearance = 0.05;
button_clearance = 0.0;

// --- MANIFOLD GEOMETRY & RESOLUTION ---
eps = 0.01;
$fn = $preview ? 32 : 120;

// --- CORE HARDWARE MODULES ---

module center_ring() {
    difference() {
        cylinder(r=ball_radius - 0.5, h=ring_height, center=true);

        filler_cutout();

        translate([0, -ball_radius + front_pocket_depth, 0])
            rotate([90, 0, 0])
                cylinder(r=front_ring_outer_r + mechanical_clearance, h=front_pocket_depth + eps * 2, center=false);
    }
}

module front_ring() {
    translate([0, -(ball_radius - (front_ring_depth / 2)), 0])
        rotate([90, 0, 0])
            difference() {
                cylinder(r=front_ring_outer_r - button_clearance, h=front_ring_depth, center=true);
                cylinder(r=front_ring_inner_r + button_clearance, h=front_ring_depth + eps * 2, center=true);
            }
}

module center_button() {
    translate([0, -(ball_radius - (front_ring_depth / 2)), 0])
        rotate([90, 0, 0])
            union() {
                cylinder(r=front_ring_inner_r - button_clearance, h=front_ring_depth, center=true);
                translate([0, 0, front_ring_depth / 2])
                    cylinder(r=button_inner_radius, h=2, center=false); // Height 2mm (From Jason)
            }
}

// --- FEATURE PLACEMENT ENGINE ---

module place_outward(tilt, pan, hover = 0) {
    rotate([0, 0, pan])
        rotate([-tilt, 0, 0])
            translate([0, -(ball_radius + hover), 0])
                rotate([-90, 0, 0])
                    children();
}