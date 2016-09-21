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
height=22;
sunken=2; // I stick the speaker to the "cover" with double sided tape, so I want the cover sunken slightly.

back=[-backWidth/2+roundBack,depth/2-roundBack];
front=[frontWidth/2-roundFront,-depth/2+roundFront];

// Width of the struts, which form the base.
strutW = 6;
thickness=1.2;
grillThickness=0.9;
grillWidth=0.8;
floorThickness=1.2;
extra=12;

slack=0.5;

barW=3;

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
        edge( thickness, height+thickness+extra+sunken );
        translate([-100, front[1]-roundFront-thickness, height+thickness+slack+sunken]) cube( [200,roundFront+thickness,extra+1] );
        translate([-100, front[1], height+thickness+slack+sunken]) rotate([10,0,0] ) cube( [200,400,extra+1] );

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

module battery( l=30 )
{
    translate([0,0,7]) difference() {
        cube( [l,22,14], center=true );
        translate( [0,0,4] ) rotate( [0,90,0] ) cylinder( d=20, h=l+2, center=true );
    }
    %translate( [0,0,11] ) rotate( [0,90,0] ) cylinder( d=20, h=65, center=true );
}

module boost()
{
    ntc_arrange_mirror( [1,1,0] ) {
        translate( [15, 7.5, 0 ] ) post();
    }
    ntc_cube( [36,20,floorThickness] );
}


module monoModule()
{
    ntc_arrange_mirror( [1,1,0] ) {
        translate( [20-2.2, 15-2.2, 0 ] ) post();
    }
    ntc_cube( [40,30,floorThickness] );
    
}

module buttonBottom()
{
    h=10;
    
    // floor
    ntc_cube( [23,16,2] );
    
    // Posts
    ntc_arrange_mirror() {
        translate( [9,0,0] ) post();
    }
    
    // Box for switch to sit in.
    difference() {
        ntc_cube( [12,14,h] );
        translate( [0,0,h-4] ) ntc_cube( [8.5,9,h] );
        translate( [0,-7,2] ) ntc_cube( [5,7,h] );
    }
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
    translate( [-w/2-1,0,0] ) cube( [w+2,l+2, floorThickness] );
    
    // 90° strengthening
    translate( [0,l-3,0] ) ntc_cube( [2,8,8] );
    
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
            translate([0,0,-4]) speakerHoles();
            translate([0,0,10]) speakerHoles();
        }
        
        // Holes for output wires connections.
        hull() {
            translate([0,0,-4]) connectionHoles();
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

/*
    Joins the two speakers via the mounting screws on the back of each speaker
*/
module join()
{
    dist = 37; // Distace of the screw hole from the mid line
    height=13;
    thickness= 4;
    extra=20;

    angle = 6;
        
    apart = 4; // Gap between the speaker

    ntc_arrange_mirror() {   
        difference() {
            translate( [-1,0,0] ) rotate( [0,0,-angle] ) cube( [dist + extra, thickness, height] );
            translate( [dist,0,height/2] ) rotate( [90,0,0] ) cylinder( d=6, h=20, center=true );
        }
    }
    translate( [-apart/2,0,0] ) cube( [apart, 40,height] );

}

module wireTidy( height=30, thickness=4 )
{
    difference() {
        linear_extrude( height ) {
            hull() {
                ntc_arrange_mirror() translate([5,0,0]) circle( d=thickness );
            }
        }
        translate( [0,0,height/2] ) rotate([-90,0,0]) cylinder( d=6,h=100, center=true );
    }
}


module washer( d1=7, d2=4, h=2 )
{
    linear_extrude( h, convexity=4 ) {
        difference() {
            circle( d=d1 );
            circle( d=d2 );
        }
    }
}


module cableTie( d, elongate=0, width=7, heft=2, forScrew=8, screw=2 )
{
    gap=d/3;
    
    difference() {
        linear_extrude( width, convexity=4 ) {
            difference() {
                translate( [-d/2 - heft, -d/2 -heft] ) square( [d + elongate + heft + forScrew, d+heft*2] );
                hull() {
                    circle( d=d );
                    translate( [elongate,0] ) circle( d=d );
                }
                // Gap to squeeze
                square( [100,gap] );
            }
        }
        
        // Screw hole
        translate( [d/2+elongate+forScrew/2, 0, width/2] ) rotate([90,0,0]) cylinder( d=screw, h=100, center=true );
        translate( [d/2+elongate+forScrew/2, 0, width/2] ) rotate([-90,0,0]) cylinder( d=screw+2, h=100 );
    }    
}

