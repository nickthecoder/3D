/*
    Screws to the bottom of AngleClamp (see other scad file) for a magnetic base.
    
    Print Notes :
        Needs supports touching the print bed.
        
    Usage :
        Arrange the magnets with alternatly north, south pointing up.
        Glue in place using superglue.
        Cover with thin rubber sheet (an old bicycle inner tube should work), to stop it slipping
        against the object to which it is attached. Punch holes through the rubber for the screw.
        
        Screw to the angle-clamp using a couter sunk head screw. (Sorry, I haven't pre-countersunk the hole).
*/

use <ntc/tools.scad>;

baseD=31; // Should be the same (ish) as in AngleClamp.scad

thickness=7;
magnetD= 12.5;
magnetSpacing=13;
magnetThickness=1.6;
margin=3;
screwD=3;

// To overlap the edge of the 
overhang=1.5;
overhangH=2.1; // Make this the same (ish) as the height of the angle-clamp.

// Number of magnets - must be even to allow the screw to be in the center.
across=4;
down=2;

module magnetHoles(d)
{
    for ( x=[0:across-1] ) {
        for ( y=[0:down-1] ) {
            translate( [(x-across/2+0.5)*magnetSpacing, (y-down/2+0.5)*magnetSpacing] ) {
                circle( d=d );
            }
        }
    }
}

module shroud()
{
    difference() {
        // Main section
        //cylinder( d=baseD+overhang*2, h=thickness );
        linear_extrude( thickness ) {
            hull() {
                magnetHoles(d=magnetD+margin);
            }
        }
        
        // Holes for magnets
        translate( [0,0,thickness-magnetThickness] ) linear_extrude( magnetThickness+1, convexity=10 ) {
            magnetHoles(d=magnetD);
        }
        
        // Hole for screw
        cylinder( d=screwD, h=100, center=true );

        // Hole for angle clamp to fit into.
        if ( (overhangH > 0) && (overhang > 0) ) {
            translate( [0,0,-0.1] ) cylinder( d=baseD, h=overhangH );
        }
    }
}


shroud();

