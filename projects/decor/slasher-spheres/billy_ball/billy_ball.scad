/* BILLY THE PUPPET (SAW) POKÉBALL */

// === CORE DIMENSIONS ===
part_to_render = "all"; // [all, top, bottom, ring, front_ring, button, filler, chips_black, chips_red]
exploded_view = false;

ball_radius = 40;
ring_height = 6;

// Rectangular Filler Dimensions
filler_width = 24;
filler_length = 14;
filler_height = 18;

// Front Assembly Dimensions
front_ring_outer_r = 13;
front_ring_inner_r = 9;
front_ring_depth = 4;
button_inner_radius = 7;
front_pocket_depth = 6;

// === HARDWARE & FEATURES ===
pocket_depth = 2.5;
accent_pocket_extra_depth = 0.5; // Sinks holes slightly deeper for a flush look

// Face Proportions
eye_outer_radius = 6.5;  // Outer bound of the black eye
eye_red_outer = 4.2;     // Outer edge of the red ring
eye_red_inner = 2;       // SHRUNK from 2.8 to make the inner black pupil smaller
red_ring_depth = 1.2;    // How deep the red ring snaps into the black eye

spiral_max_radius = 8.5;
spiral_thickness = 2.2;
spiral_turns = 2.5;

// === FACE PLACEMENT & TWEAKS ===
eye_tilt     = 40;   // Vertical height of eyes (Higher = further up)
eye_pan      = 25;   // Horizontal spacing (Higher = further apart)
eye_rotation = -15;  // Angle of the eye oval (Negative = inner corners point DOWN)

cheek_tilt   = 21;   // Vertical height of spirals (Higher = further up)
cheek_pan    = 48;   // Horizontal spacing of spirals

// === BOWTIE PLACEMENT ===
bowtie_tilt        = -28;  // Placed ~7mm under the ring on the bottom shell
bowtie_knot_size   = 12;
bowtie_wing_length = 25;
bowtie_peg_radius  = 4;
bowtie_peg_depth   = 3;

// === TOLERANCES ===
mechanical_clearance = 0.05; // Fit between main shell parts
chip_clearance = 0.05;       // Fit for snap-in face features
button_clearance = 0.05;     // Fit for the front button assembly
filler_xy_clearance = 0.1;   // Alignment peg horizontal tolerance
filler_z_clearance = 0.5;    // Alignment peg vertical tolerance

// === PRINT SETTINGS & RESOLUTION ===
eps = 0.01;
$fn = $preview ? 64 : 120;

// === COLORS ===
top_color = "white";
bottom_color = "white";
ring_color = "black";
front_ring_color = "black";
button_color = "black";
filler_color = "black";
c_black = "black";
c_red = "red";

// === RENDER LOGIC ===

if (part_to_render == "chips_black") { color(c_black) layout_chips_black(); }
if (part_to_render == "chips_red") { color(c_red) layout_chips_red(); }

