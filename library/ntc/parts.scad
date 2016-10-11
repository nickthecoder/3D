/*
    Various miscellaneous bits.
*/
use <ntc/tools.scad>;

CIRCUIT_PITCH = 2.5;
CIRCUIT_HOLE = 1.5;
SLACK=0.4;
THICKNESS=1.4;

module part_extrusion_help()
{
    echo( "Takes a solid 2D shape, and hollows then extrudes it." );
    echo( "Useful for making cases, where the main body of the case is extruded on its side" );
    echo( "and the ends are created using 'part_extrusionCap()'." );
    echo();
    echo( "Parameters:" );
    echo( "    height    : The height of the extrusion (the length of the case)" );
    echo( "    thickness : The thickness of the walls (default=1.4)" );
    echo( "    convexity : (see the built-in linear_extrude module)" );
    echo( "    center    : If true, then the extrusion is centered around z=0 (default is false)" );
    echo( "    axis      : The axis to extrude along. Either 'x', 'y' or 'z'. (default='z')" );
    echo( "Child Nodes   : The shape to hollow, and extrude" );
}


module part_extrusion( height, thickness=THICKNESS, convexity=4, center=false, axis="z", rounded=true, chamfer=false )
{
    module off( amount )
    {
        offset( r=rounded ? amount : undef, delta=rounded ? undef : amount, chamfer=chamfer ) children();
    }

    ntc_linear_extrude( height=height, center=center, convexity=convexity, axis=axis ) {
        difference() {
            children();
            off( -thickness ) children();
        }
    }
}

module part_extrusionCap_help()
{
    echo( "An end cap to go with part_extrusion." );
    echo( "You will need two mirror image copies." );
    echo();
    echo( "Parameters:" );
    echo( "    thickness : The thickness of the extruded walls - must be the same as passed to 'part_extrusion'." );
    echo( "    outside   : The height beyond the extruded walls (default=thickness)" );
    echo( "    inside    : The height within the extruded walls (default=thickness)" );
    echo( "    capThickness     : The thickness of the end cap (default=thickness)" );
    echo( "    outsideThickness : The thickness of outside walls (default=thickness)" );
    echo( "    insideThickness  : The thickness of the inside walls (default=thickness)" );
    echo( "    slack     : Size of the gap to ensure pieces fit together nicely (default=0.5)" );
    echo( "    convexity : As for the built-in 'linear_extrude'" );
}

module part_extrusionCap( thickness=THICKNESS, outside, inside, capThickness, outsideThickness=0, insideThickness, slack=SLACK, convexity=4, rounded=true, chamfer=false )
{
    module off( amount )
    {
        offset( r=rounded ? amount : undef, delta=rounded ? undef : amount, chamfer=chamfer ) children();
    }
    
    ot = outsideThickness==undef ? thickness : outsideThickness;
    it = insideThickness==undef ? thickness : insideThickness;
    out = outside==undef ? thickness : outside;
    in = inside==undef ? thickness * 2 : inside;
    top = capThickness==undef ? thickness : capThickness;

    outOffset = ot == 0 ? 0 : ot + slack;
    
    linear_extrude( top ) off( ot == 0 ? 0 : slack ) children();
    
    part_extrusion( top+out, convexity=convexity, thickness=ot ) {
        difference() {
            off( outOffset ) children();
            off( slack ) children();
        }
    }
    part_extrusion( top+in, convexity=convexity, thickness=it ) {
        difference() {
            off( -thickness-slack ) children();
            off( -thickness-slack-it ) children();
        }
    }
}

/*
    An extra bit for part_extrusion for visual appeal.
    This will only work well if the 2D child shape is symetric in both the X and Y axis.
*/
module part_extrusionCapExtra( outsideThickness=0, scale=0.25, rounded=true, chamfer=false )
{
    module off( amount )
    {
        offset( r=rounded ? amount : undef, delta=rounded ? undef : amount, chamfer=chamfer ) children();
    }
    
    offset = outsideThickness == 0 ? 0 : outsideThickness + SLACK;
    scale( [1,1,scale])
            
    intersection() {
        ntc_rotate_extrude( axis="y" ) {
            intersection() {
                translate([0,-500]) square( 1000 );
                off( offset ) children();
            }
        }
        ntc_rotate_extrude( axis="x" ) {
            intersection() {
                translate([0,-500]) square( 1000 );
                rotate(90) off( offset ) children();
            }
        }
        ntc_cube( 1000, align=[0.5,0.5,1] );
    }
}

module part_ledHoles_help()
{
    echo( "Holes for LED's pins to poke through." );
    echo( "Parameters:" );
    echo( "    length : The length of the holes (default=10)" );
}

module part_ledHoles( length=10 )
{
    ntc_arrange_mirror([0,1,0]) translate([0, CIRCUIT_PITCH/2, 0]) {
        cube( [CIRCUIT_HOLE, CIRCUIT_HOLE, length], center=true );
    }
}

module part_ledSeat_help()
{
    echo( "An indentation for the led to sit in, and holes for its pins to poke through." );
    echo( "Parameters:" );
    echo( "    length : The length of the holes (default=10)" );
}

module part_ledSeat( size=5, depth=1, length=10, slack=SLACK )
{
    translate([0,0,-depth]) cylinder( d=size+slack*2, h=depth+0.01 );
    part_ledHoles( length );
}


module test( rounded=true )
{
    outsideThickness = 0;
    length = 30;
    
    module shape() {
        difference() {
            hull() ntc_arrange_mirror( [1,1] ) translate( [10,16] ) circle( d=6 );
            translate([-10,0]) circle( d=8 );
        }
        //square( [20,32], center=true );
    }

    part_extrusionCap( outsideThickness=outsideThickness, rounded=rounded ) shape();
    //part_extrusionCapExtra( outsideThickness=outsideThickness, rounded=rounded ) shape();
    
    translate([0,0,2]) part_extrusion( length, rounded=rounded ) shape();
}

// test();



