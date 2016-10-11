/*
    A pedestal for a plant pot to stand on. Constructed in 5 parts, the top, bottom and three intertwined supports.
    The supports are screwed in place.

    The original design printed the bottom and the three supports in one go, but I found that printing was error
    prone, because the supports were deflected by the print head as it moved from one to another.
    
    Print Notes
        The supports are wobbly, with a small area touching the build plate, to print with a large brim.

        The top is printed upside down, and need support.
*/

use <ntc/tools.scad>;
use <ntc/countersink.scad>;

function easePower( t, power ) = pow(t, power);
function easeOut( t ) = t*t;
function easeInOut( t, pow1=0.5, pow2=0.5 ) = t < 0.5 ? easePower(t*2, pow1)/2 : 1-( easePower( (1-t)*2, pow2 )/2 );

HEIGHT=120;
THIN=0.4;
DEFAULT_THICKNESS=6;

BASE_WIDTH=100;
BASE_HEIGHT=20;

TOP_WIDTH=110;
TOP_HEIGHT=10;
TOP_THICKNESS=1.2;

SLACK=0.5;

twists=2;

function r( t ) = (1.7-sin(t*180))*10;
function x( t ) = r(t)*cos( t*360*twists );
function y( t ) = r(t)*sin( t*360*twists );
function z( t ) = easeInOut(t, 0.8, 0.8);

defaultThickness = DEFAULT_THICKNESS;
fatterBefore=0.4;
fatterAfter=0.8;

function size( t ) = t < fatterBefore ? defaultThickness + (fatterBefore-t)*25
                        : t < fatterAfter ?
                            defaultThickness
                        : defaultThickness + (t-fatterAfter) * 25;


module curve( height=HEIGHT, steps=30 )
{    
    function data( t ) = [[x(t),y(t),z(t)*height],size(t)];
    
    stepSize=1/steps;
    data = [ for (t = [0 : stepSize : 1]) data(t) ];

    for ( index=[1:len(data)-1] ) {
        hull() {
            translate( data[index-1][0] ) sphere( d=data[index-1][1] );
            translate( data[index][0] ) sphere( d=data[index][1] );
        }
    }

}

module clip(height=HEIGHT)
{
    difference() {
        children();
        
        translate([0,0,-50]) cube(100,center=true);
        translate([0,0,height+50]) cube(100,center=true);
    }
}

module screwHoles( size=1.5 )
{
    recess=2;
    translate([16, 3, -0.01]) ntc_countersink_hole( size, BASE_HEIGHT/2, head_diameter=6, recess=recess );
    //translate([15, 6, -height/4-recess]) ntc_countersink_hole( size, BASE_HEIGHT/2, head_diameter=6, recess=recess );
}

module base( width=BASE_WIDTH, height=BASE_HEIGHT, curveHeight=HEIGHT )
{
    module mound()
    {
        intersection() {
            hull() {
                sphere( d=30 );
                translate( [16,0] ) sphere( d=13 );
            }
            ntc_cube( 1000 );
        }
    }
    
    ntc_arrange_circle( 3, 0, rotate=true ) {
        difference() {
            // Create the mound
            translate([18,0,0]) scale([1,1,0.6]) mound();
        
            // Cut away a hole for the curves to fit in.
            translate([0,0,3]) clip() curve();

            // Screw holes to attach the curves
            intersection() {
                screwHoles(size=3);
                translate( [0,0,0.3] ) ntc_cube( 100 ); // Move it up, so that the base is easier to print.
            }
        }
    }    

    // A small hemisphere which joins the three mounds.
    translate([0,0,0]) {
        intersection() {
            scale([1,1,0.5]) sphere( d=10 );
            ntc_cube( 1000 );
        }
    }
}


module top( width=BASE_WIDTH, height=BASE_HEIGHT, curveHeight=HEIGHT )
{
    module mound()
    {
        intersection() {
            hull() {
                sphere( d=30 );
                translate( [20,-15] ) sphere( d=13 );
            }
            ntc_cube( 1000 );
        }
    }
    
    ntc_arrange_circle( 3, 0, rotate=true ) {
        difference() {
            // Create the mound
            translate([18,0,0]) scale([1,1,0.4]) mound();
        
            // Cut away a hole for the curves to fit in.
            translate([0,0,curveHeight+1.5]) rotate([180,0,0]) clip() curve();

            // Screw holes to attach the curves
            intersection() {
                screwHoles(size=3);
                translate( [0,0,0.3] ) ntc_cube( 100 ); // Move it up, so that the base is easier to print.
            }
        }
    }    

    // A small hemisphere which joins the three mounds.
    translate([0,0,0]) {
        intersection() {
            scale([1,1,0.5]) sphere( d=10 );
            ntc_cube( 1000 );
        }
    }
}

module pedestal( height=HEIGHT )
{
    clip() {
        union() {
            ntc_arrange_circle(3,0,1) curve(height);
            scale([1,1,0.2]) sphere( d=60 );
        }
    }
}

//pedestal();


