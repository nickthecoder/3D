use <ntc/tools.scad>;
use <ntc/countersink.scad>;
use <ntc/chamfer.scad>;

$fs=1;

module clip( hole=4.8, thickness=2, extra=5, depth=10, angle=240, screw=[4,80] )
{
    width = (hole + thickness) * 2;
    
    difference() {

       linear_extrude( depth, convexity=4 ) {

            rotate( (360 - angle) / 2 - 90 ) rounded_arc( width / 2, hole, angle );

            difference() {
                translate( [-width/2, 0] ) square( [width, width / 2 + extra] );
                circle( hole );
            }
        }


        translate( [0,0, depth / 2 ] ) rotate( [-90,0,0] ) {
            ntc_countersink_hole( screw=screw, recess=hole + 1 );
        }
        translate( [-width/2, -hole,0 ] ) {
            chamfer_cube( [width, width + extra, depth], all=false, top=true, bottom=true );
        }
        
        intersection() {
            union() {
                chamfer_cylinder( hole + thickness  );
                translate( [0,0,depth] ) mirror( [0,0,1] ) chamfer_cylinder( hole + thickness );
            }

            linear_extrude( height=depth * 3, center=true) {
                intersect_segment( hole + thickness, angle=180, rotate=180 );      
            }
        }

    }
}

clip();

