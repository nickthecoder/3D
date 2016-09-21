/*
    The structure for a word clock. Instead of using numbers to display the time, use words, such as :
        It's twenty five to ten
        It's nearly quarter past seven
        It's just gone half past twelve

    Each box has a the word cut out of the front and contains a set of LEDs. Place something
    semi transparent in front (such as thin paper or cloth), and the words will shine through
    when lit, but will be invisible when not lit.
    
    There are 25 boxes in total. These could be wired directly to the arduino, in an 5x5 array,
    therefore using 10 pins (5 row pins plus 5 column pins).
    
    Alternately, use external shift registers if you want to use a minimal number of pins,
    or like the LEDs to be on permanently rather than rapidly turning them on and off.
*/

use <ntc/tools.scad>;

XSCALE = 6;
YSCALE = 20;
FONT = "Mushmellow:style=Bold";
FONT_WEIGHT = "bold";
FONT_SIZE = 12;
HEIGHT = 15;
THICKNESS = 0.7;
FRONT=1.2;
BACK=0.6;
SLACK=0.5;
THIN=0.6;

FLAP_WIDTH=4;
FLAP_HEIGHT=0.6;

module word( x, y, word )
{
    translate( [3 + x*XSCALE, 6-y*YSCALE, 0]) text( word, font=FONT, size=FONT_SIZE );
}


module edge( columns, rows )
{
    // Left
    translate( [0, -YSCALE*(rows-1), 0 ] ) cube( [THICKNESS, YSCALE*rows, HEIGHT] );
    // Right
    translate( [columns*XSCALE, -YSCALE*(rows-1), 0] ) cube( [THICKNESS, YSCALE*rows, HEIGHT] );

    for ( i = [0:rows] ) {
        translate( [0, -YSCALE*(i-1), 0] ) cube( [XSCALE*columns+THICKNESS, THICKNESS, HEIGHT] );
    }
}

module words( columns, rows, data )
{

    module end( x, y )
    {
        translate( [x*XSCALE, -y*YSCALE, 0] ) cube( [THICKNESS, YSCALE, HEIGHT] );
    }
    
    edge( columns, rows );
    
    difference() {
    
        translate([0,-YSCALE*(rows-1),0]) cube( [columns * XSCALE, rows * YSCALE, FRONT] );

        for ( item = data ) {
            translate([0,0,-1]) linear_extrude( FRONT+2 ) {
                word ( item[0], item[1], item[2] );
            }
        }
    }
        
    for ( item = data ) {
        end( item[0], item[1], item[2] );
    }
}

module box( x )
{
    extra = XSCALE * (x - floor(x)) / 2;
    module holes()
    {
        ntc_arrange_mirror( [0,1,0] ) translate( [0,1.25,0] ) cube( [2, 2, BACK*3], center=true );
    }

    module resistorHoles()
    {
        translate( [0,0,0] ) cube( [2, 2, BACK*3], center=true );
        translate( [12,0,0] ) cube( [2, 2, BACK*3], center=true );
    }

    difference() {
        translate([-THICKNESS+SLACK, SLACK-THICKNESS, 0] ) cube( [ x*XSCALE - THICKNESS - SLACK*2, YSCALE - THICKNESS - SLACK*2, HEIGHT-SLACK ] );
        translate([SLACK,SLACK, BACK] ) cube( [ x*XSCALE - THICKNESS*3 - SLACK*2, YSCALE - THICKNESS*3 - SLACK*2, HEIGHT-SLACK ] );

        // Holes for LEDs
        for ( i = [0:x-2] ) {
            translate([extra + i*XSCALE + XSCALE - THICKNESS - SLACK, YSCALE/2-THICKNESS*2,0]) holes();
        }

        // Holes for LEDs
        if ( x > 4 ) {
            for ( i = [0:floor((x-5)/3)] ) {
                translate([extra+i*3*XSCALE + XSCALE - THICKNESS - SLACK, 4,0]) resistorHoles();
            }
        }
        translate([-extra+(x-4)*XSCALE + XSCALE - THICKNESS - SLACK, 14,0]) resistorHoles();

    }

    // Shows where the LEDs will go.
    for ( i = [0:x-2] ) {
        %translate([extra+i*XSCALE + XSCALE - THICKNESS - SLACK, YSCALE/2-THICKNESS*2,0]) cylinder( d=5, h=7 );
    }
    
    
}

module post(x, y, size=6, hole=2 )
{
    translate( [XSCALE*x, YSCALE*y,0] ) {
        difference() {
            cube( [ size, size, HEIGHT ] );
            translate( [size/2, size/2, -1] ) cylinder( d=hole, h=HEIGHT +2 );
        }
    }
}

module thin(x, y)
{
    translate( [XSCALE*x, YSCALE*y,0] ) {
        cube( [THIN, YSCALE/4, FRONT] );
    }
}


module flaps( columns, rows, top=true )
{
    translate([-FLAP_WIDTH,(1-rows)*YSCALE,0]) cube( [FLAP_WIDTH, rows * YSCALE + THICKNESS, FLAP_HEIGHT] );
    translate([columns*XSCALE+THICKNESS,(1-rows)*YSCALE,0]) cube( [FLAP_WIDTH, rows * YSCALE + THICKNESS, FLAP_HEIGHT] );
    
    dy = top ? YSCALE + THICKNESS : -YSCALE*(rows-1)-FLAP_WIDTH;
    
    translate( [-FLAP_WIDTH, dy, 0] ) cube( [ columns * XSCALE + THICKNESS + FLAP_WIDTH*2, FLAP_WIDTH, FLAP_HEIGHT] );    
}

