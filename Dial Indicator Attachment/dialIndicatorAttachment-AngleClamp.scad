/*
    Join two rods, so that they can be turned to any angle, and held in place.
    
    Print Notes :
        Print with support (not only touching the build plate).
        
    Assembly :
        Print two copies, and sandwich them with a rubber washer.
        Drill the holes out, so that the screw moves freely on one piece and bites in on the other.
        Ifusing bolts, rather than screws, then tap the hole.
        You can usually use the bolt itself to tap the hole, as the plastic is soft.
*/

rodD=5.5;

baseD=30;
thickness=2;
heft=3;
gap=2;
overlap=7;
screwD=3;

module clampShape()
{
    difference() {
        union() {
            circle( d=rodD + heft*2 );
            translate( [-rodD/2,rodD/2] ) square( [rodD,rodD/2+overlap] );
        }

        // Hole for the rod
        circle( d=rodD );
        // Flatten to ensure it doesn't stick through the base
        translate( [rodD/2+thickness/2,-rodD] ) square( [100,100] );
        // Cut away a corner, so the rod is free when the screw isn't tightened
        square( [rodD/2+heft,rodD/2] );
        // Cut a gap so that the screw squeezes the rod
        translate( [rodD/2-gap,0] ) square( [10,100] );
    }
}

module clamp()
{
    translate( [0,-rodD/2-heft-overlap/2+1,rodD/2] ) rotate( [0,90,0] ) {
        linear_extrude( rodD * 1.5, center=true, convexity=4 ) clampShape();
    }
}

module angleClamp()
{
    difference() {
        union() {
            // Circluar base
            cylinder(d=baseD, h=thickness);
            // Clamp
            translate([0,0,thickness-0.1]) clamp();
        }
        
        // Hole though 
        cylinder( d=screwD, h=100, center=true );
    }
}

// Uncomment to print 4 in one batch
//use <ntc/tools.scad>;
//ntc_arrange_circle( 4, 22 )

angleClamp();



