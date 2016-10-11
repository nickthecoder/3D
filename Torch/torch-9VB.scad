/*
    An alternate design for a 9V battery powered torch.

    Print Notes
        The head is printed on its side, and needs support touching the build plate.
*/

use <ntc/tools.scad>;
use <ntc/parts.scad>;
use <ntc/chamfer.scad>;

x=36;    // Size of the body
y=28;
z=76;
r=5;     // Roundedness of the body

inside=7; // Size of the walls that fit within the main body

gap=3.6;          // Height for the COB led to slide through.
APPETURE=[10,10]; // Size of the hole for the light to shine through
BUTTON_D=13.5;    // Diameter of the hole for the switch.

module profile()
{
    hull() ntc_arrange_mirror( [1,1] ) translate( [x/2-r,y/2-r] ) circle( r=r );
}

module body()
{
    difference() {
        part_extrusion( z ) profile();
        translate([0,0,17]) ntc_cylinder( d=BUTTON_D, h=100, axis="x" );
    }
}

    
module end()
{
    part_extrusionCap(inside=inside) profile();
}

module head()
{
    // %translate([0,0,1.5]) ntc_cube([27,20,4]);

    difference() {
        // The cap
        union() {
            part_extrusionCap(inside=inside) profile();
            part_extrusionCapExtra(inside=inside) profile();
        }
        // Minus the appature
        cube([APPETURE[0], APPETURE[1],10], center=true );

        // Chamfer the appature
        translate([0,0,-6]) {
            chamfer_squareHole( APPETURE[0], APPETURE[1], inset=5 );
        }
        
        // Hole for the COB LED to slide in
        ntc_cube([22,22,gap], align=[0,0.5,-0.3] );
    }
    
    // Bar to hold the LED in place
    ntc_arrange_mirror() translate([12,0,5.1]) ntc_cube([6,y-6,3]);
    
    // Bars to aid printing on its side with less supports
    translate([-x/2+3, y/2-gap, 0]) cube([x-6,1,3]);
    translate([-x/2+3, y/2-gap, inside-0.6]) cube([x-6,1,2]);
}

/*
body();
translate( [0,0,-14] ) base();

translate([0,0,80]) mirror([0,0,1]) head();
*/


