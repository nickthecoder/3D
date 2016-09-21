/*
    To drain the water off of cuterly after washing up.
    
    Can be made in one go, or split into pieces (2 or 4 pieces?).
*/

include <ntc/tools.scad>;

THICKNESS=1.4;
SLACK=0.5;

module cutBack()
{
    translate([-100,0]) square( [200,200] );
}

module profileA()
{
    circle( d=50 );
}

module profileA()
{
    difference() {
        hull() {
            translate( [-80,-25] ) circle( d=55 );
            translate( [-60, 10] ) circle( d=30 );
        }
        profileB();
        cutBack();
    }
}

module profileB()
{
    difference() {
        hull() {
            translate( [-40,-35] ) circle( d=55 );
            translate( [-35, 10] ) circle( d=50 );
        }
        profileC();
        cutBack();
    }
}

module profileC()
{
    difference() {
        hull() {
            translate( [0,-40] ) circle( d=55 );
            translate( [ 5, 10] ) circle( d=30 );
        }
        cutBack();
    }
}

module profileD()
{
    difference() {
        hull() {
            translate( [50,-30] ) circle( d=55 );
            translate( [ 10, -5] ) circle( d=20 );
            translate( [ 40, -10] ) circle( d=30 );
        }
        profileC();
        cutBack();
    }
}

module drainage( floor )
{
    thickness = floor / 3;
    Xspacing=5;
    Xsize=2.5;
    
    Yspacing=15;
    Ysize=12;
    
    for (i=[0:16]) {
        translate( [i*Xspacing,-100,thickness] ) cube([Xsize,200, thickness*5]) ;
    }
    for (i=[0:10]) {
        translate( [-10,-i*Yspacing,-thickness] ) cube([80, Ysize, thickness*2]) ;
    }
}


module drainer( h, thickness=THICKNESS, floor=4, offset=0 )
{   
    // Edges
    linear_extrude( h )  {
        difference() {
            children();
            offset( r=-thickness ) children();
        }
    }
    // Base
    difference() {    
        linear_extrude( floor ) {
            children();
        }
        translate( [offset,0,0] ) drainage(floor);
    }
}

module lid( h=6, thickness=THICKNESS, inset=4, slack=SLACK )
{
/*
    // Top
    linear_extrude( thickness ) {
        difference() {
            children();
            offset( r=-inset ) children();
        }
    }
*/
/*
    // Inside edge
    translate([0,0,-h]) linear_extrude( h ) {
        difference() {
            offset( r=-thickness-slack ) children();
            offset( r=-thickness*2-slack ) children();
        }
    }
*/    
    curve=4;
    // Curved top?
    difference() {
        render() {
            minkowski($fn=70) {
                linear_extrude( 0.001 ) offset( r=-curve, convexity=4 ) children();
                intersection() {
                    sphere( r=curve, $fn=32 );
                    ntc_cube( [20,20,20] );
                }
            }
        }
        translate([0,0,-1]) linear_extrude( 8, convexity=4 ) {
            offset( r=-inset ) children();
        }
    }

    // Inside edge
    translate([0,0,-h]) linear_extrude( h ) {
        difference() {
            offset( r=-thickness-slack ) children();
            offset( r=-inset ) children();
        }
    }
}


drainer( 70, offset=-110) scale(1.4) profileA();
drainer( 95, offset=-70 ) scale(1.4) profileB();
drainer( 110, offset=-30 ) scale(1.4) profileC();
drainer( 95, offset=10 ) scale(1.4) profileD();

