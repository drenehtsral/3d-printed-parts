$fs=0.4;

/*
 * This module makes it easy to mount these affordable and sturdy limit switches:
 *
 * Crouzet 831810C2.EL
 * https://www.digikey.com/product-detail/en/crouzet/831810C2.EL/966-1338-ND
 * 
 * At the right height and spacing for use with carriages/gantries conveyed on
 * SBR-30 linear rails and RM-2505 ball screws which are Available from many
 * suppliers, e.g:
 * https://www.amazon.com/dp/B07HM4JRZB
 *
 * These are then mounted on 40-series aluminum extrusion from 8020 Inc.
 * aluminum extrusion in 40-4080, 40-4012, 40-8080, or 40-8016.  I'm partial
 * to the 40-8080 extrusion as a good compromise point between ease of use
 * and sturdiness:
 *
 * https://8020.net/40-8080.html
 *
 * Obviously you could modify this basic design if you use linear rails of a
 * different size, or aluminum extrusion of a different size, or even different
 * limit switches.
 *
 * I generally print these with 40% infill, 5 perimeters, 5 solid top layers,
 * and 5 solid bottom layers using a layer height of 0.2mm with an 0.4mm
 * nozzle with Hatchbox PLA filament.  Generally I use a 200C first layer
 * temperature and 195C subsequent layer temperature.
 *
 * For PLA I found I had to scale this design by 2.5% to account for
 * shrinkage (to keep the center-to-center spacing of the two M6 holes
 * to a true 40mm so it fits well with the extrusion it gets mounted to).
 */
module limit_switch_mount_40_8080(plate_min=9, H=25, horiz=0)
{
    if (horiz) {
        x_offset=20;
        y_offset=2.5;

        difference() {
            translate([0,y_offset])union() {
                linear_extrude(height=plate_min*2) offset(r=5) difference() {
                    square([50,20],center=true);
                    translate([0,-10])offset(r=7.5)square([10,10],center=true);
                }
                translate([x_offset,10,0])linear_extrude(height=H) offset(r=1) square([18,8],center=true);
            }
            union() {
                for (x=[-20,20]) translate([x,0,0]) {
                    translate([0,0,-1])cylinder(r=3.2, h=H+2);
                    translate([0,0,plate_min])cylinder(r=6,h=H);
                }
                for (x=[-5,5]) translate([x + x_offset,9 + y_offset,-1]) cylinder(r=1.27, h=H+2);
            }
        }
    } else {
        x_offset=35;
        y_offset=-5;
        difference() {
            union() {
                translate([2.5,0])linear_extrude(height=plate_min * 2) offset(r=5) square([65,10], center=true);
                translate([x_offset,y_offset])linear_extrude(height=H) offset(r=1) square([8,18], center=true);
            }
            union() {
                for(x=[-20,20]) translate([x,0,0]) {
                    translate([0,0,-1])cylinder(r=3.225, h=H+2);
                    translate([0,0,plate_min])cylinder(r=6,h=H);
                }
                for(y=[-5,5]) translate([x_offset, y + y_offset, -1]) cylinder(r=1.25, h=H+2);
            }
        }
    }
}

limit_switch_mount_40_8080();
