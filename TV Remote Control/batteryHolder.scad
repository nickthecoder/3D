d = 11.5; // Diameter of the cell
l = 44.5; // Length of the cell
thickness= 0.5; // Thickness of the main body
endThickness = 1; // Thickness of end parts, which may be thicker to give more stength.
outside = d + thickness; // Diameter of the case holding one cell
length = l + 6; // Length of the battery plus the spring connector, and fix connector.

module half()
{

	linear_extrude( length ) {
		difference() {
			union() {
				translate( [-outside/2,-outside/2] ) square( [outside, outside/2] );
				circle( d = outside );
			}
			circle( d = d );
			translate( [-outside/2, outside/6] ) square( [outside, outside] );
		}
	}
}

module batteryHolder()
{
	module post()
	{
		difference() {
			cylinder( d=3, h=height );
			#translate( [0,0,height - 3] ) cylinder( d=1, h=4 );
		}
	}

	height = d*0.9;

	translate( [0,0,outside/2] ) rotate( [90,0,0] ) {
		translate( [-outside/2,0,0] ) half();
		translate( [ outside/2,0,0] ) half();
		translate( [-outside, -outside/2, 0] ) cube( [outside *2, height, endThickness] );
		translate( [-outside, -outside/2, length] ) cube( [outside *2, height, endThickness] );
	}

	translate( [12.5,-1.5,0] ) post();
	translate( [-12.5,-1.5,0] ) post();;
}


batteryHolder();