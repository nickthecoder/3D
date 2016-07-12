thickness = 2;
sheet = 1.2;
overlap = 3;
width = 55;
length = 96;
height = 14;

radius = 3;


module rounded( width, length, height, radius )
{
    module roundedFlat()
    {
        hull() {
            translate( [radius,radius,radius] ) sphere( r=radius );
            translate( [width-radius,radius,radius] ) sphere( r=radius );
            translate( [radius,length-radius,radius] ) sphere( r=radius );
            translate( [width-radius,length-radius,radius] ) sphere( r=radius );
        }
    }

    hull() {
        roundedFlat();
        translate( [0,0, height - radius * 2] ) roundedFlat();
    }
}

module post( x, y, size=4, height=3 )
{
    translate( [x-size/2,y-size/2,0] ) {
        cube( [size, size, height] );
    }
}

module case()
{
    translate( [-thickness, -thickness, -sheet] ) 
    intersection() {
        rounded( width + thickness* 2, length + thickness*2, height*2, radius );
        cube( [ width + thickness* 2, length + thickness*2, height+sheet ] );
    }
}

module powerSwitchHole( left=0 )
{
    translate([width-left*width,80,height - left*overlap]) rotate([0,90,0])
    hull() {
        cylinder( d=7, h=10, center=true );
        translate([-10,0,0]) rotate([0,90,0]) cylinder( d=7, h=10, center=true );
    }
}

module buttonHole( x, y )
{
    translate( [width -x, y, -sheet/2] ) cylinder( d=12, h=sheet*2, center=true );
}

module ledHole( left=0 )
{
    translate([ width/2, length, height]) rotate( [90,0,0] ) hull() {
        cylinder( d=7, h=10, center=true );
        translate([0,-3,0]) cylinder( d=7, h=10, center=true );
    }
}

module base()
{    
    difference() {
        case();

        cube( [width, length, height*2] );
        translate([-thickness/2, -thickness/2,height-overlap]) cube( [width+thickness, length+thickness, overlap+1] );
        
        ledHole();
        powerSwitchHole();
    }

    post( 36, 74 );
    post( 18.5, 74 );
    post( 4, 7 );
    post( width-4, 7 );
}

module top()
{
    slack=0.3;
    
    pitch = 2.55;
    col1 = 8;
    col2 = col1 + 2 * pitch;
    col3 = col1 + 5 * pitch;
    col4 = col1 + 6 * pitch;
    col5 = col1 + 10 * pitch;
    col6 = col1 + 15 * pitch;

    echo( "col6", col6, "was 47" );
    
    row1 = 8.5;
    row2 = row1 + pitch;
    row3 = row1 + pitch * 2;
    row4 = row1 + pitch * 8;
    row5 = row1 + pitch * 14;
    row6 = row1 + pitch * 17;
    row7 = row1 + pitch * 21;
    row8 = row1 + pitch * 25;
    row9 = row1 + pitch * 30;
    echo( "row 8", row8, "was 71" );
    
    difference() {
        case();

        cube( [width, length, height*2] ); // Inside

        translate([-10-thickness/2+slack,-thickness,height-overlap])
            cube( [10,length+10, thickness*2] ); // Left edge

        translate([width+thickness/2-slack,-thickness,height-overlap])
            cube( [10,length+10, thickness*2] ); // Right edge

        translate([-5,-10-thickness/2+slack,height-overlap])
            cube( [width+10,10, thickness*2] ) ;// Bottom edge

        translate([-5,length+thickness/2-slack,height-overlap])
            cube( [width+10,10, thickness*2] ); // Top edge

        // Top Left buttons
        buttonHole( col1, 84.5 );
        buttonHole( col1, 71.5 );
        buttonHole( col1, 61.5 );
        buttonHole( col1, 51.5 );

        // Top Right buttons
        buttonHole( col6, 84.5 );
        buttonHole( col6, 71.5 );
        buttonHole( col6, 61.5 );
        buttonHole( col6, 51.5 );

        // Left/Right buttons
        buttonHole( col3, 44 );
        buttonHole( col5, 44 );

        // Direction buttons
        buttonHole( col2, 18.5 );
        buttonHole( col4, 18.5 );
        buttonHole( col5, 18.5 );
        buttonHole( col4, 28.5 );
        buttonHole( col4, 8.5 );

        // Volumne buttons
        buttonHole( col6, 26 );        
        buttonHole( col6, 11 );        

        // Screen
        translate( [16, 58, -height] ) cube( [width-16*2,14, height*2] );

        ledHole(1);
        powerSwitchHole(1);

    }

    post( 18.5, 90, height=5 );
    post( 46.5, 34.5, height=5 );
    post( 46.5, 4, height=5 );
    post( 16, 4, height=5 );
    post( 11, 37, height=5 );
}

top();


