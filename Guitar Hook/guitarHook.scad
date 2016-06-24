include <ntc/countersink.scad>
include <generated_guitarHook.scad>;

thickness = 16;    
hole_height = 12;
rod_diameter = 7;

screw = [ 6,60 ];

module hook()
{
    module rod()
    {
        translate( [30,20, 1 - thickness] )
        rotate( [-2,2,0] ) // Angle up and outwards very slightly
        union() {
            cylinder( r=rod_diameter/2, h=50 );

            // Add "flaws" around the rod holes, so that the slicer will add extra plastic around the
            // rod holes. This allows for a low infill, but still strong.
            for ( i = [0:5] ) {
                rotate( [0,0,i * 360/5] )
                translate( [0,5,0] )
                cylinder( r = 0.2, h= thickness -3 );
            }
        }
    }

    difference() {
        translate( [0,0,-thickness] ) linear_extrude( height=thickness ) ink2scad( body );

        union() {
            translate( [0,0, -hole_height] ) linear_extrude( height=thickness, convexity=10 ) ink2scad( soundHole, relativeTo=body );

            // Screw hole, hidden by sound hole.
            translate( [40,70, 1.1-hole_height] )
              mirror( [0,0,1] )
              countersink_hole( screw = screw, recess = 1 );

          
            // 2nd screw hole hidden under the pick guard
            //translate( [53,53, 1] )
            //  mirror( [0,0,1] )
            //  countersink_hole( screw = screw, recess = 6 );

            // Holes for rods (which will hold the real guitar)
            translate( [38.5,0,0] ) {
                rod();
                mirror( [1,0,0] ) rod();
            }
        }
    }

}

hook();

