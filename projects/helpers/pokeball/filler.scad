/* SHARED POKÉBALL FILLER SYSTEM */

// Rectangular Filler Dimensions
filler_width = 24;
filler_length = 14;
filler_height = 18;

// Clearances
filler_xy_clearance = 0.1;
filler_z_clearance = 0.5;

// The printable peg part
module alignment_filler() {
    cube([filler_width, filler_length, filler_height], center=true);
}

// The negative space to cut out of the shells
module filler_cutout() {
    cube([
        filler_width + filler_xy_clearance, 
        filler_length + filler_xy_clearance, 
        filler_height + filler_z_clearance
    ], center=true);
}