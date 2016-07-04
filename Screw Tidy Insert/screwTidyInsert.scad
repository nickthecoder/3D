/*
    Creates tapered boxes suitable as inserts into component boxes.
    Having inserts make it easy to take out one type of screw from the container
    while working on a job.
    It is also handy to colour code the compartments. For example, having all the M6
    nuts, bolts and washers using one colour, with M4, and M8 using difference colours.
*/

module taperedSquare( w, h, taper )
{
    polygon( [ [-w/2+taper,0], [-w/2,h], [w/2,h], [w/2-taper,0] ] );
}   

module taperedCube( l, w, d,  taper )
{
    translate( [0,w/2,0] ) rotate([90,0,0]) 
    linear_extrude( w ) {
        taperedSquare( l, d, taper );
    }
}

module doubleTaperedCube( l, w, d, taper )
{
    intersection() {
        taperedCube( l,w,d, taper );
        rotate( [0,0,90] ) taperedCube( w, l, d, taper );
    }

}

module insert( l, w, d, taper = 2, thickness=1.2 )
{
    difference() {
        doubleTaperedCube( l,w,d, taper );
        translate( [0,0,thickness] ) doubleTaperedCube( l-thickness*2, w-thickness*2, d, taper );
    }
}

// insert( 44,38, 25, 1 );
