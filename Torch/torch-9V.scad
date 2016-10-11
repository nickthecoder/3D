/*
    A small, yet bright torch powered by a 9V battery.
    
    I used these COB LEDs, which are rated 9V-12V :
    http://www.banggood.com/10W-Warm-Pure-White-High-Brightest-Save-Power-LED-Light-Lamp-p-88169.html
    There are 9 LEDs in a 3 parallel, 3 serial array, and with each LED having a forward voltage over 3V
    that gives us a forward voltage over 9V (which is why we don't need any form of current limiting).
    Even though we are under powing the LEDs, the torch is bright enough to be uncomfortable if you look
    directly into it.
    
    Any small latching switch will do. I chose these :
    5 / 10 x On/Off Latching Push Button Switch Locking Car Dashboard Dash Boat 12V
    http://www.ebay.co.uk/itm/281475922789?_trksid=p2060353.m2749.l2649
    As Ebay tends to break links over time, here's a more expensive, but idential looking product on Amazon :
    https://www.amazon.co.uk/Latching-Button-Switch-Locking-Black/dp/B00XBUU0FQ    

    You'll also need a 9V battery clip :
    https://www.amazon.co.uk/gp/product/B00HG8BJWM
*/

include <ntc/tools.scad>;
include <ntc/chamfer.scad>;

// Internal size of the main compartment which holds the battery.
WIDTH=20.5;
DEPTH=29;
HEIGHT=51;

// Size of the head compartment, which hold the LED and switch.
HEAD_HEIGHT=25;

THICKNESS=1.5;

GLASS_H=0;
LED_H=3.9;
LED_D=36;
APPETURE=[10,10];

RAIL=2;
RAIL_H=2;
RAIL_D=10;

BUTTON_D=13.5;
BUTTON_Z=13;

SLACK=0.5;

module rail( z )
{
    translate([-WIDTH/2,-DEPTH/2 +SLACK, z]) {
        hull() {
            cube( [RAIL,RAIL_D,RAIL_H] );
            // Add a slope, so that it can be printed without supports
            translate([0,RAIL_D,0]) cube( [0.1,RAIL,RAIL_H] );
        }

    }
}

module stop( l, z )
{
    translate([-WIDTH/4,DEPTH/2-l,z]) cube( [WIDTH/2, l, RAIL_H] );
}

module stump( z )
{
    translate([-WIDTH/2+SLACK,DEPTH/2-RAIL_D, z]) cube([WIDTH-SLACK*2, RAIL_D, RAIL_H ]);
}

module head()
{
    w=WIDTH+THICKNESS*2;
    d=DEPTH+THICKNESS*2;
    h=HEAD_HEIGHT+THICKNESS;

    difference() {
        union() {
            ntc_cube( [w,d,h] );
        }
        
        // Make it hollow
        translate([0,-5,THICKNESS]) ntc_cube( [WIDTH, DEPTH+10, HEAD_HEIGHT+1] );
        
        // Hole for the light to shine through
        translate([0,0,-1]) linear_extrude(THICKNESS*2) square( APPETURE, center=true );


        // Hole for the button    
        translate([0,DEPTH,BUTTON_Z]) rotate([90,0,0]) cylinder( d=BUTTON_D, h=DEPTH );
        chamfer_squareHole( APPETURE[0], APPETURE[1] );

        // Chamfer edges        
        translate( [-w/2,-d/2,0] ) chamfer_cube( [w,d,h] );
    }

    render()
    difference() {
        // Extension the height of the body
        translate([-WIDTH/2+SLACK,d/2-THICKNESS,h]) cube([WIDTH-SLACK*2, THICKNESS, HEIGHT]);
        translate( [-w/2,-d/2, h] ) chamfer_cube( [w,d,HEIGHT+100] );
    }
    
    // Rail to hold the led and glass
    ntc_arrange_mirror() rail( THICKNESS + GLASS_H + LED_H );
    
    // Stop end to alight the LED correctly
    stop( (DEPTH-LED_D)/2, THICKNESS + GLASS_H + SLACK );

    // Rail for the base to clip onto
    ntc_arrange_mirror() rail( HEAD_HEIGHT-RAIL_H+THICKNESS );
    
    // Stump
    stump( h+HEIGHT - RAIL - SLACK );

}

module body()
{
    w=WIDTH+THICKNESS*2;
    d=DEPTH+THICKNESS*2;
    h=HEIGHT + THICKNESS;

    // Main body, where the battery will go.
    difference() {
        ntc_cube( [w,d,h] );

        // Make it hollow
        translate([0,-THICKNESS,-1]) ntc_cube( [WIDTH, DEPTH+THICKNESS*2, HEIGHT+1 ] );

        // Chamfer edges        
        translate( [-w/2,-d/2,0] ) chamfer_cube( [w,d,h] );
    }
    // Extension, the height of the head.
    translate([-WIDTH/2+SLACK,d/2-THICKNESS,-HEAD_HEIGHT]) cube([WIDTH-SLACK*2, THICKNESS, HEAD_HEIGHT]);
    
    // Ensures that the LED cannot move away from the stop in the head.
    stop( (DEPTH-LED_D)/2, -HEAD_HEIGHT + GLASS_H + SLACK );

    // Stump for the head to clip onto
    stump( -RAIL*2 - SLACK*2 );
    
    // Rails for the head to clip onto
    ntc_arrange_mirror() rail( HEIGHT - RAIL_H*2 - SLACK*3 );
}

module inspect()
{
    thin = 0.3;

    intersection() {
        union() {
            cube([1,100,100], center=true);
            translate([0,-DEPTH/2+1]) cube([100,thin,100], center=true);
            translate([0,DEPTH/2-1]) cube([100,thin,100], center=true);
        }
        children();
    }
}

/*
inspect() {
    head();
    translate([0,0,HEAD_HEIGHT+THICKNESS+SLACK/2]) body();
}
*/

translate([20,-10,HEAD_HEIGHT+THICKNESS+SLACK/2]) rotate([0,0,180]) body();
#translate([20,0,0]) head();

