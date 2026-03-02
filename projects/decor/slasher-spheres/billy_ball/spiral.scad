// Parameters
loops = 5;          // Number of full rotations
thickness = 2;      // Thickness of the spiral "line"
spacing = 5;        // Distance between each turn
step_size = 10;     // Degrees per segment (lower is smoother)

// Generate the flat spiral polygon
linear_extrude(height = 1) // Give it a tiny bit of height for visibility
polygon(points = concat(
    // Outer edge points
    [for (a = [0 : step_size : 360 * loops]) 
        let (r = (a / 360) * spacing + thickness) 
        [r * cos(a), r * sin(a)]],
    // Inner edge points (backwards to close the polygon)
    [for (a = [360 * loops : -step_size : 0]) 
        let (r = (a / 360) * spacing) 
        [r * cos(a), r * sin(a)]]
));
