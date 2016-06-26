use <ntc/chamfer.scad>;

// ======= customisable values ======

radius = 9;
thickness = 2.5;       // Thickness of the main body 
cover_thickness = 2.2; // Thickness of the cover
height = 40;           // Height of the maze (not including the base).
groove = 2.5;          // Width of the 'v' shaped groove.
steps_around = 12;     // How many steps in a complete circle
step_up = 6;           // Length of  vertical path.

wiggle = 0.65;         // Difference in radius of the maze part, and the inside of the cover.
slack = 1.0;           // How much smaller the pin is compared with the grooves it follows.
gap = 1;               // Difference between height of maze part, and the inside of the cover.


base_height = 9;
base_roundedness = 3;  // Radius of the rounded hexagon for the base and the cover.
base_radius = radius + cover_thickness + wiggle; // + wiggle + cover_thickness;

cylinder_quality = 50; // Number of faces for the main body's cylinder (and the cover)

initial_depth=0.8; // The depth of the initial "carved" into the base of the base.
initial_font="Gentium Book Basic";

// ======= end of customisable values ======



// Constants used while defining the routes within the maze.
UP=0;
DOWN=1;
LEFT=2;
RIGHT=3;

module ring(  )
{
    translate( [ 0,0, - sqrt( 2 ) * groove / 2] )
    rotate_extrude(convexity = 10)
    translate( [ radius, 0 ] )
    rotate( 45 )
    square( [ groove,groove ] );
}

module pyramid( l ) 
{
    polyhedron(
        points=[ [l,l,0],[l,-l,0],[-l,-l,0],[-l,l,0], [0,0,l]  ],
         faces=[ [0,1,4],[1,2,4],[2,3,4],[3,0,4], [1,0,3],[2,1,3] ]
     );
}

module end( x, y )
{
    translate( [ 0, 0, y * step_up ] )
    rotate( [0,0, 360 / steps_around * x ] )
    translate( [ radius, 0, 0 ] )
    rotate( [ 0, -90, 0 ] )
    pyramid( sqrt( 2 ) / 2 * groove );
}

module segment( angle )
{
    R = radius * 2; // arbitarary larger than the radius
    intersection() {
        ring();

        linear_extrude( height=groove * 2, center = true )
        polygon([
                [0,0],
                [R, 0],
                [R * cos(angle/4), R * sin(angle/4)],
                [R * cos(angle/2), R * sin(angle/2)],
                [R * cos(angle * 3/4), R * sin(angle * 3/4)],
                [R * cos(angle), R * sin(angle)]
        ]);
    }
}

module around( x, y, l = 1 )
{

  end( x, y );
  translate( [ 0, 0, y * step_up ] )
  rotate( [0,0, 360 / steps_around * x ] )
  segment( 360 / steps_around * l );
  end( x + l, y );

}


module test_around( x, y, l )
{
  translate( [ 0, 0, y * step_up ] )
  rotate( [0,0, 360 / steps_around * x ] )
  for ( i = [1:l] ) {
    rotate( [0,0, (i-0.5) / steps_around * 360 ] )

    translate( [ 0, -radius, 0 ] )
    cube( [ radius / steps_around * 8, groove,groove ], center=true );
  }
}
    

module up( x, y, l=1 )
{
  end( x, y );
  translate( [ 0, 0, y * step_up ] )
  rotate( [0,0, 360 / steps_around * x ] )
  linear_extrude( height = l * step_up ) {
      translate( [ radius, 0 ] )
      rotate( 45 )

      square( [ groove, groove ], center = true );
  }
  end( x, y + l );
}


module test_up( x, y, l )
{
  translate( [0, 0, y * step_up ] )
  rotate( [0, 0, 360 / steps_around * x ] )
  translate( [ 0, -radius, l * step_up/2 ] )
  cube( [ groove, groove, (l+0.5) * step_up ], center=true );
}


module rounded_hex( r, h, round )
{
    hull() {
        linear_extrude( height = h ) {
            for ( n = [ 0 : 5 ] ) {
                rotate( n * 60 )
                translate( [ r - round, 0 ] )
                circle( r = round );
            }
        }
    }
}

module chamfers()
{
  // The width of the cover used by the chamfers.
  // this is a bit of a bodge and not quite acurate, but is good enough for the chamfer.
  w = base_radius * 2 - 2;

  // Chamfer the stright edges
  for ( a = [ 0, 120, 240 ] ) {
    rotate( [0,0,a] )
    translate( [-w/2,-w/2,0] )
    chamfer_cube( [w,w, height + thickness + gap], all=false, bottom=true, edge2=false, edge4=false );
  }

  // Chamfer the hex corners
  chamfer_cylinder( r=base_radius );

}

module cover()
{

    difference() {
        rounded_hex( r = base_radius, h = height + thickness + gap, round = base_roundedness );

        union() {
          // Cut the hole in the tube
              translate( [ 0,0, thickness ] )
              cylinder( r = radius + wiggle, h = height + gap + thickness, $fn = cylinder_quality );

          // Chamfer the bottom
          chamfers();
        }
    }

    // The pin which follows the maze's grooves
    translate( [-radius,0, height + thickness - step_up/2 ] )
        rotate( [ 0,90,0 ] )
        pyramid( groove - slack * 1.5 );

}

module body()
{
  difference() {
    union() {
      translate( [0,0, -base_height ] )
      rounded_hex( r = base_radius, h = base_height, round = base_roundedness );
      cylinder( r = radius, h = height, $fn = cylinder_quality );
    }
    union() {
      translate( [0,0, thickness - base_height] )
      cylinder( r = radius - thickness, h  = height + base_height, $fn = cylinder_quality );

    }
  }
}

module line( x, y, direction, length )
{
  if ( length == undef ) {
    line( x, y, direction, 1 );
  } else {

      if ( direction == UP ) {
        up( x, y, length );
      } else if ( direction == DOWN ) {
        up( x, y-length, length );

      } else if ( direction == RIGHT ) {
        around( x, y, length );
      } else if ( direction == LEFT ) {
        around( x-length, y, length );
      }
  }
}


module test_line( x, y, direction, length )
{
  if ( length == undef ) {
    test_line( x, y, direction, 1 );

  } else {

      if ( direction == UP ) {
        test_up( x, y, length );
      } else if ( direction == DOWN ) {
        test_up( x, y-length, length );

      } else if ( direction == RIGHT ) {
        test_around( x, y, length );
      } else if ( direction == LEFT ) {
        test_around( x-length, y, length );
      }
  }
}

module maze( solution, others, test=false, initial )
{
  render() {
    difference() {
      body();
      union() {
        for ( line = solution ) {
          line( line[0], line[1], line[2], line[3] );
        }
        for ( line = others ) {
          line( line[0], line[1], line[2], line[3] );
        }

        translate( [0,0, -base_height ] ) chamfers();

        if (initial) {
            translate( [0,0,-base_height] ) mirror( [0,1,0] ) linear_extrude( initial_depth ) text( initial, halign="center", valign="center", size=14, font=initial_font);          
        }
      }
    }
  }
}

module test_maze( solution, others )
{
  color( [0,0,0] )
  cylinder( r = radius, h = height );

  color( [0,1,0] )
  for ( line = solution ) {
    test_line( line[0], line[1], line[2], line[3] );
  }

  color( [0.85,0,0] )
  for ( line = others ) {
    test_line( line[0], line[1], line[2], line[3] );
  }
}



