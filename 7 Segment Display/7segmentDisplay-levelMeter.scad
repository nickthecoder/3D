/*
    A 5 segment level meter, for use with KA2284.
    
    The holes are spaced, so that stripboard can be placed under the plastic housing, and the
    LEDs' legs poke through both. The driver circuitry can be then be on the same board, which is held
    in place by the LEDs.
    
    Print Notes
        Print using a dark colour, to avoid the light bleeding through the thin walls.
    
*/
use <ntc/tools.scad>;
use <ntc/chamfer.scad>;
use <ntc/parts.scad>;

WALL =1.2; // Thickness of walls separating the LEDs 
FLOOR=1.2; // Thickness of the floor

BOX_X=2.5*2-WALL;
BOX_Y=6;
BOX_Z=8;

SLACK=0.5;

BEZEL=2;
BEZEL_Z=1;

module housing( n=5 )
{
    x = (BOX_X + WALL ) * n + WALL;
    y = BOX_Y + WALL * 2;
    
    difference() {
        cube( [x,y, BOX_Z + FLOOR], center=true );
        
        for (i = [0:n-1]) {
            translate([(BOX_X+WALL)*(i-(n/2)+0.5),0,WALL/2]) {
                cube( [BOX_X, BOX_Y, BOX_Z+1], center=true );
                translate([0,0,-BOX_Z/2]) part_ledHoles();
            }
        }
    }
}

module bezel( n=5, h=6, thickness=0.4, chamfer=1 )
{
    x = (BOX_X + WALL ) * n;
    y = BOX_Y + WALL;

    wx = (BOX_X + WALL ) * n + WALL + SLACK * 2;
    wy = BOX_Y + WALL * 2 + SLACK * 2;

    difference() {
        ntc_cube( [x+BEZEL*2, y+BEZEL*2, BEZEL_Z] );
        cube( [x,y,BEZEL_Z*3], center=true );
        translate([-x/2-BEZEL, -y/2-BEZEL,0 ]) chamfer_cube( [x+BEZEL*2, y+BEZEL*2, BEZEL_Z * 10], bottom=true, all=false );
    }

    difference() {
        translate([0,0,BEZEL_Z]) ntc_cube( [wx+thickness*2,wy+thickness*2, h-BEZEL_Z] );
        cube( [wx,wy,h*3], center=true );
    }
}

//ntc_inspect("y", 2, tilt=5)
{
    translate([0,0,7]) mirror([0,0,1]) housing();
    bezel();
}

