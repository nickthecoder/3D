/*

*/

function z( i, startR, incR ) = startR + i * (startR * 2 + i * incR);
function r( i, startR, incR ) = startR + i * incR;
    

THICKNESS=1.2;
QUALITY=50;
SIDES=60;

module crinkle( bumps, startR, incR )
{
    function y( s, r, t ) = ( (t+r)*(t+r) + (s+r)*(s+r) - (s+t)*(s+t) ) / (2*(s+r));
    function x( y, r, t ) = sqrt( (t+r)*(t+r) - y *y );

    module touching( i )
    {
        r=r(i,startR,incR);
        s=r(i+1,startR,incR);
        t=r(i+0.5,startR,incR);
        y = y( s,r,t );
        x = x( y, r, t );
        translate( [ x, z(i,startR, incR) + y ] ) {
            circle( r = r( i+0.5, startR, incR ), $fn=QUALITY );
        }
    }
    

    difference() {
        union() {
            for (i=[0:bumps-1]) {
                translate( [0,z(i, startR, incR)] ) circle( r = r( i, startR, incR ), $fn=QUALITY );
            }
            for (i=[0:bumps-2]) {
                translate( [0, z(i+0.5, startR, incR)] ) circle( r = r( i+0.5, startR, incR ), $fn=QUALITY );
            }

        }
    
        for (i=[0:bumps-2]) {
            touching( i );
        }
    }    
}

module curve( bumps, startR, incR, thickness=THICKNESS )
{
    difference() {
        crinkle(bumps, startR, incR );
        offset( r=-thickness ) crinkle( bumps, startR, incR );
        
        // Cut off the extra on the left
        translate([-1000,0]) square( [1000,1000] );
        // Cut off the extra at the top
        translate([0,z(bumps-1,startR, incR)]) square( [1000,1000] );
    }
    
    // Circle to curve the very top piece.
    translate( [r(bumps-1,startR,incR)-thickness/2,z(bumps-1,startR,incR)] ) circle( d=thickness, $fn=8 );
}


module vase( baseR, angle=0, baseThickness=THICKNESS )
{
    rotate_extrude( $fn=SIDES ) {
        translate([baseR,0]) rotate( -angle ) children();
    }
    
    if (baseThickness) {
        solidBase( baseR, baseThickness );
    }
}

module solidBase( baseR, baseThickness=THICKNESS )
{
    // Solid Base
    cylinder( r= baseR+1, h=baseThickness, $fn=SIDES );    
}

module ringedBase( r1, r2=12, step=5, width=1.4, baseThickness=THICKNESS )
{
    translate( [0,0,-baseThickness+0.1] ) {
        
        // Rings under the base
        // Prevents warping, by ensuring there isn't a large surface directly touching the build plate.
        // Looks nice too ;-)
        rings = 10;
        for (i=[r1:-step:r2]) {
            linear_extrude( baseThickness ) {
                difference() {
                    circle( r = i, $fn=SIDES );
                    circle( r = i-width, $fn=SIDES );
                }
            }
        }
    }
}

module logo( baseThickness=THICKNESS )
{
    translate( [0,0,-baseThickness+0.1] ) {
        #linear_extrude( baseThickness ) mirror() text("ntc", valign="center", halign="center");
    }
}

module inspect()
{
    intersection() {
        cube( [2000,1,4000], center=true );
        children();
    }
}

/*
Example usage :

// Rough shape of the pot that needs to fit inside this fancy one.
%translate([0,0,THICKNESS+1]) cylinder( d1=73, d2=103, h=96 );

// Uncomment to see a slice, to ensure the plain pot fits inside the fancy one.
//inspect()
vase( 36, 5 ) curve( bumps=5, startR=10, incR=1 );
ringedBase( 38 );
logo();

*/

