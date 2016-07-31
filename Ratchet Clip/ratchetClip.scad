/*
    A clip with a ratchet mechanism.

    Inspired by : https://www.youmagine.com/designs/ratchets
    But this version doesn't need the nut and bolt.
    
    
    
    Print Notes
    
        "gap" should be set to twice your layer height
    
        If the printed piece doesn't move, first make sure that the print bed has been leveled correctly,
        then try increasing the "slack" and/or "gap" parameters. Increase gap if the layers are sticking to
        each other. Increase slack if the two pieces are merging into one another. Another option is to use
        inPlace=false, and print with supports.    
    
*/

DEFAULT_THICKNESS=3;
DEFAULT_HEFT=3;

/*
    size       The radius of the large quarter circle, the diameter of the small semi circle
    thickness  The thickness in the Z-axis
    heft       The thickness in the X/Y axis
    notches    The number of notches
    quality    How smooth the curves are
    play       How much shorter the arm is. Use a -ve number  if you want the arm longer
    slack      The gap in the X/Y axis to allow the two pieces to move freely.
               Will depend on the precesion of your printer
    gap        The gap in the Z axis to allow the two pieces to move freely.
               Set this to the layer height of the final print?
    inPlace    Print the two pieces in their final positions.
               If you cannot move the printed object, try inPlace=false, and print with supports.
*/
module ratchetClip( size=30, thickness=DEFAULT_THICKNESS, bulgeThickness=undef, heft=DEFAULT_HEFT, notches=undef, quality=60, tooth=2, play=0, slack=0.8, gap=0.4, bulge=undef, inPlace=true )
{
    big = bulge ? bulge : heft*3;
    notchCount=notches ? notches : size/3;
    bulgeHeight = bulgeThickness ? bulgeThickness : thickness*1.6;

    small = big*0.6;
    round = 20;
    axisHeight = bulgeHeight-gap*5;

    module shape()
    { 
        // Small semi circle
        translate([-size/2,0]) difference() {
            circle( d=size+heft, $fn=quality/2 );
            circle( d=size-heft, $fn=quality/2 );
            translate( [-size,0] ) square([size*2,size*2]);
            // arm will fit in here
            translate( [size/2-heft/4,0] ) circle( d=big+slack*2, $fn=round );
        }

        // Large quarter circle
        difference() {
            circle( d=size*2+heft, $fn=quality );
            circle( d=size*2-heft, $fn=quality );
            square([size*4,size*4]);
            translate( [-size*2,-size*4] ) square([size*4,size*4]);
        }
        
        // Rounded end
        translate( [0,size] ) rotate(90) circle( d=heft, $fn=10 );
    }
    
    module armShape()
    {
        difference() {
            hull() {
                translate([0,-play]) endShape();
                circle( d=heft, $fn=round );
            }
            circle( d=big+slack*2, $fn=round );
        }
    }
    
    module endShape()
    {
        hull() {
            translate( [0,size-heft/2] ) {
                polygon( [[heft/2,-tooth],[heft/2,0],[-heft/2,-tooth]] );
            }
        }
    }
    
    module notchShape()
    {
        hull() {
            translate( [0,size-heft/2] ) {
                polygon( [[heft/2,0],[-heft/2,0],[-heft/2,-tooth]] );
            }
        }
    }
    
    module arm()
    {
        // The long piece of the arm
        linear_extrude( thickness ) {
            armShape();
        }
        
        // The middle of the sandwich, which fits into the main ratchet piece.
        translate([ 0,0, bulgeHeight/3 ]) {
            linear_extrude( bulgeHeight/3 ) {
                hull() {
                    circle( d=big, $fn=round );
                    translate( [0,big*0.5] ) circle( d=heft, $fn=round );
                }
            }
        }

        // Axis for the arm
        translate([ 0,0,( bulgeHeight-axisHeight) /2 ]) {
            linear_extrude( axisHeight ) {
                circle( d=small-slack*2, $fn=round );
            }
        }
    }