if (part_to_render == "all") {
    if (exploded_view) {
        // Expanded View
        translate([0, 0, 35]) color(top_color) top_mask();
        translate([0, 0, -35]) color(bottom_color) bottom_shell();
        color(ring_color) center_ring();
        translate([0, -20, 0]) color(front_ring_color) front_ring();
        translate([0, -30, 0]) color(button_color) center_button();
        translate([0, 0, 15]) color(filler_color) alignment_filler();

        // Features attached to Top Shell
        translate([0, 0, 35]) {
            color(c_black) draw_eyes_black(hover=15);
            color(c_red) draw_eyes_red(hover=30); // Pops OUT of the black eye
            color(c_red) draw_cheeks(is_pocket=false, hover=15);
        }
        // Features attached to Bottom Shell
        translate([0, 0, -35]) {
            color(c_red) draw_bowtie(hover=30); // Increased hover so you can clearly see the peg/hole!
        }
    } else {
        // Normal Assembled View
        translate([0, 0, eps]) color(top_color) top_mask();
        translate([0, 0, -eps]) color(bottom_color) bottom_shell();
        color(ring_color) center_ring();
        color(front_ring_color) front_ring();
        color(button_color) center_button();
        color(filler_color) alignment_filler();

        // Features attached to Top Shell
        translate([0, 0, eps]) {
            color(c_black) draw_eyes_black(hover=0);
            color(c_red) draw_eyes_red(hover=0);
            color(c_red) draw_cheeks(is_pocket=false, hover=0);
        }
        // Features attached to Bottom Shell
        translate([0, 0, -eps]) {
            color(c_red) draw_bowtie(hover=0);
        }
    }
} else if (part_to_render != "chips_black" && part_to_render != "chips_red") {
    // Single Part Export Mode
    if (part_to_render == "top") color(top_color) top_mask();
    if (part_to_render == "bottom") color(bottom_color) bottom_shell();
    if (part_to_render == "ring") color(ring_color) center_ring();
    if (part_to_render == "front_ring") color(front_ring_color) front_ring();
    if (part_to_render == "button") color(button_color) center_button();
    if (part_to_render == "filler") color(filler_color) alignment_filler();
}

// === MAIN MODULES ===

module top_mask() {
    difference() {
        sphere(r=ball_radius);

        translate([0, 0, -50 + (ring_height / 2)])
            cube([150, 150, 100], center=true);

        cube([filler_width + filler_xy_clearance, filler_length + filler_xy_clearance, filler_height + filler_z_clearance], center=true);

        translate([0, -ball_radius + front_pocket_depth, 0])
            rotate([90, 0, 0])
                cylinder(r=front_ring_outer_r + mechanical_clearance, h=front_pocket_depth + eps * 2, center=false);

        // Billy's Face Features (Top)
        draw_eye_pockets();
        draw_cheeks(is_pocket=true);
    }
}

module bottom_shell() {
    difference() {
        sphere(r=ball_radius);

        translate([0, 0, 50 - (ring_height / 2)])
            cube([150, 150, 100], center=true);

        translate([0, 0, -87])
            cube([150, 150, 100], center=true);

        cube([filler_width + filler_xy_clearance, filler_length + filler_xy_clearance, filler_height + filler_z_clearance], center=true);

        translate([0, -ball_radius + front_pocket_depth, 0])
            rotate([90, 0, 0])
                cylinder(r=front_ring_outer_r + mechanical_clearance, h=front_pocket_depth + eps * 2, center=false);
                
        // Bowtie Peg Hole
        draw_bowtie_pocket();
    }
}

module center_ring() {
    difference() {
        cylinder(r=ball_radius - 0.5, h=ring_height, center=true);

        cube([filler_width + filler_xy_clearance, filler_length + filler_xy_clearance, ring_height + eps * 2], center=true);

        translate([0, -ball_radius + front_pocket_depth, 0])
            rotate([90, 0, 0])
                cylinder(r=front_ring_outer_r + mechanical_clearance, h=front_pocket_depth + eps * 2, center=false);
    }
}

module alignment_filler() {
    cube([filler_width, filler_length, filler_height], center=true);
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
                    cylinder(r=button_inner_radius, h=1.5, center=false);
            }
}

// === FEATURE PLACEMENT ENGINE ===

module place_outward(tilt, pan, hover = 0) {
    rotate([0, 0, pan])
        rotate([-tilt, 0, 0])
            translate([0, -(ball_radius + hover), 0])
                rotate([-90, 0, 0])
                    children();
}

// --- Billy's Eyes (Base Pocket in White Shell) ---
module draw_eye_pockets() {
    h_val = pocket_depth + accent_pocket_extra_depth + eps;
    for (m = [1, -1]) {
        place_outward(tilt=eye_tilt, pan=m * eye_pan, hover=0)
            rotate([0, 0, m * eye_rotation])
                translate([0, 0, -eps])
                    scale([1.5, 1, 1]) cylinder(r=eye_outer_radius, h=h_val);
    }
}

