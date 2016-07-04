/*
    Attach strips of LED COB lights to a wall.

    Here's the ones that I bought :
    http://www.banggood.com/6W-76led-COB-LED-Chip-520mA-WhiteWarm-White-For-DIY-DC-12V-p-960210.html
*/

use <ntc/tools.scad>;

module holelessClip(w, heft, size, thickness, hole)
{
    extra = hole*2;
    total = w + extra *2;
    gap = 1;
    
    difference() {
        // Main block
        translate( [-total/2, 0,0 ] ) cube( [total, thickness + heft + gap, size] );

        // Cut out where the LED strip fits in
        translate( [-w/2,-1,1.5] ) cube( [w, 10, size] );
        
        ntc_arrange_mirror() {
            // Gaps for the wires
            translate( [w/2-2,0,0] ) cylinder( d=5, h=50, center=true, $fn=8 );
        }
    }

    // Cover the contacts
    ntc_arrange_mirror() {
        translate( [-w/2,thickness+gap,0] ) cube( [w/4,heft,size] );
    }

    // Springy piece to hold the LED strip
    //rotate( [18,0] ) translate( [-w/8,thickness+gap+1,0] ) cube( [w/4,2,size] );
}

module singleClip(w, heft, size, thickness, hole)
{
    extra = hole*2;

    difference() {
        holelessClip(w,heft,size, thickness, hole);

        ntc_arrange_mirror() {
            // Screw holes
            translate( [w/2+extra/2,0,size/2] ) rotate( [90,0,0]) cylinder( d=hole, h=50, center=true );
        }
    }
}

ntc_arrange_grid( 1, 0, 2, 10 )
singleClip(15, 2.5, 6, 2, 4.5 );

