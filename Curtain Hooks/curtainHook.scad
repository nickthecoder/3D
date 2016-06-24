/*
    A curtain hook for hanging curtains. See also curtainGlider.scad for hanging curtains on a rail.
    
    Note, the shape was designed in Inkscape, and coverted to scad using the ink2scad tool.
*/

include <ink2scad_tools.scad>;
include <generated_curtainHook.scad>; // Generated from Inkscape pattern.

height = 4;
INK2SCAD_ROUGH=true; // Set to false for final rendering, which IS very SLOW!

module hook()
{
    difference() {
        linear_extrude( height, convexity=6 ) ink2scad( hook );
        extrude_along_edges( hook ) chamfer();
        translate( [0,0,4] ) extrude_along_edges( hook ) chamfer();
    }
}

hook();

// Uncomment to arrange 12 hooks in one go
//
// include <ntc/ntc_tools.scad>;
// ntc_arrange_grid( 4,16, 3,34 ) hook();

