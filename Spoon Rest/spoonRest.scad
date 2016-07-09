/*
    Inspired by : https://www.youmagine.com/designs/spoons-rest-3-spoons
    Alas, as usual, no source code (unless the object was designed in raw stl), so I made my own from scratch. Grrr.

    I didn't want to shape to be too "fussy", because that would make it harder to clean (so no unwanted arches).
    No angled internal corners (same reason).
    
    The shapes were designed in Inkscape, and imported into OpenSCAD using my own tool "ink2scad".
    
    There's a module to cut holes for magnets, so that it will stick to my fridge when not in use.
*/

include <generated-spoonRest.scad>;
use <ntc/tools.scad>;

module cutMagnetHoles( d, h, dist )
{
    difference() {
        children();
        ntc_arrange_mirror() translate( [dist/2, 0, -0.01] ) cylinder( d=d,h=h );
    }        
}

module spoonRest()
{

    intersection() {
        translate( [-spoonRestProfile[2][0]/2,50,0] ) rotate( [90,0,0] ) linear_extrude( 100, convexity=8 ) ink2scad( spoonRestProfile );
        translate( [-100,-envelope[2][0]/2,0] ) rotate( [0,0,90] ) rotate( [90,0,0] ) linear_extrude( 200 ) ink2scad( envelope );
        translate( [-bend[2][0]/2, -bend[2][1]/2 ,0] ) linear_extrude( 100, convexity=4 ) ink2scad( bend );
    }
    
}

// Comment out, if you don't want the magnet holes
cutMagnetHoles(12.5, 1.6, 60)

spoonRest();

