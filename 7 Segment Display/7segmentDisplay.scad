/*
    A home-made 7 segment display (including decimal point).

    Print Notes
        Use a low fill value (10%)
        Either swap from white to black filament for the last couple of layers,
        or just colour the front black with a permanent marker.

*/
include <ntc/tools.scad>;
include <7segmentDisplay-generated.scad>;

WIDTH=40;  // Default width of a digit (not including margins etc).
FRONT=0.3; // Thickness of the front of digitsCase (must be small for the light to pass through).
BACK=0.9;  // Thickness of the back of the digits (where the led's legs stick through
THICKNESS=1; // Thickness of the digitsCase walls
DEPTH=12;  // Z value for digits

SLACK=0.5; // Extra gap, so that the digitsCase fits snuggly around the digits
GAP=4;     // How much deeper the digitsCase is compared to the digits (may be negative for shorted cases).
MARGIN=5;  // Additional space around the outside
SPACING=1; // Additional space between digits

THICKEN=0.2; // Thickens the walls (making the voids smaller).

function sevenSegmentHeight( w ) = w*1.55;

function scale( w ) = w*0.0375;

module digitsCase( digits=1, w=WIDTH, margin=MARGIN, depth=DEPTH, front=FRONT, thickness=THICKNESS, slack=SLACK, gap=GAP )
{
    h = sevenSegmentHeight( w, margin, thickness );
    
    tw = digits * (w+slack) + thickness * 2 + slack;
    th = h + thickness * 2 + slack * 2;
    
    scale = scale(w, margin);
    

    linear_extrude( front ) square( [tw, th] );
    
    linear_extrude( depth+slack+thickness+gap ) {
        difference() {
            square( [tw,th] );
            translate([thickness, thickness]) square( [tw-thickness*2,th-thickness*2] );
        }
    }
}

module ledHoles()
{
    translate([1.25,0]) square( 2, center=true );
    translate([-1.25,0]) square( 2, center=true );
}

LED_PAIRS=[
    [0.18, 0.07, 90], [0.63, 0.07, 90], // bottom
    [0.07, 0.18,  0], [0.10, 0.65,  0], // bottom left
    [0.74, 0.18,  0], [0.78, 0.65,  0], // bottom right
    [0.24, 0.75, 90], [0.66, 0.75, 90], // middle
    [0.12, 0.85,  0], [0.16, 1.32,  0], // top left
    [0.79, 0.85,  0], [0.83, 1.32,  0], // top right
    [0.27, 1.44, 90], [0.72, 1.44, 90], // top
    [0.93, 0.07, 90] // deciaml point
];

module digits( n=1, w=WIDTH, ad=DEPTH, leds=LED_PAIRS, back=BACK, thicken=THICKEN, margin=MARGIN, spacing=SPACING )
{
    tw = n*w + (n-1)*spacing + margin*2;
    th = sevenSegmentHeight( w ) + margin*2;
    
    difference() {
        linear_extrude( ad ) square( [tw, th] );
        translate( [margin, margin,0] ) ntc_arrange_grid( n, w + spacing ) digit( w, ad, leds, back );
    }
}

module digit( w=WIDTH, ad=DEPTH, leds=LED_PAIRS, back=BACK, thicken=THICKEN )
{        
    scale = scale(w);

    translate([0,0,back]) linear_extrude( ad, convexity=20 ) {
        scale( scale ) offset(r=-thicken) ink2scad( italic );
    }

    translate([0,0,back-1]) linear_extrude( back+2 ) {
        for ( position=leds ) {
            translate( position * w ) rotate( position[2] ) ledHoles();
        }
    }
}

digits = 4;

%digitCase( digits );
ntc_arrange_grid( digits, WIDTH+SLACK ) {
    translate([WIDTH+THICKNESS+SLACK,THICKNESS+SLACK,DEPTH+FRONT+SLACK]) rotate([0,180,0]) digit();
}

//translate([0,-50,0]) digit();

