use <ntc/tools.scad>;
use <ntc/countersink.scad>;
use <ntc/chamfer.scad>;

$fs=1;

module clip( hole=4.8, thickness=2, extra=5, depth=10, angle=240, screw=[4,80] )
{
    width = (hole + thickness) * 2;
    
    difference() {

        // The main shape without the screw hole, or chamfers
        linear_extrude( depth, convexity=4 ) {

            ntc_rounded_arc( width / 2, hole, angle, rotate=(360 - angle) / 2 - 90 );

            difference() {
                translate( [-width/2, 0] ) square( [width, width / 2 + extra] );
                circle( hole );
            }
        }


        // Screw hole
        translate( [0,0, depth / 2 ] ) rotate( [-90,0,0] ) {
            ntc_countersink_hole( screw=screw, recess=hole + 1 );
        }
        
        // Chamfer the straight part
        translate( [-width/2, -hole,0 ] ) {
            chamfer_cube( [width, width + extra, depth], all=false, top=true, bottom=true );
        }

        // Chamfer the rounded parts
        intersection() {
            union() {
                chamfer_cylinder( hole + thickness  );
                translate( [0,0,depth] ) mirror( [0,0,1] ) chamfer_cylinder( hole + thickness );
            }

            translate( [-width/2-1, -width-1, -1] ) cube( [width + 2, width + 1, depth +2] );
        }

    }
}

clip();

