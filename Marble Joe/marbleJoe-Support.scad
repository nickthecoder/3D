include <marbles.scad>;

module support()
{
  x = ball_radius * 1.2;
  curve_height = cellar_height * 0.75;

  translate( [-x/2, -x/2,0] )
  cube( [x,x, cellar_height] );

  r = curve_height * 2;
  up = cellar_height * 0.85;

  difference() {
    translate( [-x*2, -x*2, 0] )
    cube( [x * 4, x * 4, curve_height] );

    for ( a = [0,90,180,270] ) {
      rotate( [0,0,a] )
      rotate( [90,0,0] )
      translate( [ r + x/2, up, 0] )
      cylinder( r = r, h = 20, center = true );
    }
  }


  cylinder( r = support_hole_radius - support_hole_slack, h = cellar_height + support_hole_height );

}

support();

