include <ntc/label.scad>;
include <dovetail.scad>;

// Taking measurements from a photo. Ball is 7mm, hole is 8.3 to 8.7, track size is the same. scale is 12



// The number of unit squares which make up one panel.
across = 5;
down = 5;

// Thickness of the walls - make it a multiple of your extrusion size.
wall = 4.2;

// This controls the overall scale of the board.
ball_radius = 4; // WAS 3

// The radius of the holes into which the ball bearing fall.
hole_radius = ball_radius * 1.3; // Was * 1.2

// The size of one unit square
scale = hole_radius + wall * 2;

// The height of the maze walls - must be more than the ball bearing's radius.
height = ball_radius * 1.5;

// The floor, on which the ball bearings roll.
base_thickness = 1.0; // WAS 0.8

// Additional radius of the wall ends - can make the game harder!
bulge = 0;

// Used by support_hole
// The sizes should be compatable with support pegs, which raise the floor() from the base (where the ball rolls when fallen though a hole).
support_hole_radius = 2;
support_hole_height = 4;
support_hole_slack = 0;

// Amount of slack in the dovetails joint. Zero slack, and the dovetails won't fit together
// due to imperfections in printing.
dovetail_slack = 0.25;

// Roundedness of the dovetails
dovetail_r = 0.6;

// Number of dovetail pairs per side.
dovetail_n = 3;

// Gap at the entrance/exit paths
exit_slack = 0;

// Used by post()
ceiling_height = ball_radius * 2 + 1; // 1 mm of clearance

cellar_height = ball_radius * 2 + 1; // 1mm of clearance

EAST = 0;
NORTH = 90;
WEST = 180;
SOUTH = 270;

NE = 45;
NW = 135;
SW = 225;
SE = 315;

// A square, flat area that the ball rolls on.
module floor()
{
  translate( [0,0,- base_thickness] )
  cube( [ across * scale, down * scale, base_thickness ] );
}

// The walls of the maze.
// This is used for the internal walls, but will also be used for the edges of the tile.
module wall( x, y, angle = 0, length = 1, )
{
  module wall_end( x, y )
  {
    r = wall / 2 + bulge;
    translate( [ scale * x, scale * y, 0 ] )
    union() {
      cylinder( r = r, h = height-r);
      translate( [ 0, 0, height-r ] )
      sphere( r, center = true );
    }
  }

  r = wall / 2;

  translate( [ scale * x, scale * y, 0 ] )
  rotate( [0,0,angle] )
  translate( [ 0, -wall/2, 0 ] )
  union() {
    cube( [ length * scale, wall , height - r] );

    translate( [ 0, wall / 2, height  - r] )
    rotate( [ 0, 90, 0 ] )
    cylinder( r = r, h = length * scale );
  }
  

  wall_end( x, y );
  wall_end( x + length * cos( angle ), y + length * sin( angle ) );

}


// Higher than the wall - used to support the transparent lid.
// Must be higher than the diameter of the ball.
module post( x = 3, y = 3 )
{
  wall( x - 1, y - 1, NORTH );
  wall( x - 1, y, EAST );
  wall( x, y, SOUTH );
  wall( x, y - 1, WEST );

  translate( [ (x - 0.5) * scale, (y-0.5) * scale,  ] )
  union() {
    translate( [ 0,0,height / 2 ] )
    cube( [ scale, scale, height ] , center= true );
    cylinder( r = scale / 2.5, h = ceiling_height );
  }

}

// A hole cut through the floor() and the post().
// Used in conjuntion with a peg to raise the floor from the base.
module support_hole( x = 3, y = 3 )
{
  extra = 10;
  translate( [ (x-0.5) * scale, (y-0.5) * scale, -extra ] )
  cylinder( r = support_hole_radius, h = support_hole_height + extra );
}

// A cylinder cut thought the floor. The ball falls through these holes.
module hole( x, y )
{
  translate( [ (x-0.5) * scale, (y-0.5) * scale, -base_thickness / 2 ] )
  cylinder( r = hole_radius, h = base_thickness * 2, center = true );
}


module trap( x, y, l = 4, direction  = 0 )
{
    translate( [ (x-0.5) * scale, (y-0.5) * scale, -base_thickness / 2 ] )
    rotate( [0,0,direction] ) {
      translate( [ -scale / 2 + wall/2, - scale / 2 + wall/2, - base_thickness ] )
        cube( [ l * scale - wall, scale - wall, base_thickness * 3 ] );
    }
}


