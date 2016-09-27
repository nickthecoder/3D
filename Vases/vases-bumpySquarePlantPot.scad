include <vases-bumpy.scad>;

SIDES=4;

rotate( [0,0,45] ) {

    // Rough shape of the pot that needs to fit inside this fancy one.
    // Note that d1 and d2 are the DIAGONAL dimensions
    %translate([0,0,THICKNESS+1]) cylinder( d1=94, d2=120, h=100, $fn=4 );

    //inspect()
    vase( 46, 5 ) curve( bumps=5, startR=10, incR=1 );
    ringedBase( 48 );
    logo();
}

