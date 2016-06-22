include <ink2scad_tools.scad>;
include <curtainHook_generated.scad>;

height = 4;
INK2SCAD_ROUGH=false; // Set to false for final rendering, which IS very SLOW!

module hook()
{
    difference() {
        linear_extrude( height, convexity=6 ) ink2scad( hook );
        extrude_along_edges( hook ) chamfer();
        translate( [0,0,4] ) extrude_along_edges( hook ) chamfer();
    }
}

hook();


