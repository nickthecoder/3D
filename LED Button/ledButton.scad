/*
    I need a momentary switch, with an inbuilt indicator LED. These are either expensive, or very limited
    in terms or size and colour. So I've designed my own housing incorporating a standard switch and LED.

    Designed to use common LEDs and switches. The type of switch I use has a 8x8mm body, and comes in
    latching and momentary varieties. Note, there are also 7x7mm versions, which look exactly the same,
    and are now cheaper on ebay! Alter parameters switchH and switchW of module body.

    Print Notes.
        Layer height of 0.1
        
        Print the cap and inside pieces in a transparent material, and the body in an opaque material.
*/

use <ntc/tools.scad>;

SLACK=0.5;
SIDES=32;
notch=2;
NOTCH_THICKNESS=1.8;
THICKNESS=0.6;
CHAMFER=1;

CAP_HEIGHT=10;
CAP_TOP=0.4;

INSIDE_HEIGHT=2;

SURROUND_THICKNESS=1.2;
BODY_MARGIN=4;
BODY_HEIGHT=10;

module notchProfile( size )
{
    polygon( [ [0,0], [size,0], [size, size] ] );
}

/*
    The part that is pushed. Printed using transparent plastic, as the light from the LED must pass through.
*/
module cap( d=16, h=CAP_HEIGHT, insideH=INSIDE_HEIGHT, thickness=THICKNESS, top=CAP_TOP, chamfer=CHAMFER )
{
    // Top
    difference() {
        translate( [0,0,h-chamfer] ) cylinder( d1=d, d2=d-chamfer*2, h=chamfer, $fn=SIDES );
        translate( [0,0,h-chamfer-0.01] ) cylinder( d1=d-thickness*2, d2=d-thickness*2-chamfer*2+top*2, h=chamfer-top, $fn=SIDES );
    }

    // Edges
    linear_extrude( h-chamfer, convexity=4 ) {
        difference() {
            circle( d=d, $fn=SIDES );
            circle( d=d-thickness*2, $fn=SIDES );
        }
    }
        
    // How the cap pushes down on the 'inside' piece.
    jutting=1.5;
    #translate([0,0,insideH]) rotate_extrude( $fn=SIDES ) {
        translate([d/2-jutting-thickness,0]) notchProfile( jutting );
    }
}

/*
    Placed onto the switch. The 'cap' is placed on top of this.
*/
module inside( d=16, h=INSIDE_HEIGHT, thickness=THICKNESS, hole=4, ledHole=7, slack=SLACK )
{
    d1 = d-thickness*2-slack;
    
    channel=2;
    channelH=0.5;
    
    difference() {
        union() {
            // Thin base, which fits OUTSIDE of the cap.
            cylinder( d=d-slack, h=thickness, $fn=SIDES );
            // Main bit
            cylinder( d=d1, h=h+thickness, $fn=SIDES );
        }

        // Hole for the switch
        cylinder( d=hole, h=h*4, center=true, $fn=8 );
        
        translate( [0,0,h+thickness] ) {
            // Channel for the LED's legs to spread outwards
            cube( [d*2,channel, channelH*4], center=true );
            // Indent for the LED to sit in - helps align it in the middle.
            cylinder( d=ledHole, h=channelH*2, center=true, $fn=SIDES );
        }
        
        // Channels down the side for LED's legs
        ntc_arrange_mirror() translate([d1/2,0,h/2]) cube([channelH*2+notch*2, channel, h*2], center=true);

    }
}

/*
    Used by "body" for two sides of the box which holds the switch.
*/
module switchSideProfile( h, w, thickness=THICKNESS )
{
    in = thickness*2.4;
    polygon( [ [0,0],[0,h],[thickness,h], [in, in], [w,thickness], [w,0] ] );
}

/*
    The main stationary part of the button.
*/
module body( d=16, h=BODY_HEIGHT, switchH=8, switchW=8, offset=BODY_MARGIN, surroundThickness=SURROUND_THICKNESS, caseThickness=4, thickness=0.6, chamfer=CHAMFER )
{
    switchHoleW = switchW + SLACK*2;
    switchHoleH = switchH + SLACK;
    
    wobble = SLACK*3;
    bodyD = d + wobble+thickness*2;
    
    // Surrond abover the case (ignoring chamfer)
    translate([0,0,h]) {
        linear_extrude( surroundThickness-chamfer, convexity=4 ) {
            difference() {
                circle( d=d+offset*2 );
                circle( d=d+wobble );
            }
        }
    }
    // Chamfer of the body above the case
    translate([0,0,h+surroundThickness-chamfer]) difference() {
        cylinder( d1=d+offset*2, d2=d+offset*2-chamfer*2, h=chamfer );
        cylinder( d=d+wobble, h=h, center=true );
    }
        
    // Main body
    linear_extrude( h, convexity=4 ) {
        difference() {
            circle( d=d+wobble+thickness*2 );
            circle( d=d+wobble );
        }
    }
    
    // Two sides of the box to hold the switch.
    intersection() {
        ntc_arrange_mirror() {
            translate([switchHoleW/2,-bodyD/2,0]) rotate([-90,0,0]) linear_extrude( bodyD, convexity=4 ) {
                switchSideProfile( switchHoleH+thickness*2, bodyD/2-switchHoleW/2, thickness );
            }
        }
        translate([0,0,-switchHoleH-thickness*2]) cylinder( d1=switchHoleW + thickness*2 + 3, d2=bodyD, h=switchHoleH+thickness*2 );
    }
    // The other two side of the box to hold the switch
    ntc_arrange_mirror([0,1,0]) {
        translate([-switchHoleW/2-thickness,switchHoleW/2,-switchHoleH]) cube([switchHoleW+thickness*2, thickness, switchHoleH-3]);
    }
    // Top of the box which holds the switch
    translate([0,0,-switchHoleH-thickness*2]) ntc_cube( [switchHoleW+thickness*2, switchHoleW/2,thickness*2] );
    
}

/*
    For testing purposes - cuts a slice through the children.
*/
module inspect()
{
    intersection() {
        cube( [1000,1,1000], center=true );
        children();
    }
}

// The following are used during development only. The final pieces each have their own scad file.

//inspect() {


//inside();
//%translate([0,0,THICKNESS]) cap();
//translate([0,0,-1]) body();

translate([20,0,CAP_HEIGHT]) rotate([180,0,0]) cap();
translate([38,0,0]) inside();
translate([60,0,BODY_HEIGHT+SURROUND_THICKNESS]) rotate([180,0,0]) body();
//}


