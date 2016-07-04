include <marbles.scad>;

// Needs fixing. Its too wide, and the walls should be cropped to fit under the bottom of the floor.

// Creates a ramp which can be glued to the enderside of a starting tile

module ramp( l )
{
  rail = 1;
  angle = atan( cellar_height / ((l-1.5) * scale) ); // Angle of the slope.
  flat_slack = 0.1; // Cut a bit more away

  difference() {
    cube( [ scale * l, scale, cellar_height ] );

    union() {
      translate( [-1, -1, cellar_height - base_thickness - flat_slack ] )
      cube( [ scale + 2, scale + 2, base_thickness + 1] );

      translate( [ scale, rail, cellar_height ] )
      rotate( [ 0, angle, 0 ] )
      cube( [ scale * l * 2, scale - rail * 2, cellar_height * 2 ] );
    }
  }

}

ramp( 5 );

