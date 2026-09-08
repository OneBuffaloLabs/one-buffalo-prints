// =========================================================================
// ColdFrontForge - Cold Snap Slab (Universal Magnetic Toploader Display)
// File: cold-snap-slab.scad
// =========================================================================

/* [Output Selection] */
part = "assembly"; // [assembly, back_plate, front_plate, print_bed_layout]

/* [Universal Slab Profile Dimensions (mm)] */
slab_w             = 81.5;
slab_h             = 136.0;
slab_total_t       = 6.5;
corner_radius      = 3.5;

/* [Internal Toploader Pocket (35pt)] */
tl_raw_w           = 76.0;
tl_raw_h           = 101.0;
tl_raw_t           = 2.0;
tl_clearance       = 1.2;

tl_slot_w          = tl_raw_w + tl_clearance;   // 77.2 mm
tl_slot_h          = tl_raw_h + tl_clearance;   // 102.2 mm
tl_slot_t          = tl_raw_t + 0.4;            // 2.4 mm total slot depth
tl_offset_bottom   = 3.5;                       // Bottom frame margin

/* [Front & Back Dual Viewing Window] */
window_w           = 64.0;
window_h           = 90.0;
window_corner_r    = 2.0;

/* [Unified Magnet Hardware (5x2 mm)] */
mag_d              = 5.0;
mag_h              = 2.0;
mag_fit_tolerance  = 0.2;                        // Radial print slop
mag_hole_d         = mag_d + mag_fit_tolerance; // 5.2 mm
mag_hole_h         = mag_h + 0.2;               // 2.2 mm
mag_margin         = 4.5;                       // Corner margin

/* [Swappable Label Tag System Seat (Expanded)] */
tag_w              = 68.0;
tag_h              = 23.0;                      // Expanded for vertical breathing room
tag_recess_depth   = 1.2;
tag_clearance      = 0.6;                       // Perimeter seat gap
tag_mag_spacing    = 42.0;                      // Magnet center-to-center

/* [Rendering Smoothness & Slop] */
$fn = 48;
eps = 0.02;

plate_t            = slab_total_t / 2;          // 3.25 mm per shell
pocket_depth_half  = tl_slot_t / 2;             // 1.2 mm pocket in each shell
tag_center_y       = slab_h - (tag_h / 2 + 3.8);

// =========================================================================
// 2D HELPERS
// =========================================================================
module rounded_rect_2d(size, r) {
    hull() {
        translate([r, r])                         circle(r = r);
        translate([size.x - r, r])                circle(r = r);
        translate([size.x - r, size.y - r])       circle(r = r);
        translate([r, size.y - r])                circle(r = r);
    }
}

// =========================================================================
// MAGNET CUTOUT HELPERS
// =========================================================================
module corner_magnet_cutouts(h = mag_hole_h) {
    translate([mag_margin, mag_margin, -eps])
        cylinder(d = mag_hole_d, h = h + eps);
    translate([slab_w - mag_margin, mag_margin, -eps])
        cylinder(d = mag_hole_d, h = h + eps);
    translate([mag_margin, slab_h - mag_margin, -eps])
        cylinder(d = mag_hole_d, h = h + eps);
    translate([slab_w - mag_margin, slab_h - mag_margin, -eps])
        cylinder(d = mag_hole_d, h = h + eps);
}

// =========================================================================
// BACK PLATE
// =========================================================================
module back_plate() {
    difference() {
        // Base solid
        linear_extrude(plate_t)
            rounded_rect_2d([slab_w, slab_h], corner_radius);

        // Lower half of internal toploader cavity
        translate([(slab_w - tl_slot_w) / 2, tl_offset_bottom, plate_t - pocket_depth_half])
            cube([tl_slot_w, tl_slot_h, pocket_depth_half + eps]);

        // Open back viewing window
        translate([(slab_w - window_w) / 2, tl_offset_bottom + (tl_slot_h - window_h) / 2, -eps])
            linear_extrude(plate_t + 2 * eps)
                rounded_rect_2d([window_w, window_h], window_corner_r);

        // 4 corner clamp magnets
        translate([0, 0, plate_t - mag_hole_h])
            corner_magnet_cutouts(h = mag_hole_h);
    }
}

// =========================================================================
// FRONT PLATE
// =========================================================================
module front_plate() {
    difference() {
        // Front shell solid
        linear_extrude(plate_t)
            rounded_rect_2d([slab_w, slab_h], corner_radius);

        // Upper half of toploader cavity (inner face)
        translate([(slab_w - tl_slot_w) / 2, tl_offset_bottom, -eps])
            cube([tl_slot_w, tl_slot_h, pocket_depth_half + eps]);

        // Open front viewing window
        translate([(slab_w - window_w) / 2, tl_offset_bottom + (tl_slot_h - window_h) / 2, -eps])
            linear_extrude(plate_t + 2 * eps)
                rounded_rect_2d([window_w, window_h], window_corner_r);

        // 4 corner clamp magnets (inner face)
        corner_magnet_cutouts(h = mag_hole_h);

        // Recessed seat for swappable tag
        translate([(slab_w - (tag_w + tag_clearance)) / 2, 
                   tag_center_y - (tag_h + tag_clearance) / 2, 
                   plate_t - tag_recess_depth])
            cube([tag_w + tag_clearance, tag_h + tag_clearance, tag_recess_depth + eps]);

        // Fingernail release notch on right edge of tag recess
        translate([(slab_w + tag_w + tag_clearance) / 2 - 1.0, tag_center_y - 3.5, plate_t - tag_recess_depth])
            cube([3.5, 7.0, tag_recess_depth + eps]);

        // Tag retention magnets (drilled into header)
        translate([slab_w / 2 - tag_mag_spacing / 2, tag_center_y, plate_t - tag_recess_depth - mag_hole_h])
            cylinder(d = mag_hole_d, h = mag_hole_h + eps);
        translate([slab_w / 2 + tag_mag_spacing / 2, tag_center_y, plate_t - tag_recess_depth - mag_hole_h])
            cylinder(d = mag_hole_d, h = mag_hole_h + eps);
    }
}

// =========================================================================
// SCENE OUTPUT
// =========================================================================
if (part == "assembly") {
    color("GhostWhite") back_plate();
    color("GhostWhite") translate([0, 0, plate_t + 6.0]) front_plate();
}
else if (part == "back_plate") {
    back_plate();
}
else if (part == "front_plate") {
    rotate([180, 0, 0])
        front_plate();
}
else if (part == "print_bed_layout") {
    back_plate();
    translate([slab_w + 8, slab_h, plate_t])
        rotate([180, 0, 0])
            front_plate();
}