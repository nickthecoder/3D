/*
A simple ball with many holes, suitable for a Christmas tree.

Print Notes
===========

"Natural" (transparent-ish) PLA looks good when a fairy light is hidden inside.

Use a raft or brim, because there is too little touching the build plate otherwise.

I didn't use any supports, but some prints failed when nearing the top, when the angle of overhang gets shallow.

Consider adding a toy, decoration, sweets or another bauble inside during printing.

To Do
=====

Make it solid near the top to prevent print failures. (and print with a low fill percentge).

Make a version specilly designed to take a LED / fairy light.

Other shapes - elongated in the Y direction.

*/

default_thickness = 1;

module ball( d, hole, thickness=default_thickness )
{
	module holes( angle, n )
	{
		for ( dangle = [0:360/n:360] ) {
			echo (angle, dangle );

			// Adding "n", prevents there being a noticable seam at angle zero.
			rotate( [0,0,dangle+n] ) {
				rotate( [angle,0,0] ) {
					cylinder( d=hole, h=100, center=true );
				}
			}
		}
	}

	module ring( angle )
	{
		// The "power" determines how many holes near the poles compared to the equator.
		// A value of about 0.7 makes the holes evenly spaced.
		// Lower will bunch the holes together near the poles.
		holes( angle, floor(pow(angle/90, 0.7) * 30));
	}

	difference(convexity=100) {
		sphere( d=d );
		sphere( d=d - thickness );

		for ( angle = [40:10:90] ) {
			ring( angle );
		}
	}
}

module hook( thickness )
{
	difference() {
		sphere( 5 );
		//sphere( 5 - thickness );
		translate( [0,0,2] ) rotate( [0,90,0] ) cylinder( d=3, h=10, center=true );
	}
}

module ballAndHook( d, thickness = default_thickness )
{
	difference() {
		union() {
			ball( d, thickness );
			translate( [0,0,d/2] ) hook( thickness );
		}

		sphere( d=d - thickness );
	}

}

ballAndHook( 50, 3.5 );


