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
    translate( [ 0, size/2, size/2 ] ) rotate( [0,90,0] ) cylinder( d=pegD2, h=pegLength + gap, $fn=pegFN );
    // Holding peg
    translate( [ 0 + pegLength/2 + gap, size/2, size/2 ] ) rotate( [0,90,0] ) cylinder( d=pegD, h=pegLength/2, $fn=pegFN );
}

module hole()
{
    // Hole for Rod
    translate( [ -1, size/2, size/2 ] ) rotate( [0,90,0] ) cylinder( d=pegD2 + slack*2, h=pegLength+slack+1, $fn=pegFN );
    // Hole for holding peg.
    translate( [ pegLength/2 - slack, size/2, size/2 ] ) rotate( [0,90,0] ) cylinder( d=pegD + slack*2, h=pegLength/2 + slack*2, $fn=pegFN );
}

module straight()
{
    translate( [-size/2, -size/2, 0] ) {
        difference() {
            cube( [size,size,size] );
            hole();
        }
        translate([size,0,0]) peg();
    }
}


module corner()
{
    translate( [-size/2, -size/2, 0] ) {
        difference() {
            cube( [size,size,size] );
            hole();
        }
        #translate([size,size,0]) rotate( [0,0,90] ) peg();
    }
}

module position( x, y, angle )
{
    translate( [x * (size + gap), y * (size +gap),0 ] )
    rotate( [0,0,angle] )
    children();
}

module inspect()
{
    intersection() {
        children();
        translate( [-50,-0.5,-50] ) cube( [100,1,100] );
    }
}

module test()
{
    straight();
    position( -1,0, 0 ) straight();
    //position( 1,0, 0 ) corner();
}

//inspect()
test();
