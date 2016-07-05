/*
    Attach strips of LED COB lights to a wall.

    Here's the ones that I bought :
    http://www.banggood.com/6W-76led-COB-LED-Chip-520mA-WhiteWarm-White-For-DIY-DC-12V-p-960210.html
*/

use <ntc/tools.scad>;

module clip(w, heft, size, thickness, hole)
{
    total = w + heft *2;
    gap = 1;
    height = size + hole + heft;
    
    difference() {
        // Main block
        translate( [-total/2, 0,0 ] ) cube( [total, thickness + heft + gap, height] );

        // Cut out where the LED strip fits in
        translate( [-w/2,-1,hole+heft] ) cube( [w, 10, height] );
        
        ntc_arrange_mirror() {
            // Gaps for the wires
            translate( [w/2-2,0,0] ) cylinder( d=5, h=50, center=true, $fn=8 );
        }
        // Screw holes
        translate( [0,0,(hole+heft)/2] ) rotate( [90,0,0]) cylinder( d=hole, h=50, center=true );
    }

    // Cover the contacts
    ntc_arrange_mirror() {
        translate( [-w/2,thickness+gap,0] ) cube( [w/4,heft,height] );
    }

}

module singleClip(w, heft, size, thickness, hole)
{
    translate([0,-(hole+heft)*0.5,thickness+heft+1]) rotate( [-90,0,0] )
    clip(w,heft,size, thickness, hole);
}

// Uncomment for a batch
//ntc_arrange_grid( 2, 24, 2, 18 )

singleClip(15, 2.5, 6, 2, 4.5 );

