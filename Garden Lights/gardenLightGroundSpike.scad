/*
    A ground spike for garden lights with a gap for electric cable to pass up the shaft.

    I bought some lovely solar powered garden light
    (Just for £2 - a bargain for a stainless steel and glass construction!)
    buy I also wanted wire them to a 12V supply, so they could illuminate the whole garden.
    The 12V cable is quite thick, and the existing ground spikes couldn't accomodate the cable.

Print Notes
===========

I printed these with PLA, but ABS would be a much better choice, as PLA may deteriorate in the ground.

*/
module groundSpike( d=21, l= 100, peg=22, thickness=2 )
{

    module half()
    {
        translate( [-d/2,-thickness/2,0] ) cube( [ d, thickness, l-d*2 ] );
        translate( [0,-thickness/2,l-d*2] ) scale( [1,1,2] ) rotate( [-90, 0,0] ) cylinder( $fn=4, d=d, h=thickness );
    }

    module ridge() {
        translate( [d/2,0,-peg] ) cylinder( d=1, h=peg );
    }
    
    translate( [0,0,-peg] ) linear_extrude( peg, convexity=10 ) {
        difference() {
            circle( d=d );
            circle( d=d-thickness );
        }
        rotate(45) difference() {
            circle( $fn=3, d=d, l=peg );
            circle( $fn=3, d=d-thickness*2, l=peg );
        }
    }   

    translate([0,0,-peg]) cylinder( d=d, h=1 );

    half();
    rotate( [0,0,90] ) half();
    
    rotate_extrude() translate( [d/2,0,0] ) circle( d=2, $fn=8 );
    translate( [0,0,-1] ) cylinder( d=d, h=1 );
    
    for (i = [0:3]) {
        rotate([0,0,i*90]) ridge();
    }
}

module wiredGroundSpike(  d=21, l= 100, peg=22, thickness=2, gap=8 )
{
    difference() {
        union() {
            groundSpike( d=d, l=l, peg=peg, thickness=thickness);
        
            intersection() {
                rotate(45) translate( [d/2-gap-thickness,-gap/2-thickness/2,-peg] ) cube( [d,gap+thickness,peg] );
                translate( [0,0,-peg] ) cylinder( d=d,h=peg );
            }
        }
        
        rotate([0,0,45]) translate( [-1,-gap/2,-peg-1] ) cube( [d, gap, peg+gap] );
    }
}

wiredGroundSpike();
