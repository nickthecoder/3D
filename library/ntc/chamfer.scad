/*
  Chamfers the bottom face face of a cylinder (with the cylinder's bottom face centered on the origin).
  Use "difference" to create the chamfer with your cylinder.
*/
module chamfer_cylinder( r, inset=1, angle=45 )
{
  x = inset;
  y = inset * tan( angle );
  rotate_extrude()
  translate( [-r,0] )
  polygon( [ [-1,-1], [x,-1], [x,0], [0,y], [-1,y] ] );
}

module chamfer_hole( r, inset=1, extra=true )
{
  more = 0.3;
  if (extra) {
    translate( [0,0,-more*2] ) chamfer_hole( r+more, inset+more, extra=false );
  } else {
    cylinder( r1 = r + inset, r2 = r - inset, h = inset * 2 );
  }
}

module chamfer_squareHole( x, y, inset=1, extra=true )
{
    more=0.3;
    scale = y/x;
    bodge = sqrt( 2 );
    
    translate([0,0,-0.001]) scale( [1,scale,1] ) rotate([0,0,45]) cylinder( d2=bodge*x, d1=bodge* (x + inset*2), h=inset*bodge, $fn=4 );
}

module chamfer_edge( l, inset = 1, angle = 45, extra=true )
{
  x = inset;
  y = inset * tan( angle );
  plus = extra ? 2 : 0;

  translate( [0,0, - plus / 2] )
  linear_extrude( l + plus )
  polygon( [ [-1,-1], [x,-1], [x,0], [0,y], [-1,y] ] );
}

module chamfer_cube( cube, inset = 1, angle = 45, all=true, front=false, back=false, left=false, right=false, top=false, bottom=false, edge1=true, edge2=true, edge3=true, edge4=true )
{
  module chamfer_front()
  {

    // top
    if ( edge1 ) {
      translate( [0,0,cube[2] ] )
      rotate( [0,90,0] )
      chamfer_edge( cube[0], inset, angle );
    }

    // left
    if ( edge2 ) {
      chamfer_edge( cube[2], inset, angle );
    }

    //bottom
    if ( edge3 ) {
      translate( [cube[0],0,0 ] )
      rotate( [0,-90,0] )
      chamfer_edge( cube[0], inset, angle );
    }

    // right
    if ( edge4 ) {
      translate( [cube[0],0,0] )
      mirror( [1,0,0] )
      chamfer_edge( cube[2], inset, angle );
    }


  }

  module chamfer_bottom()
  {
    // front
    if ( edge1) {
      rotate( [90,0,90] )
      chamfer_edge( cube[0], inset, angle );
    }

    // right
    if ( edge2) {
      translate( [cube[0],cube[1],0 ] )
      mirror( [1,0,0] )
      rotate( [90,0,0] )
      chamfer_edge( cube[1], inset, angle );
    }

    // back
    if ( edge3) {
      translate( [0,cube[1],0] )
      mirror( [ 0,1,0 ] )
      rotate( [90,0,90] )
      chamfer_edge( cube[0], inset, angle );
    }

    // left
    if ( edge4) {
      translate( [0,cube[1],0 ] )
      rotate( [90,0,0] )
      chamfer_edge( cube[1], inset, angle );
    }
  }

  module chamfer_left()
  {
    mirror( [1,0,0] )
    rotate( [0,0,90] )
    chamfer_edge( cube[2], inset, angle );

    translate( [0,cube[1],0 ] )
    mirror( [0,1,0] )
    mirror( [1,0,0] )
    rotate( [0,0,90] )
    chamfer_edge( cube[2], inset, angle );

    translate( [0,cube[1],cube[2] ] )
    rotate( [90,90,0] )
    chamfer_edge( cube[1], inset, angle );

    rotate( [-90,-90,0] )
    chamfer_edge( cube[1], inset, angle );
  }

  if ( all || top ) {
    translate( [0,0,cube[2] ] )
    mirror( [0,0,1] )
    chamfer_bottom();
  }

  if ( all || bottom ) {
    chamfer_bottom();
  }

  if ( all || front ) {
    chamfer_front();
  }
  if ( all || back ) {
    translate( [0,cube[1],0] )
    mirror( [0,1,0] )
    chamfer_front();
  }

  if ( all || left ) {
    chamfer_left();
  }

  if ( all || right ) {
    translate( [cube[0],0,0] )
    mirror( [1,0,0] )
    chamfer_left();
  }
}

