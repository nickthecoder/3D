use <wifiSpeakerStand.scad>;
use <ntc/tools.scad>;

module washer( d1=7, d2=4, h=2 )
{
    linear_extrude( h, convexity=4 ) {
        difference() {
            circle( d=d1 );
            circle( d=d2 );
        }
    }
}


module cableTie( d, elongate=0, width=7, heft=2, forScrew=8, screw=2 )
{
    gap=d/3;
    
    difference() {
        linear_extrude( width, convexity=4 ) {
            difference() {
                translate( [-d/2 - heft, -d/2 -heft] ) square( [d + elongate + heft + forScrew, d+heft*2] );
                hull() {
                    circle( d=d );
                    translate( [elongate,0] ) circle( d=d );
                }
                // Gap to squeeze
                square( [100,gap] );
            }
        }
        
        // Screw hole
        translate( [d/2+elongate+forScrew/2, 0, width/2] ) rotate([90,0,0]) cylinder( d=screw, h=100, center=true );
        translate( [d/2+elongate+forScrew/2, 0, width/2] ) rotate([-90,0,0]) cylinder( d=screw+2, h=100 );
    }    
}



// My charger sled back plate snapped, due to too much brute force!
// So print another one, and glue it in place. (Snap off the unneeded front bits).
translate( [-25,0,0] ) chargerSled(h=13);


ntc_arrange_grid( 3, 10, 2, 10 ) washer( h=2 );
translate( [0,20,0] ) ntc_arrange_grid( 3, 10, 2, 10 ) washer( h=3 );

translate( [33,0,0] ) cableTie( 7 );
translate( [33,20,0] ) cableTie( 5,3 );