// --- Billy's Black Eye Base ---
module draw_eyes_black(hover = 0) {
    z_off = -0.05 + accent_pocket_extra_depth;
    for (m = [1, -1]) {
        place_outward(tilt=eye_tilt, pan=m * eye_pan, hover=hover)
            rotate([0, 0, m * eye_rotation])
                translate([0, 0, z_off]) {
                    // Rebuilt Additively to defeat OpenCSG Bug
                    // 1. Bottom Pad (Inside the ball)
                    translate([0, 0, red_ring_depth])
                        scale([1.5, 1, 1]) cylinder(r=eye_outer_radius - chip_clearance, h=pocket_depth - red_ring_depth);
                    
                    // 2. Outer Rim (Outer Surface)
                    difference() {
                        scale([1.5, 1, 1]) cylinder(r=eye_outer_radius - chip_clearance, h=red_ring_depth + eps);
                        translate([0, 0, -eps]) scale([1.5, 1, 1]) cylinder(r=eye_red_outer, h=red_ring_depth + 3*eps);
                    }
                    
                    // 3. Inner Pupil (Outer Surface)
                    scale([1.5, 1, 1]) cylinder(r=eye_red_inner, h=red_ring_depth + eps);
                }
    }
}

// --- Billy's Red Eye Ring ---
module draw_eyes_red(hover = 0) {
    // Lift the red ring outward slightly ONLY in the preview to defeat Z-fighting
    preview_lift = $preview ? 0.05 : 0;
    z_off = -0.05 + accent_pocket_extra_depth - preview_lift;
    for (m = [1, -1]) {
        place_outward(tilt=eye_tilt, pan=m * eye_pan, hover=hover)
            rotate([0, 0, m * eye_rotation])
                translate([0, 0, z_off]) {
                    difference() {
                        scale([1.5, 1, 1]) cylinder(r=eye_red_outer - chip_clearance, h=red_ring_depth + preview_lift);
                        translate([0, 0, -eps]) scale([1.5, 1, 1]) cylinder(r=eye_red_inner + chip_clearance, h=red_ring_depth + preview_lift + 2*eps);
                    }
                }
    }
}

// --- Billy's Spiral Cheeks ---
module draw_cheeks(is_pocket = true, hover = 0) {
    r_base = spiral_max_radius;
    z_off = is_pocket ? -eps : -0.05 + accent_pocket_extra_depth;
    h_val = is_pocket ? pocket_depth + accent_pocket_extra_depth + eps : pocket_depth;
    
    thickness = is_pocket ? spiral_thickness + (chip_clearance * 2) : spiral_thickness;

    for (m = [1, -1]) {
        place_outward(tilt=cheek_tilt, pan=m * cheek_pan, hover=hover)
            translate([0, 0, z_off])
                linear_extrude(height=h_val)
                    mirror([ m==-1 ? 1 : 0, 0, 0 ]) 
                        for(i=[0:150]) { 
                            let(
                                t1 = i/150, t2 = (i+1)/150,
                                a1 = t1 * spiral_turns * 360, a2 = t2 * spiral_turns * 360,
                                r1 = (t1 * r_base) + 0.5, r2 = (t2 * r_base) + 0.5
                            )
                            hull() {
                                translate([r1*cos(a1), r1*sin(a1)]) circle(r=thickness/2, $fn=16);
                                translate([r2*cos(a2), r2*sin(a2)]) circle(r=thickness/2, $fn=16);
                            }
                        }
    }
}

// --- Billy's Bowtie ---
module bowtie_base_shape() {
    module wing() {
        hull() {
            sphere(d=bowtie_knot_size);
            translate([bowtie_wing_length, 0, 0]) 
                scale([1, 2, 1]) sphere(d=bowtie_knot_size);
        }
    }
    wing();
    mirror([1,0,0]) wing();
}

module draw_bowtie_pocket() {
    // Cut the hole INSIDE the ball (+Z points toward center)
    place_outward(tilt=bowtie_tilt, pan=0, hover=0)
        translate([0, 0, -eps])
            cylinder(r=bowtie_peg_radius, h=bowtie_peg_depth + 1); // 1mm deeper so it doesn't bottom out
}

