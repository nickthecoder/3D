/*
A curtain glider (aka Swish Nova Delux Curtain Glider / Runner) for hanging curtains on a rail.

Note, the shapes were designed in Inkscape, and coverted to scad using the ink2scad tool.

PRINT NOTES:
    Support Type : Touching Build Plate
*/

include <generated_curtainGlider.scad>

thickness = 2.5;
peg_r = 1.9;

module glider()
{
    // Peg
    translate([0,0,-2])
    translate( head[2]/2 ) cylinder( r=peg_r, h=6 );
    
    // Head
    translate( [0,0,2.5] ) linear_extrude( height=thickness ) ink2scad( head );
    
    // Tail
    translate([0,0,-1.3])
    linear_extrude( height=thickness ) ink2scad( tail, relativeTo=head );

    // Neck
    translate([0,0,-1.5])
    intersection() {
        linear_extrude( height=thickness*3 ) ink2scad( neck, relativeTo=head );
    
        mirror([0,0,1]) rotate( [-90,0,0] ) linear_extrude( height=10 ) ink2scad( profile );
    }
    
    // Tab
    translate( [0,0,-4] ) linear_extrude( height=2 ) ink2scad( tab, relativeTo=head );
    
}


rotate( [90,0,0] ) glider();

// Uncomment to print a 3x4 array (i.e. a batch of 12 gliders)
//
// include <ntc/ntc_tools.scad>
// ntc_arrange_grid( 3,33, 4,12 ) rotate([90,0,0]) glider();

