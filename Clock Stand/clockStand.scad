/*
I like making clocks faces from computer "junk", and then buying a clock mechanism. (You need one with a long axis)
Open up a broken laptop hard drive. The shiney platter makes for an interesting clock face.
This stand screws to the back of the hard drive.

The hard part is drilling the hole through the middle of the drive.
*/

length = 68;
base_length = 50;
thickness = 2;
curve = 10;

module stand()
{
    translate( [0,-8,10] )
    rotate( [0,90,0] ) {
        linear_extrude( base_length, convexity=10 ) {
            intersection() {
                difference() {
                    circle( curve );
                    circle( curve - thickness );
                }
                square( [10,10] );
            }
        }
    }

    translate([0,-17,0]) cube( [ base_length, 20, thickness ] );

    difference() {
        translate([0,4,1]) rotate( [100,0,0] ) translate([ -(length-base_length)/2, 0, 0 ] ) cube( [ length, 30, thickness ] );
        rotate( [90,0,0] ) translate([base_length/2,35,-4]) cylinder( d=base_length, h=thickness*4 );
    }    
}

rotate( [-100,0,0] ) stand();

