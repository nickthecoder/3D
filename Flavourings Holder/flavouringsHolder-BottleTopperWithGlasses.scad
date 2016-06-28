
module snap( d, x, height, taper=0 )
{
	difference() {
		linear_extrude( height, convexity=4 ) {
			hull() {
				translate( [0,-x,0] ) circle( d=d );
				translate( [0, x,0] ) circle( d=d );
				translate( [1.2, 1,0] ) circle( d=d+x );
				translate( [1.2, -1,0] ) circle( d=d+x );
			}
		}
		translate( [2*x,0,-1] ) cylinder( d1=d, d2=d+taper, h=height+2 );
	}
}

module shots()
{
	bottle = 31;
	glass = 35;
	flavour = 20;
	thickness = 2;

	away =  34;
	away2 = 28;
	height1 = 40;
	height2 = 30;
	height3 = 20;

	translate( [away,0,0] ) snap( glass, 3, height2,2 );
	rotate( [0,0,180] ) translate( [away,0,0] ) snap(glass,3, height2, 2);

	translate( [0,0,5] ) {
		rotate( [0,0,65] ) translate( [away2,0,0] ) snap(flavour,2, height3);
		rotate( [0,0,115] ) translate( [away2,0,0] ) snap(flavour,2, height3);
		rotate( [0,0,-65] ) translate( [away2,0,0] ) snap(flavour,2, height3);
		rotate( [0,0,-115] ) translate( [away2,0,0] ) snap(flavour,2, height3);
	}

	translate( [0,0,-5] ) difference() {
		cylinder( d=bottle + 10, h=height1 );
		translate( [0,0,-thickness] ) cylinder( d1=bottle, d2=bottle-2, h=height1 );
		//translate( [0,0,height1-1] ) cylinder( d=bottle-1,h=10 );
	}
}
//snap(20,2,20);
 shots();
