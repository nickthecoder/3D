size=12;
pegLength=4;
pegD=6;
pegD2=4;

slack = 0.5;
gap = 0.5;
pegFN=16;

module peg()
{
    // Rod
    translate( [ size/2, 0, 0 ] ) rotate( [0,90,0] ) cylinder( d=pegD2, h=pegLength + gap, $fn=pegFN );
    // Holding peg
    translate( [ size/2 + pegLength/2 + gap, 0, 0 ] ) rotate( [0,90,0] ) cylinder( d=pegD, h=pegLength/2, $fn=pegFN );
}

module hole()
{
    // Hole for Rod
    translate( [ -size/2-1,0,0 ] ) rotate( [0,90,0] ) cylinder( d=pegD2 + slack*2, h=pegLength+slack+1, $fn=pegFN );
    // Hole for holding peg.
    translate( [ -size/2 + pegLength/2 - slack, 0, 0] ) rotate( [0,90,0] ) cylinder( d=pegD + slack*2, h=pegLength/2 + slack*2, $fn=pegFN );
}

module solid()
{
    cube( [size,size,size], center=true );
}

module straight()
{
    difference() {
        solid();
        hole();
    }
    peg();
}


module corner()
{
    difference() {
        solid();
        hole();
    }
    rotate( [0,0,90] ) peg();
}

module femaleEnd()
{
    difference() {
        solid();
        hole();
    }    
}

module maleEnd()
{
    solid();
    peg();
}

/*
    Positions a piece.
*/
module position( x, y, angle=0 )
{
    translate( [x * (size + gap), y * (size +gap),0 ] )
    rotate( [0,0,angle] )
    children();
}

module flip()
{
    mirror( [1,0,0] ) children();
}

/*
    Slices through the pieces, so that the pegs and holes can be seen.
    Not used in the final render, only used for testing.
*/
module inspect()
{
    intersection() {
        children();
        union() {
            for ( y = [-10:10] ) {
                position( 0, y ) translate( [-100,-0.5,-100] ) cube( [200,1,200] );
            }
            for ( x = [-10:10] ) {
                position( x, 0 ) rotate( [0,0,90] ) translate( [-100,-0.5,-100] ) cube( [200,1,200] );
            }
        }
    }
}

module puzzle1()
{
    position( 0,0 ) maleEnd();
    position( 1,0 ) corner();
    position( 1,1,90 ) corner();
    
    position( 0,1,180 ) straight();
    position( -1,1,180 ) corner();
    position( -1,0,90 ) flip() corner();

    position( -2,0,180 ) corner();
    position( -2,-1,-90 ) straight();
    position( -2,-2,-90 ) corner();
    position( -1,-2 ) straight();
    
    position( 0,-2, 180 ) flip() corner();
    position( 0,-3, -90 ) straight();
    position( 0,-4, -90) corner();
    position( 1,-4 ) corner();
    position( 1,-3,-90 ) flip() corner();

    position( 2,-3 ) corner();
    position( 2,-2, -90) flip() corner();
    position( 3,-2 ) corner();
    position( 3, -1, 90) straight();

    position( 3, 0, -90) flip() corner();
    position( 4, 0 ) corner();
    position( 4, 1, 90 ) straight();
    position( 4, 2, 90 ) corner();

    position( 3, 2 ) flip() corner();
    position( 3, 3,90 ) straight();
    position( 3, 4,90 ) corner();
    position( 2, 4, 180 ) femaleEnd();

}

module test()
{
    position( -2,0 ) maleEnd();
    position( -1,0 ) straight();
    position( 0,0 ) straight();
    position( 1,0 ) corner();
    position( 1,1,90 ) femaleEnd();
}

//inspect()
puzzle1();
