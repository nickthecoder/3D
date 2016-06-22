include <spider.scad>;

module legMotors( thickness=4 )
{
    w = 23;
    h = 12.5;
    l = 16.5;
    edge = 5;
    bar = 2;
    
    big = 10;
    top = 4;

    //translate([0,0,h*2+bar*2]) rotate([-90,0,0]) 
    difference( convexity=10 ) {
        union(convexity=10 ) {
            linear_extrude( thickness, convexity=10  ) {
                difference() {
                    translate( [-edge, -bar] ) square( [ w+ edge * 2, h*2 + bar * 2 ] );
                    square( [ w, h*2 ] );
                    
                    translate( [-2.5,h/2] ) hole();
                    translate( [-2.5,h/2*3] ) hole();
                    translate( [w+2.5,h/2] ) hole();
                    translate( [w+2.5,h/2*3] ) hole();
                    translate( [-2,h-2.5] ) square( [3,5]); // Slot for wires
                }
            }

            translate([-8,h*2,0]) cube( [ w+16, top, big ] );
        }
        
        translate( [w/2,h*2 + top + .1, big/2] ) rotate([90,0,0]) doubleAttachment();
    }

}

module switchHolder()
{

    module legHole() 
    {
        translate([0,10,0]) rotate([90,0,0]) cylinder( d=3, h=20 );
    }
    
    translate( [(w-switchX)/2,0,back] ) {
        difference() {
            cube( [switchX+edge*2,switchY+bar,switchZ] );
            translate( [edge,bar,-1] ) cube( [switchX, switchY+1, switchZ+2] );
            
            // Holes for the switch's pins.
            translate( [edge+switchX/2-5,0,switchZ/2] ) legHole();
            translate( [edge+switchX/2,0,switchZ/2] ) legHole();
            translate( [edge+switchX/2+5,0,switchZ/2] ) legHole();
        }
        
        // Thin hinge flap
        cube([hinge,switchY+bar+3,switchZ]);
        
        // Overhang, which will attach to the body
        translate( [0, bar+switchY+gap,-back] ) difference() {
            cube([overhang+switchX+edge*2,bar,switchZ+back]);

            // Screw holes to attach to the main body
            translate([switchX + edge*5/2 + overhang*2/3, bar+1, (switchZ+back)/2]) rotate([90,0,0]) cylinder( d=screwD, h=bar+2 );
            translate([switchX + edge*5/2 + overhang/3, bar+1, (switchZ+back)/2]) rotate([90,0,0]) cylinder( d=screwD, h=bar+2 );
        }

    }

    difference() {               
        // Backing plate
        cube([w+edge*2,switchY+bar,back]);

        translate([edge/2,switchY/2+bar,-1]) cylinder( d=screwD, h=back+2 );
        translate([w+edge/2+edge,switchY/2+bar,-1]) cylinder( d=screwD, h=back+2 );
    }
}

module shoulder()
{
    difference() {
        union() {
            linear_extrude( h,convexity=10 ) {
                difference() {
                    translate( [-edge,0] ) square( [w + edge*2, l+bar] );
                    square( [w,l] );
                }
            }
            translate( [-wing,0,0] ) cube( [wing,6,h] );
            translate( [w,0,0] ) cube( [wing,6,h] );
        }
        // Holes to attach the motor
        translate( [-wing/2,0,h/2] ) rotate([-90,0,0]) cylinder( d=screwD, h=6 );
        translate( [w+wing/2,0,h/2] ) rotate([-90,0,0]) cylinder( d=screwD, h=6 );

        // Holes to attach the switch holder
        translate( [-edge/2,l-switchY/2,h-6] ) cylinder( d=screwD, h=10 );
        translate( [w+edge/2,l-switchY/2,h-6] ) cylinder( d=screwD, h=10 );

        // Alternate Holes to attach the switch holder
        translate( [-edge/2,l-switchY/2-bar-gap,h-6] ) cylinder( d=screwD, h=10 );
        translate( [w+edge/2,l-switchY/2-bar-gap,h-6] ) cylinder( d=screwD, h=10 );
        
        // Slot for the motor's wires
        translate( [w,9.5,-1] ) cube( [edge,1.5,h/2+2.5] );
    }
    

}

module shoulderPieces()
{
    translate( [40,0,0] ) legMotors();
    shoulder();
    translate([0,-20,0]) switchHolder();
}

//shoulderPieces();
mirror( [1,0,0] ) shoulderPieces();

