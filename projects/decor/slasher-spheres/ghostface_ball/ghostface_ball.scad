/* GHOSTFACE (SCREAM) POKÉBALL */

include <../../../helpers/pokeball/filler.scad>;
include <../../../helpers/pokeball/core.scad>;

// --- PARAMETRIC VARIABLES ---
part_to_render = "all"; // [all, top, bottom, ring, front_ring, button, filler, chips_black, chips_white, debug_2d_right_eye, debug_2d_left_eye, debug_2d_nose]
exploded_view = false;
debug_transparent_chips = false;

// --- CLEARANCES (Fine-tune for press-fit) ---
right_eye_clearance = 0.05; 
left_eye_clearance = 0.00;  
nose_clearance = 0.05;
mouth_clearance = 0.05;

// --- EYE TWEAKS & PLACEMENT ---
right_eye_svg_x = -7;   
right_eye_svg_y = 10;   
left_eye_svg_x = -7;    
left_eye_svg_y = 10;    

eye_scale = 0.20;       

eye_tilt = 45;          
eye_pan = 30;           
right_eye_rotation = 20; 
left_eye_rotation = -20;  

eye_pocket_depth = 3.5;   
eye_chip_thickness = 2.5; 

// --- NOSE TWEAKS & PLACEMENT ---
nose_svg_x = -4.5;      
nose_svg_y = 4.5;       
nose_scale = 0.20;      
nose_tilt = 25;         
nose_pan = 0;           
nose_rotation = 0;      

nose_pocket_depth = 2.5;   
nose_chip_thickness = 2.5; 

// --- MOUTH TWEAKS & PLACEMENT ---
mouth_width = 22.5;      
mouth_height = 30;       
mouth_rounding = 3;      
mouth_tilt = -38;        
mouth_pan = 0;           

mouth_curve_radius = 18; // Size of the cutout curve at the top of the mouth
mouth_curve_bite = 4;    // How deep the curve bites into the flat top

mouth_pocket_depth = 3.5;   
mouth_chip_thickness = 2.5; 

// --- Colors ---
top_color = "white";
bottom_color = "black";
ring_color = "black";
front_ring_color = "black";
button_color = "red";
filler_color = "black";
mouth_color = "white";

// --- RENDER LOGIC ---

c_black = debug_transparent_chips ? [0, 0, 0, 0.5] : "black";
c_white = debug_transparent_chips ? [1, 1, 1, 0.5] : mouth_color;

if (part_to_render == "debug_2d_right_eye") {
  color("red") cube([100, 0.5, 0.1], center=true); 
  color("green") cube([0.5, 100, 0.1], center=true); 
  color("black") linear_extrude(1) get_right_eye_2d();
} else if (part_to_render == "debug_2d_left_eye") {
  color("red") cube([100, 0.5, 0.1], center=true); 
  color("green") cube([0.5, 100, 0.1], center=true); 
  color("black") linear_extrude(1) get_left_eye_2d();
} else if (part_to_render == "debug_2d_nose") {
  color("red") cube([100, 0.5, 0.1], center=true); 
  color("green") cube([0.5, 100, 0.1], center=true); 
  color("black") linear_extrude(1) get_nose_2d();
} else if (part_to_render == "chips_black") { 
  color("black") layout_chips_black(); 
} else if (part_to_render == "chips_white") { 
  color(mouth_color) layout_chips_white(); 
} else if (part_to_render == "all") {
  if (exploded_view == true) {
    // --- EXPANDED VIEW (TIGHTENED) ---
    translate([0, 0, 25]) color(top_color) top_mask();
    translate([0, 0, -25]) color(bottom_color) bottom_shell();
    color(ring_color) center_ring();
    translate([0, -15, 0]) color(front_ring_color) front_ring();
    translate([0, -25, 0]) color(button_color) center_button();
    translate([0, 0, 12]) color(filler_color) alignment_filler();

    translate([0, 0, 25]) {
      color(c_black) draw_eyes(is_pocket=false, hover=10);
      color(c_black) draw_nose(is_pocket=false, hover=10);
    }
    translate([0, 0, -25]) {
      color(c_white) draw_mouth(is_pocket=false, hover=10);
    }
  } else {
    // --- NORMAL ASSEMBLED VIEW ---
    translate([0, 0, 0.02]) color(top_color) top_mask();
    translate([0, 0, -0.02]) color(bottom_color) bottom_shell();
    color(ring_color) center_ring();
    color(front_ring_color) front_ring();
    color(button_color) center_button();
    color(filler_color) alignment_filler();

    translate([0, 0, 0.02]) {
      color(c_black) draw_eyes(is_pocket=false, hover=0);
      color(c_black) draw_nose(is_pocket=false, hover=0);
    }
    translate([0, 0, -0.02]) {
      color(c_white) draw_mouth(is_pocket=false, hover=0);
    }
  }
} else {
  // --- EXPORT MODE ---
  if (part_to_render == "top") color(top_color) top_mask();
  if (part_to_render == "bottom") color(bottom_color) bottom_shell();
  if (part_to_render == "ring") color(ring_color) center_ring();
  if (part_to_render == "front_ring") color(front_ring_color) front_ring();
  if (part_to_render == "button") color(button_color) center_button();
  if (part_to_render == "filler") color(filler_color) alignment_filler();
}

// --- MAIN MODULES ---