    // The main piece
    linear_extrude( thickness, convexity=6 ) {
        shape();
        // Notches
        for ( i = [1:notchCount] ) {
            rotate( 90 * (i-0.3)/notchCount) notchShape();
        }
    }
    
    
    // The extra bulky part of the main piece into which the arm will fit.
    difference() {
    
        linear_extrude( bulgeHeight, convexity=4 ) {
            hull() {
                circle( d=big, $fn=round );
                translate([-big*0.21, -big*0.8]) circle( d=heft, $fn=round );
            }
        }
        
        // Remove the middle third of the sandwich
        translate( [0,0,bulgeHeight/3-gap] ) {
            linear_extrude( bulgeHeight/3 + gap*2 ) {
                circle( d=big+slack*2, $fn=round );
            }
        }
        
        // Remove the space for the arm's axis
        translate( [0,0,(bulgeHeight-axisHeight-gap*2)/2] ) {
            cylinder( d=small, h=axisHeight+gap*2, $fn=round );
        }

    }

    armPosition( inPlace, heft ) arm();
    
    // To aid development
    //%translate( [10,0,0] ) arm();
    //%rotate( [0,0,42] ) arm();
}

/*
    Position the arm (or pieces attached to the arm).
    If inPlace, then it the children are rotated, so that the arm is out of the way of the main piece.
    Otherwise the children are translated (and you will need to print with supports).
*/
module armPosition( inPlace, heft=3 )
{
    if (inPlace) {
        rotate( [0,0,-10] ) children();
    } else {
        translate( [heft*4, 0,0] ) children();
    }
}

/*
    Positions the children relative to the top of the arm.
*/
module armHolePosition( size, inPlace=true, offset=10, heft=DEFAULT_HEFT )
{
    armPosition( inPlace, heft=heft ) translate( [0,size-offset,0] ) children();
}

/*
    Positions the children around the edge of the main piece.
    
    size  : The size of the clip (the same as the value passed to ratchetClip).
    angle : The angle to rotate, should be between 90 and 360.
    heft  : The same as the value passed to ratchetClip.
*/
module holePosition( size, angle, heft=DEFAULT_HEFT )
{
    if (angle>180) {
        translate( [-size/2,0,0] ) rotate( [0,0,angle] ) translate( [size/2,0,0] ) children();
    } else {
        rotate( [0,0,angle] ) translate( [size,0,0] ) children();
    }
}

/*
    A hole suitable, useful for attaching the clip to something with a screw or nail.
    See "ratchetClip-30.scad" for examples of how to add screw holes to the clip.
*/
module hole( d=3, heft=DEFAULT_HEFT, thickness=DEFAULT_THICKNESS, flat=true, $fn=16 )
{
    big=d+heft*2;
    
    translate( [heft/2+d/2,0,0] ) linear_extrude( thickness ) {
        difference() {
            union() {
                if (flat) {
                    translate([-big/2,-big/2]) square( [big/2, big] );
                }
                circle( d=big );
            }
            circle( d=d );
        }
    }
}

module angledHole( d=3, heft=DEFAULT_HEFT, thickness=DEFAULT_THICKNESS, flat=true, $fn=16 )
{
    big=d+heft*2;

    translate([heft/2-heft,0,d/2+thickness]) rotate( [0,90,0] ) {
        linear_extrude( heft, convexity=4 ) difference() {
            union() {
                circle( d=big );
                if (flat) {
                    translate([0,-big/2]) square( [d/2+thickness, big] );
                }
            }

            circle( d=d );
        }
    }
}

/*
    Used during development to see inside the moving part, to make sure the gaps and slack were correct.
    Not used for the final product.
*/
module inspect(angle=0)
{
    intersection() {
        children();
        rotate([0,0,angle]) translate([-0.5,-50,0]) cube( [1,100,100] );
    }
}


