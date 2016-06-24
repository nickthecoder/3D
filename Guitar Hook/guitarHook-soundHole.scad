include <generated_guitarHook.scad>;

// Make the sound hole inset a little smaller than the sound hole, so that it fits in easily.
// This object will hide the screw.
// Colour : Black
linear_extrude( 0.4 ) {
    // Commented out, while using an old version of openSCAD, which doesn't support offset
    //offset( -0.5 )
    ink2scad( soundHole );
}

