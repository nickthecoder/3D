
module comb( teeth=10, width=5, depth=5, height=50, thickness=2 )
{
	linear_extrude( thickness ) {
		square( [width * 2 * teeth - width, height] );
		for ( i = [0:teeth-1] ) {
			translate( [i*width*2,-depth] ) square( [width, depth+1] );
		}
	}
}

comb();
