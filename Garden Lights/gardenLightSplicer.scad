/*
    For my dual-mode (ambiant solar / bright wired) garden lights, I needed to splice into the 12V cable
    running around my garden (damaging it as little as possible).
    
    The cable is quite thick, and the wires to the LEDs is thin.
    
    Each piece needs three screws. One holds the two halves together. The other two to pierce the
    cable's plastic, touching the conductor, and simultaneously clamping the thin wires to the LEDs.
    
Print Notes
===========
I printed these with PLA, but this may degrade in an outside environment, ABS would be a better choice.
Time will tell.

*/

length=7; // The length of the body, which is fairly arbitrary
d=3.5; // The diameter of holes, through which the main wires pass
thickness=2; // Thickness of plastic around the main wires
gap=3.8; // Distance between the holes for the main wires
mainHole=1.5; // Diameter of the hole to join the two halves together
head=5; // Diameter allowed for the connecting screws
hole=1.8; // Diameter of the holes for the connecting screws
headHeight=2.5; // Height of the "turret", a little larger than the connecting screw's head height
recess=2.2;
wire=1.5; // Width of the slot for the small conneting wires
turretThickness=2;

sides=12; // Number of faces for each of the holes.

module splicer()
{
	// Positions the children into the two positions of the connection "turrets".
	module connectionPositions()
	{
		translate( [(gap+d)/2,-d/2,length/2] ) rotate( [90,0,0] )
		children();

		translate( [-(gap+d)/2,-d/2,length/2] ) rotate( [90,0,0] )
		children();
	}

	// The positive part of the connection turret
	module connections()
	{
		connectionPositions() cylinder( d=head+turretThickness,h=thickness+headHeight,$fn=sides );
	}

	// The negative part of the connection turret
	module connectionHoles()
	{
		connectionPositions() {
			translate([0,0,thickness]) cylinder( d=head,h=headHeight+0.1, $fn=sides );
			translate([0,0,-d-thickness/2]) cylinder( d=hole, h=10, $fn=sides);
			translate( [-wire/2,0,thickness] ) cube( [wire,10,10] );
		}
	}

	module main() {

		linear_extrude( length, convexity=10) {
			difference() {
				hull(convexity=10) {
					translate([ (d + gap)/2,0]) circle( d=d + thickness*2, $fn=sides );
					translate([-(d + gap)/2,0]) circle( d=d + thickness*2, $fn=sides );
				}

				union(convexity=10) {
					translate([ (d + gap)/2,0]) circle( d=d, $fn=sides );
					translate([-(d + gap)/2,0]) circle( d=d, $fn=sides );
				}
			}
		}
	}

	difference() {
		union() {
			main();
			connections();
		}

		// Hole to screw the two halves together
		translate( [0,d/2+thickness+0.1,length/2] ) rotate([90,0,0]) cylinder( d=mainHole, h=d+thickness*2+0.2, $fn=sides );
		// Larger hole on the head side (so the screw only bites one half).
		translate( [0,d/2+thickness-0.01,length/2] ) rotate([90,0,0]) cylinder( d=mainHole+1, h=(d+thickness*2)/2, $fn=sides );
		// Recess for the screw head.
		translate( [0,d/2+thickness+0.1,length/2] ) rotate([90,0,0]) cylinder( d=head, h=recess, $fn=sides );

		connectionHoles();
	}
}

// Cuts the model in two pieces, discarding the bottom half.
module topHalf() {

	rotate( [-90,0,0] )
	difference() {
		children();
		translate( [-10,0,-1] ) cube(20);
	}
}

// Cuts the model in two pieces, discarding the top half.
module bottomHalf() {
	rotate( [90,0,0] )
	difference() {
		children();
		translate( [-10,-20,-1] ) cube(20);
	}
}

// Used to visualise the size of the screw. Will never be printed!
// #translate( [8,4,3/2+thickness] ) screw();

module screw() {
	translate( [0,0,-6] ) cylinder( d=2.2, h=6 );
	cylinder( d=4.2, h=1.8 );
}

module bothHalves()
{
    translate([0,1,0]) topHalf() splicer();
    bottomHalf() splicer();
}


// Uncomment for a smaller version (I have two cable sizes in my garden).
//d=2.5;
//thickness=2.5;


// Uncomment to print  batch of 12
//include <ntc/ntc_tools.scad>;
//ntc_arrange_grid( 4,20, 3, 20 )

bothHalves();

