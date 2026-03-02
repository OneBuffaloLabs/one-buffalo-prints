// Use this code in the OpenSCAD editor window
knot_size = 10;
wing_length = 30;

module wing() {
    hull() {
        sphere(d=knot_size);
        translate([wing_length, 0, 0]) 
            scale([1, 2, 1]) sphere(d=knot_size);
    }
}

wing();
mirror([1,0,0]) wing();
