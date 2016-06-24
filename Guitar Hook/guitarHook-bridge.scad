include <generated_guitarHook.scad>;

linear_extrude( 0.8 ) ink2scad( bridge );
linear_extrude( 2 ) ink2scad( bridge2, relativeTo=bridge );

