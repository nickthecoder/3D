/*
    I want to add a base to a bare a small speakers, and add a wifi & amplifier board in the base,
    complete with battery, battery charger (with USB socket), boost circuit and battery protection
    circuit.
    
    These are all modules bought from china.
    
    Print Notes
        Ensure that the thickness and grillWidth are multiples of your printer's nozzle size.
        Make grillThickness a multiple of Layer Height.
*/

use <ntc/tools.scad>;
use <ntc/countersink.scad>;


// Defines the shape of the base. These are coordinates of the front right and rear left corners
// Well, actually, the center of the rounding circle for each corner.
roundFront=7;
roundBack=7;

backWidth = 73;
frontWidth = 91;
depth = 91;

back=[-backWidth/2+roundBack,depth/2-roundBack];
front=[frontWidth/2-roundFront,-depth/2+roundFront];

// Width of the struts, which form the base.
strutW = 6;
thickness=1.2;
grillThickness=0.9;
grillWidth=0.8;
height=22;
extra=12;

slack=0.5;

barW=3;

// Distance between the post holes on the wifi/amp board.
ampSpaceX = 44;
ampSpaceY = 76;

postHeight = thickness+4;
postD = 5;
screwD = 2;

chargeW = 16;
chargeD = 22;
chargeH = 12;

module baseShape( extra=0 )
{
    hull() {
        mirror( [1,0] ) 
        translate( front ) circle( r=roundFront + extra );
        translate( front ) circle( r=roundFront + extra );

        mirror( [1,0] )
        translate( back ) circle( r=roundBack + extra );
        translate( back ) circle( r=roundBack + extra );        
    }
}


module edge( width, thickness, slack=0 )
{
    if ( width > 0 ) {
        linear_extrude( thickness, convexity=4 ) difference() {
            baseShape( width );
            baseShape();
        }
    } else {
        linear_extrude( thickness, convexity=4 ) difference() {
            baseShape( -slack );
            baseShape( width );
        }
    }
}

module grill(width, spacing, size)
{
    translate( [-size/2,-size/2] ) {
        for ( i=[0:size/spacing] ) {
            translate( [i*spacing,0] ) square( [width, size] );
            translate( [0,i*spacing] )square( [size, width] );
        }
    }
}


module flip()
{
    translate( [0,0,height+thickness+slack] ) rotate( [0,180,0] ) children();
}


module connectionHoles()
{
    translate( [20,100, 13] ) rotate( [90,0,0] ) cylinder( d=6, h=100 );
}

module speakerHoles()
{
    translate( [00,100, 13] ) rotate( [90,0,0] ) cylinder( d=4, h=100 );
}

module base()
{
    // The floor around the grill
    edge( -strutW, thickness );
        
    // The sides
    difference() {
        edge( thickness, height+thickness+extra );
        translate([-100,front[1]-roundFront-thickness,height+thickness+slack]) cube( [200,roundFront+thickness,extra+1] );
        translate([-100,front[1],height+thickness+slack]) rotate([10,0,0] ) cube( [200,400,extra+1] );

        flip() speakerHoles();
    }

    // Grill on the bottom
    linear_extrude( grillThickness, convextity=20 ) {
        intersection() {
            baseShape();
            rotate( 45 ) grill( grillWidth, grillWidth*4, 200);
        }
    }
    
    // Places to stick on padded feet
    ntc_arrange_mirror() {
        translate( [32,-34,0] ) cylinder( d=20, h=grillThickness );
    }
    ntc_arrange_mirror() {
        translate( [23,36,0] ) cylinder( d=20, h=grillThickness );
    }
}

module post()
{
    linear_extrude( postHeight, convexity=4 ) {
        difference() {
            circle( d=postD );
            circle( d=screwD );
        }
    }
}

module ampBase()
{
    difference() {
        mirror([1,0,0]) base();
        flip() connectionHoles();
    }
    
    // Posts
    ntc_arrange_mirror([1,1,0]) {
        translate( [ampSpaceX/2,ampSpaceY/2,0] ) post(); 
    }

    
    // Supports running front to back
    ntc_arrange_mirror() {
        translate( [ampSpaceX/2-strutW/2,-depth/2+2,0] ) cube( [ strutW, depth-6, 2 ] );
    }

}

