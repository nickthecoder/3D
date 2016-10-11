/*
    A case for a component tester (which is bought as a bare circuit board).
    http://www.banggood.com/LCR-T4-12864LCD-ESR-SCR-Meter-Transistor-Tester-p-978992.html
    Note, that some items on Ebay look similar, but have made the board slightly smaller, by
    setting the screen off center. Avoid!
    
    This case requires that the original circuit board is cut, so that the screen can be angled
    and the ZIF socket and button are moved above the screen.
    Use a multimeter to find where the buttons pins are connected, as well as the three connections
    to the ZIF socket. Hint :
        Switch connects to the left pin of the 2nd of 3 transistor + Lower backlight wire
        The ZIF socket connects to the the 2nd, 3rd and 5th resistor.
    Cut the circuit board, and add patch wires to reconnect the two parts.
    
    Requires 6 M3 nuts and bolts.
    
    Print Notes
        Print the ends and body with a complementary colours.

    NOTE. I've made improvements since I printed mine out, and haven't tested them.
    Button's hole is in  better place and smaller. Battery holder is better. Slightly longer,
    so that the bolts don't get in the way of the end caps. Decreased SLACK for a tighter fit.
*/

include <ntc/tools.scad>;
include <ntc/parts.scad>;
include <ntc/chamfer.scad>;

length = 84; // Length of the body
r=3;         // Radius of the rounded corners

h=40;        // Height of the profile, excluding rounded corners
b=10;        // Height of the bottom front part exluding rounded corners

w=74;        // Width of the profile excluding rounded corners
t=w-(h-b)*tan(60); // Width of the top bit, with a 60 degree tilt for the screen.

/*
    The filled 2D shaped used to extrude the body and end caps.
*/
module profile()
{

    offset( r=r, $fn=16 ) {
        polygon( [ [0,0], [w,0], [w,b], [t,h], [0,h] ] );
    }
}

/*
    The main body
*/
module body()
{
    screenX = 56;
    screenY = 31;
    inset=1.5;
    
    difference() {
        part_extrusion( length, center=true ) profile();

        // Screen
        panelPosition() cube([screenX,screenY,2], center=true);
        panelPosition() translate([0,0,inset]) mirror([0,0,1]) chamfer_squareHole(screenX, screenY,inset=inset);

        // Screw holes to attach the screen
        panelPosition() ntc_arrange_mirror([1,1,0]) translate([33,20,0]) cube( [2,2,10],center=true );
                
        // ZIF socket
        topPosition() translate([-21,0,0]) cube([34,16,10], center=true);

        // Push button
        topPosition() translate([27.5,1.5,0]) cylinder( d=10, h=10, center=true );
    }
    
    // Battery Holder
    mirror([0,0,1]) translate([16.5,-r,0]) rotate([0,0,0]) {
        hull() {
            translate([2.5,12,0]) difference() {
                sphere( d=10, h=10, center=true );
                ntc_cube( 20, align=[0.19,0.5,0.5] );
            }
            ntc_cube( [ 4, 1, 25 ], center=[false,false, true] );
        }
    }
    
    // panelPosition() ntc_arrange_mirror([1,1,0]) translate([33,20,0]) post();
}

/*
    Design shapes in the X/Y plane, then apply this and they will be transfered to the angled front.
    (0,0,0) is on the surface, in middle of the tilted panel.
*/
module panelPosition()
{
    y = (h+r + b+r)/2;
    x = t + (w - t)/2;

    translate([x,y,0]) rotate([0,90,60]) children();
}

/*
    Design shapes in the X/Y plane, then apply this and they will be trasfered to the top of the
    extruded body. (0,0,0) is the middle of the top surface.
*/
module topPosition()
{
    translate([t/2,h+r,0]) rotate([-90,90,0]) children();
}

/*
    An end cap. Mirror to get the other cap.
*/
module cap()
{
    part_extrusionCap( center=true, inside=7 ) profile();
}