// A torus, the size of a "unit", and as thick as a wall.
// Cut in half, to go around holes (see dead_end())
// A quarter can also be used to curve 90 degree corners.
module ring()
{
  h = height - wall / 2;
  rotate_extrude(convexity = 10)
  translate([scale/2, 0])
  union() {
    translate( [0,h] )
    circle(r = wall / 2);
    translate( [-wall/2, -0.5] )
    square( [wall, h + 0.5] );
  }
}

// Half of a ring(), usually placed around a hole.
module dead_end( x, y, rotation = 0 )
{
  translate( [scale * (x - 0.5), scale * (y - 0.5) ,0 ] )
  rotate( [0,0, rotation] )
  difference() {
    ring();
    translate( [0, -scale, -2 * height ] )
    cube( [ scale,scale*2, height * 4 ] );
  }
}

module corner( x, y, rotation )
{
  translate( [scale * (x - 0.5), scale * (y - 0.5) ,0 ] )
  rotate( [0,0, rotation + 45] )
  intersection() {
    ring();
    translate( [0, -scale, -2 * height ] )
    cube( [ scale,scale,height * 4 ] );
  }
}




// Make a triangular prism all the way along the edge.
// Makes putting the pieces together easier, by avoiding printing problems, where the lowest few layers are often
// wider than they should be.
module chamfer_edge( l )
{
  translate( [ -5,0,5 ] )
  rotate( [ -90,45,0] )
  linear_extrude( l )
  square( [20,20] );
}


module chamfer_edges()
{
  chamfer_edge( scale * down );

  translate( [ scale * across, scale * down, 0 ] )
  rotate( [0,0,180] )
  chamfer_edge( scale * down );

  translate( [ 0, scale * down, 0 ] )
  rotate( [0,0,-90] )
  chamfer_edge( scale * across );

  translate( [ scale * across, 0, 0 ] )
  rotate( [0,0,90] )
  chamfer_edge( scale * across );
}

// Makes dovetails on all sides of the tile.
// The dovetails are designed so that square tiles can be joined together by any sides (i.e. rotated)
module dovetail_edges()
{
  $fn = 5;
  module dovetail_edge( l )
  {
    h = wall / 2;
    translate( [ -l/2, l/2 - wall/4,- base_thickness - 10] )
    linear_extrude( height = 100 )
    dovetail_joints( l, h, r = dovetail_r, gap = 3, n = dovetail_n, slack = dovetail_slack );
  }


  for ( a = [ 0,90,180,270 ] ) {
    translate( [ scale * across/2, scale * across/2, 0 ] )
    rotate( [0,0,a] )
    dovetail_edge( scale * across );
  }

  translate( [ wall/4, wall/4, -base_thickness - 1 ] )
  cube( [ across * scale - wall/2, down * scale - wall/2, 100 ] );
}


// Used during testing only, so I can see the sizes in comparison with the ball.
module ball( x, y )
{
  translate( [ (x-0.5) * scale, (y-0.5) * scale, ball_radius ] )
  sphere( r = ball_radius, center = true );
}




module exit( x, y, rotation )
{
  color( [0,1,0 ] )
  translate( [ (x - 0.5) * scale, (y-0.5) * scale, 0 ] )
  rotate( [0,0,rotation] )
  translate( [ scale/2 - wall/2, -(scale-wall) / 2, - base_thickness ] )
  cube( [ wall/2 - exit_slack, scale - wall, base_thickness ] );
}

module tile( walls = [], holes = [], corners = [], post=[3,3], exits, trap )
{
  module holes( holes )
  {
    for ( hole = holes ) {
      hole( hole[0], hole[1] );
    }
  }

  intersection() {
    difference() {
      union() {

        color( [ 1, 0, 0 ] )
        floor();

        if ( post != undef ) {
          color( [ 0, 0, 1 ] )
          post( post[0], post[1] );
        }

        color( [ 0, 0, 1 ] )
        for ( corner = corners ) {
          corner( corner[0], corner[1], corner[2] );
        }

        color( [ 0, 0, 1 ] )
        for ( hole = holes ) {
          if ( hole[2] != undef ) {
            dead_end( hole[0], hole[1], hole[2] );
          }
        }

        color( [ 0, 0, 1 ] )
        for ( wall = walls ) {
          if ( wall[3] == undef ) {
            wall( wall[0], wall[1], wall[2], 1 );
          } else {
            wall( wall[0], wall[1], wall[2], wall[3] );
          }
        }
      }
      union() {
        holes( holes );
        if ( post != undef ) {
          support_hole( post[0], post[1] );
        }
        chamfer_edges();

        if (trap) {
            trap( trap[0], trap[1], trap[2], trap[3] );
        }
      }

    }

    dovetail_edges();
  }


  for ( e = exits ) {
    exit( e[0], e[1], e[2] );
  }
}




// ball( 3, 1 );

