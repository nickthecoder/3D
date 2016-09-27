include <vases-bumpy.scad>;

// Rough shape of the pot that needs to fit inside this fancy one.
%translate([0,0,THICKNESS+1]) cylinder( d1=73, d2=103, h=96 );

//inspect()
vase( 36, 5 ) curve( bumps=5, startR=10, incR=1 );
ringedBase( 38 );
logo();

