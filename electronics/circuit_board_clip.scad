/*
 * This circuit board clip takes a range of ~1mm to ~1.75mm thick circuit boards.
 * I use it to hold proto boards which may not have mounting holes or may not have
 * them in convenient place...  In general I print this with 40% infill, 5 perimeters,
 * 5 top solid layers and 5 bottom solid layers using an 0.2mm layer thickness with
 * an 0.4mm nozzle.  I generally use hatchbox PLA filament with a 1st layer temperature
 * of 200C and subsequent layers at 195C.
 *
 * It takes an M4 machine screw.  Four of these can securely mount a board to a base
 * plate or the inside of a project box.  Depending on what filament you use, you may
 * want to scale this either here or in your slicer to compensate for thermal shrinkage.
 */

$fs=0.4;

rotate([90,90,0]) difference() {
    union() {
        hull() {
            translate([-7.5,-7.5, -2.5]) cylinder(r=5, h=5);
            translate([0,0, -2.5]) cylinder(r=5, h=5);
            translate([0,0,-2.5]) linear_extrude(height=7.5) offset(r=1.25) square([12.5, 12.5], center=true);
            translate([-7.5, -7.5]) cylinder(r=5, h=5);
        }
    }
    union() {
        translate([5,5,0]) union() {
            for(i=[0,180])rotate([i,0,0])translate([0,0,0.25]) {
                linear_extrude(height=0.5, scale=0.8) offset(r=1.25) square([17.5,17.5],center=true);
            }
            translate([0,0,-0.26])linear_extrude(height=0.52) offset(r=1.25) square([17.5,17.5],center=true);
        }
        translate([-7.5, -7.5]) cylinder(r=2.1, h=20, center=true);
        translate([-7.5, -7.5, -2.5]) cylinder(r=4, h=1, center=true);
    }
}

