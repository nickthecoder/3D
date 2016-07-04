include <marbles.scad>;

module post()
{

  l = ball_radius * 2.1;
  r = l * 0.8;

  difference() {

    translate( [-l/2, -l/2,0] )
    cube( [ l, l, cellar_height ] );


    
    for ( a = [0,90,180,270] ) {
      rotate( [0,0,a] )

      rotate( [90,0,0] )
      translate( [ l * 1.1, cellar_height / 2, 0] )
      cylinder( r = r, h = 20, center = true );
    }
  }
}

post();

