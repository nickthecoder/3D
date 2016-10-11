/*
    Print Notes
        The supports are wobbly, with a small area touching the build plate, so print with a large brim.
*/

include <vases-pedestal.scad>;

difference() {
    clip() curve();
    screwHoles();
    translate([0,0,HEIGHT]) rotate([180,0,0]) screwHoles();
}