module battery()
{
    translate([0,0,7]) difference() {
        cube( [60,22,14], center=true );
        translate( [0,0,4] ) rotate( [0,90,0] ) cylinder( d=20, h=70, center=true );
    }
}

module boost()
{
    ntc_arrange_mirror( [1,1,0] ) {
        translate( [15, 7.5, 0 ] ) post();
    }
    ntc_cube( [36,20,2] );
    
}

module buttonBottom()
{
    h=10;
    
    // floor
    #ntc_cube( [23,16,2] );
    
    // Posts
    ntc_arrange_mirror() {
        translate( [9,0,0] ) post();
    }
    
    // Box for switch to sit in.
    difference() {
        ntc_cube( [12,14,h] );
        translate( [0,0,h-4] ) ntc_cube( [8.5,8.5,h] );
        translate( [0,-7,2] ) ntc_cube( [5,7,h] );
    }
}

module powerBase()
{
    difference() {
        base();
        connectionHoles();
        
        // Button hole
        translate( [0,-45,10] )  rotate( [90,0,0] ) cylinder( d=7, h=10, center=true );
        
        // USB Charge hole
        translate( [-20,45,7] ) ntc_cube([9,20,5]);
    }
        
    translate( [ 22, -6,0] ) rotate( [0,0,95] ) battery();
    translate( [-20,-14,0] ) rotate( [0,0,90] ) boost();
    translate( [  0,-37,0] ) buttonBottom();
    translate( [-20,45,0] ) rotate( [0,0,180] ) chargerSled();
}

module chargerSled(w=20,l=25,h=15)
{    
    ntc_arrange_mirror() {
        translate( [-w/2 - 2,0,0] )
        difference() {
            cube( [4,2,h] );
            translate( [2,-1,h-4] ) cube( [2, 4, 2] );
        }
        
        // back resting posts
        translate( [-6,l-2,0] ) cube( [3,4,h-4] );
    }
    
    // Floor
    translate( [-w/2-1,0,0] ) cube( [w+2,l+2,2] );
    
    // 90° strengthening
    #translate( [0,l-3,0] ) ntc_cube( [2,8,8] );
    
    // Stop end
    translate( [-4, l, 0] ) cube( [8,2,h] );

    // Overhang
    translate( [-4, l-1, h-2] ) cube( [8,3,2] );
}

module cover()
{
    difference() {
        // Edge
        edge( -barW, height, slack );

        // Holes for speaker wires.
        hull() {
            speakerHoles();
            translate([0,0,10]) speakerHoles();
        }
        
        // Holes for output wires connections.
        hull() {
            connectionHoles();
            translate([0,0,10]) connectionHoles();
        }

    }
    
    // grill surround
    edge( -strutW, thickness, slack );

    // Grill on the bottom
    linear_extrude( grillThickness, convextity=20 ) {
        //intersection() {
            baseShape(-slack);
            //rotate( 45 ) grill( 1, 4, 200);
        //}
    }

}

module powerCover()
{
    mirror( [1,0,0] ) difference() {
        cover();
        
        // Power button
        translate( [0,-45,thickness+4] ) ntc_cube( [20,30,30] );

        // USB charger
        translate( [-30,40,6] ) ntc_cube( [44,20,20] );
    }
}

module connection()
{
    l=74;
    h=14;
    w=14;

    screw=[3,40,6];
    recess=7;
    
    difference() {
        translate([-w/2,-l/2]) cube([w,l,h]);

        // Screw holes
        ntc_arrange_circle( 2,1,true ) ntc_arrange_grid( 1,0,3,24 ) {
            translate( [-4,-30,-3] ) rotate( [0,45,0] ) ntc_countersink_hole( screw=screw, recess=recess );
        }
        
        // Hole for power lead
        translate( [0,0,h/2] ) rotate( [0,90,0] ) cylinder( d=5, h=20, center=true );
    }
    
}

powerBase();

//translate( [100,0,0] ) chargerSled();


//%flip() cover();

//translate( [100,0,0] ) cover();

//powerBase();

