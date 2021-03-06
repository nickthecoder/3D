/*
    A knife handle for use with disposable razor blade. These blades can be easily found in 
    DIY stores, and pound shops as well as supermarkets.
    It requires the classic shaped blades with a hole in the middle. I found them in a pound shop.

	The blade is held in place by a wedge.
	
	Print Notes.
	    You can use a low infill (I use 10%)
	    The back of the knife tends to lift off of the bed, so either use a brim, or use the
	    "splat" module to help it adhere.
*/

length = 120; // Length of the knife
width = 23; // Must be a little larger than the width of the blade.
thickness = 10; // Thickness of the knife
extraThickness = 2; // Taper the top front of the knife.

hole = 6; // Diameter of the hole/wedge which holds the blade.
taper = 1; // Amount of taper on the wedge
slack = 0.5; // How much smaller the wedge is to the hole that it fits into.

module body()
{
	foo = 3; // Radius of the extra spheres for the wider top. (For asthetics only)
	bar = extraThickness * width/thickness/2 + width / 2; // Z offset for the extra spheres.
	difference() {
		translate([-5,0,0]) scale( [1,1,thickness/width] ) hull() {
			translate( [7,0,0] ) sphere( d=width ); // Front
			translate( [length - width,0,0] ) sphere( d=width ); // Back
			translate( [-10+foo, width/2 - foo, bar-foo] ) sphere( r=foo ); // Wider top
			translate( [-10+foo, width/2 - foo,-bar+foo] ) sphere( r=foo ); // Wider top
		}
	}
}

module bladeHole( thickness=1.5 )
{
	height=20;
	width=62;
	translate([-width/2,-height/2,-thickness/2]) linear_extrude( thickness ) {
		polygon( [[0,0],[62,0],[width-15,height],[15,height]] );
	}
}

module knife()
{

	difference() {
		body( length, width, thickness, extraThickness );
		bladeHole(); // gap for blade to fit in.
		translate( [0,0,-thickness] ) cylinder( d1=hole+slack+taper, d2=hole+slack-taper, h=thickness*2 );
	}
}

module wedge(void=true)
{
	difference() {
		intersection() {
			body( length, width, thickness, extraThickness );
			translate( [0,0,-thickness] ) cylinder( d1=hole+taper, d2=hole-taper, h=thickness*2 );
		}
		if (void) {
		    // Create a tiny void, which will force the slicer to make it more solid!
		    #translate( [0,0,-width/4+2] ) cylinder( d=0.4, h=20+width/2-4 ); 
	    }
	}
}

/*
    A bodge to held the back of the knife adhere to the print bed.
*/
module splat(d=15, h=0.3 )
{
    translate([length-27,0,-11.43]) cylinder( d=d, h=h );
}

// Rotate the knife, so that the top of the knife is on the build plate.
rotate( [-90,0,0] ) knife();

// A little bit of a bodge to allow the wedge to be printed at the same time as the knife,
// and to make one edge of the wedge to be level with the build platform.
// If you change 'width', 'thickness' or 'extraThicknes', then the rotation and translation will need tweaking.
rotate( [6,0,0] ) translate( [-20,0,-width/4-0.5] ) wedge();

splat();