module top_mask() {
  difference() {
    sphere(r=ball_radius);

    // Massive block to strictly cut everything below Z=3, killing ghost lines
    translate([0, 0, -47])
      cube([150, 150, 100], center=true);

    filler_cutout();

    translate([0, -ball_radius + front_pocket_depth, 0])
      rotate([90, 0, 0])
        cylinder(r=front_ring_outer_r + mechanical_clearance, h=front_pocket_depth + eps * 2, center=false);

    // CUT THE POCKETS!
    draw_eyes(is_pocket=true);
    draw_nose(is_pocket=true);
  }
}

module bottom_shell() {
  difference() {
    sphere(r=ball_radius);

    translate([0, 0, 47])
      cube([150, 150, 100], center=true);

    translate([0, 0, -87])
      cube([150, 150, 100], center=true);

    filler_cutout();

    translate([0, -ball_radius + front_pocket_depth, 0])
      rotate([90, 0, 0])
        cylinder(r=front_ring_outer_r + mechanical_clearance, h=front_pocket_depth + eps * 2, center=false);

    // CUT THE MOUTH POCKET!
    draw_mouth(is_pocket=true);
  }
}

// --- FEATURE PLACEMENT ENGINE ---

module get_right_eye_2d(clearance = 0) {
  offset(delta = clearance)
    translate([right_eye_svg_x, right_eye_svg_y])
      scale([eye_scale, eye_scale]) 
        mirror([0, 1])
          import("images/right_eye.svg");
}

module get_left_eye_2d(clearance = 0) {
  offset(delta = clearance)
    translate([left_eye_svg_x, left_eye_svg_y])
      scale([eye_scale, eye_scale]) 
        mirror([0, 1])
          import("images/left_eye.svg");
}

module get_nose_2d(clearance = 0) {
  offset(delta = clearance)
    translate([nose_svg_x, nose_svg_y])
      scale([nose_scale, nose_scale]) 
        mirror([0, 1])
          import("images/nose.svg");
}

module draw_eyes(is_pocket = true, hover = 0) {
  r_clearance = is_pocket ? 0 : -right_eye_clearance;
  l_clearance = is_pocket ? 0 : -left_eye_clearance;
  
  recess_depth = eye_pocket_depth - eye_chip_thickness;
  z_off = is_pocket ? -eps : recess_depth;
  h_val = is_pocket ? eye_pocket_depth + eps : eye_chip_thickness;

  place_outward(eye_tilt, eye_pan, hover)
    rotate([0, 0, right_eye_rotation])
      translate([0, 0, z_off])
        linear_extrude(height=h_val)
          get_right_eye_2d(r_clearance);

  place_outward(eye_tilt, -eye_pan, hover)
    rotate([0, 0, left_eye_rotation])
      translate([0, 0, z_off])
        linear_extrude(height=h_val)
          get_left_eye_2d(l_clearance);
}

module draw_nose(is_pocket = true, hover = 0) {
  clearance = is_pocket ? 0 : -nose_clearance;
  recess_depth = nose_pocket_depth - nose_chip_thickness;
  z_off = is_pocket ? -eps : recess_depth;
  h_val = is_pocket ? nose_pocket_depth + eps : nose_chip_thickness;

  place_outward(nose_tilt, nose_pan, hover)
    rotate([0, 0, nose_rotation])
      translate([0, -5, z_off])
        linear_extrude(height=h_val)
          get_nose_2d(clearance);
}

module draw_mouth(is_pocket = true, hover = 0) {
  clearance = is_pocket ? 0 : -mouth_clearance;
  recess_depth = mouth_pocket_depth - mouth_chip_thickness;
  z_off = is_pocket ? -eps : recess_depth;
  h_val = is_pocket ? mouth_pocket_depth + eps : mouth_chip_thickness;

  place_outward(mouth_tilt, mouth_pan, hover)
    translate([0, 0, z_off])
      difference() {
        // Base Parametric Triangle
        linear_extrude(height=h_val)
          offset(delta = clearance)
            offset(r = mouth_rounding) 
              offset(delta = -mouth_rounding) 
                polygon([ [-mouth_width/2, -mouth_height/2], [mouth_width/2, -mouth_height/2], [0, mouth_height/2] ]);

        // Local Top Curve Cut (Replaces the global front-ring cut)
        // Positioned relative to the top edge (Y = -mouth_height/2)
        translate([0, -mouth_height/2 - mouth_curve_radius + mouth_curve_bite, h_val / 2])
          cylinder(r=mouth_curve_radius, h=h_val * 3, center=true, $fn=64);
      }
}

// --- PRINTABLE CHIP LAYOUTS ---

module layout_chips_black() {
  translate([15, 0, 0])
    linear_extrude(height=eye_chip_thickness)
      get_right_eye_2d(-right_eye_clearance);

  translate([-15, 0, 0])
    linear_extrude(height=eye_chip_thickness)
      get_left_eye_2d(-left_eye_clearance);

  translate([0, 20, 0])
    linear_extrude(height=nose_chip_thickness)
      get_nose_2d(-nose_clearance);
}

module layout_chips_white() {
  rotate([90, 0, 0])
    translate([0, ball_radius, 0])
      rotate([mouth_tilt, 0, 0])
        rotate([0, 0, -mouth_pan])
          draw_mouth(is_pocket=false, hover=0);
}