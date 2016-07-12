/*

*/

use <ntc/tools.scad>;
include <generated-spoonRest.scad>;


module spoonRest2()
{
    r=100;
    angle=24;
    y=r*cos(angle/2);
    x=r*sin(angle/2);
    bodge=0.1; // Ensures that the end pieces overlap very slightly to avoid "2-manifold" problems.

    difference() {    
    
        union() {
            // End pieces
            ntc_arrange_mirror() {
                translate([x-bodge,y,0]) rotate([0,0,-angle/2]) rotate([0,90,0]) rotate([-90,0,0]) {
                    rotate_extrude( angle=90, $fn=30 ) {
                        rotate(90) ink2scad(envelope);
                    }
                }
            }
            
            // Main 
            rotate([0,0,90-angle/2]) rotate_extrude( angle=angle, $fn=100 ) {
                translate([r,0]) ink2scad(envelope);
            }
        }

        // Grooves for spoons to rest in
        for ( i=[-1:1] ) {
            rotate( [0,0,i*15] ) {
                //translate([0,r-40,0]) rotate([-55,0,0]) cylinder( r1=0, r=12, h=60 );
                translate([0,r+18,0]) rotate([0,0,-90]) rotate([90,0,0])
                rotate_extrude( angle=90 ) {
                    translate([30,0]) circle( r=10 );
                }
            }
        }
    }
}

module cutMagnetHoles( d, h, dist )
{
    difference() {
        children();
        ntc_arrange_mirror() translate( [dist/2, 103.8, -0.01] ) cylinder( d=d,h=h );
    }        
}

module spoon()
{
    difference() {
        union() {
            cylinder( r=3, h=140 );
            scale( [0.8,0.3,1.3] ) sphere( r=18 );
        }
        translate( [-50,-102,-50]) cube(100);
        translate( [0,0,-0.5] ) scale( [0.8,0.3,1.3] ) sphere( r=17 );
    }
}


for (i=[-1:1]) {
    %rotate([11,0,11*i]) translate([-i*8,145,0]) mirror([0,1,1]) spoon();
}

cutMagnetHoles(11, 1.2, 60)
spoonRest2();
