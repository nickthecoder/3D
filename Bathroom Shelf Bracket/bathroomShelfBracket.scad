length=42;
depth=30;
thickness=15;
holeDiameter=5;
headDiameter=10;
slot=5;
angle=30;

module bracket()
{
	module hole() {
		hull() {
			cylinder( d=holeDiameter, h=70 );
			translate( [0,-slot,0] ) cylinder( d=holeDiameter, h=70 );
		}
		hull() {
			translate( [0,0,10] ) cylinder( d=headDiameter, h=70 );
			translate( [0,-slot,10] ) cylinder( d=headDiameter, h=70 );
		}
	}

	difference() {
		linear_extrude( thickness )
		difference() {
			square( [length,depth] );
			translate([length+3,-3]) scale([1,depth/length]) circle( length );
		}
		translate( [-5,depth-7,thickness/2] ) rotate( [0,0,angle] ) rotate( [0,90,0] )  hole();
	}
}

module step( l, d )
{
	translate( [-d, 0, 0] ) cube( [d+1,l,thickness] );
}


bracket();
step(10,8);