module draw_bowtie(hover = 0) {
    place_outward(tilt=bowtie_tilt, pan=0, hover=hover)
        union() {
            // The Peg (Points INWARD into the hole, +Z)
            translate([0, 0, -eps])
                cylinder(r=bowtie_peg_radius - chip_clearance, h=bowtie_peg_depth + eps);
            
            // The Flat-Backed Bowtie Body (Points OUTWARD away from shell, -Z)
            difference() {
                translate([0, 0, -(bowtie_knot_size/2 - 1.5)])
                    bowtie_base_shape();
                
                // Cut off the back spheres so they mate perfectly flat against the shell
                translate([0, 0, 50])
                    cube([100, 100, 100], center=true);
            }
        }
}

// === PRINTABLE CHIP LAYOUTS ===

module layout_chips_black() {
    // Rebuilt Additively: Prints FACE UP (Groove pointing UP, flat side on the build plate)
    for (m = [1, -1]) {
        translate([m * 18, 0, 0]) {
            // 1. Bottom Pad (On the build plate)
            scale([1.5, 1, 1]) cylinder(r=eye_outer_radius - chip_clearance, h=pocket_depth - red_ring_depth);
            
            // 2. Outer Rim (Stacked on top)
            translate([0, 0, pocket_depth - red_ring_depth - eps])
                difference() {
                    scale([1.5, 1, 1]) cylinder(r=eye_outer_radius - chip_clearance, h=red_ring_depth + eps);
                    translate([0, 0, -eps]) scale([1.5, 1, 1]) cylinder(r=eye_red_outer, h=red_ring_depth + 3*eps);
                }
                
            // 3. Inner Pupil (Stacked on top)
            translate([0, 0, pocket_depth - red_ring_depth - eps])
                scale([1.5, 1, 1]) cylinder(r=eye_red_inner, h=red_ring_depth + eps);
        }
    }
}

module layout_chips_red() {
    // Two Red Eye Rings
    for (m = [1, -1]) {
        translate([m * 18, 25, 0])
            difference() {
                scale([1.5, 1, 1]) cylinder(r=eye_red_outer - chip_clearance, h=red_ring_depth);
                translate([0, 0, -eps]) scale([1.5, 1, 1]) cylinder(r=eye_red_inner + chip_clearance, h=red_ring_depth + 2*eps);
            }
    }

    // Two Spirals
    for (m = [1, -1]) {
        translate([m * 18, -10, 0])
            mirror([ m==-1 ? 1 : 0, 0, 0 ])
                for(i=[0:150]) {
                    let(
                        t1 = i/150, t2 = (i+1)/150,
                        a1 = t1 * spiral_turns * 360, a2 = t2 * spiral_turns * 360,
                        r1 = (t1 * spiral_max_radius) + 0.5, r2 = (t2 * spiral_max_radius) + 0.5
                    )
                    hull() {
                        translate([r1*cos(a1), r1*sin(a1)]) circle(r=spiral_thickness/2, $fn=16);
                        translate([r2*cos(a2), r2*sin(a2)]) circle(r=spiral_thickness/2, $fn=16);
                    }
                }
    }

    // Bowtie Chip (Oriented face-up for slicer supports)
    translate([0, -45, 0]) {
        union() {
            // Peg touches the build plate and points UP (+Z)
            cylinder(r=bowtie_peg_radius - chip_clearance, h=bowtie_peg_depth + eps);
            
            // Flat back rests perfectly on top of the peg, body points UP (+Z)
            translate([0, 0, bowtie_peg_depth]) {
                difference() {
                    translate([0, 0, bowtie_knot_size/2 - 1.5])
                        bowtie_base_shape();
                    
                    // Cut everything below to keep the back perfectly flat
                    translate([0, 0, -50])
                        cube([100, 100, 100], center=true);
                }
            }
        }
    }
}