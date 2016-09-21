use <label.scad>;

module ntc_tools_help()
{
    echo( "Modules in tools.scad : " );
    echo( "    ntc_intersect_segment, ntc_arc, ntc_rounded_arc, ntc_arrange_grid" );
    echo( "suffix the module name with _help to see a usage diagram." );
}

ntc_tools_help();



//list1 = [ for (i = [0 : 2 : 10]) i ];
//echo(list1);

/*
  Creates a circle segment.
  
  r      : radius of the circle
  angle  : size of the segment
  rotate : angle of rotate (so the segment doesn't start at 0 degrees.
*/
module ntc_segment( r, angle, rotate )
{
    n = 4;
    l = r*2;

    if ( rotate ) {
        rotate( rotate ) ntc_segment( r, angle );

    } else {
        
        intersection() {
            circle( r=r );
            for ( i = [1:n] ) {
                polygon( [ [0,0], [l * cos(angle * (i-1) / n), l * sin( angle * (i-1) / n)], [l * cos(i * angle / n), l * sin(i * angle / n ) ] ] );
            }
        }
    }
}


module ntc_segment_help()
{
    radius = 30;
    angle = 60;
    rotate = 45;

    translate( [-50, 80, 0 ] )
    title( "segment( radius, angle = angle, rotate=rotate )" );

    ntc_segment( radius, angle = angle, rotate=rotate );

    translate( [0,0,2] )
    rotate( rotate )
    label_angle( "angle", angle );

    translate( [0,0,2] )
    label_radius( "r", radius );

    translate( [26,26,2] )
    label_angle( "rotate", rotate );
}

// ntc_segment_help();

/*
  Create a 2D arc outer radius r1, inner radius r2, the extent of arc is "angle" degrees. starting from the x-axis.
*/
module ntc_arc( r1, r2, angle, rotate )
{
    intersection() {

        difference() {
            circle( r1 );
            circle( r2 );
        }
        ntc_segment( r1 * 2, angle, rotate );
    }
}
  
/*
  Create a 2D arc with rounded ends. See arc().
*/
module ntc_rounded_arc( r1, r2, angle, rotate )
{
    if (rotate) {
        rotate( rotate ) ntc_rounded_arc( r1, r2, angle );
    } else {

        translate( [(r1 + r2) / 2, 0 ] ) {
            circle( (r1 - r2) /2 );
        }

        rotate( angle ) translate( [(r1 + r2) / 2, 0 ] ) {
            circle( (r1 - r2) /2 );
        }

        ntc_arc( r1, r2, angle );
    }
}


/*
    Arrange copies of the children elements in a grid pattern.
    Can be used to arrange items in a line, a 2D grid, or a 3D grid.
    
    e.g.
    ntc_arrange_grid( 4, 40 ) sphere( d=30 ); // Arrange 4 in a single row.
    ntc_arrange_grid( 4, 40, 3, 10 ) cirlce( d=30 ); // Arrange in  4x3 grid (overlapping in the Y direction).
    ntc_arrange_grid( 4, 40, 3, 40, 2, 40 ) cirlce( d=30 ); // Arrange in a 4x3x2 3D grid, equally spaced.
*/
module ntc_arrange_grid( nx, distX, ny=1, distY=0, nz=1, distZ=0 )
{
    for ( z=[0:nz-1] ) {
       for ( y=[0:ny-1] ) {
            for ( x=[0:nx-1] ) {
                translate([x*distX, y*distY, z*distZ]) children();
            }
        }
    }        
}

/*
    Arrange n copies of the children elements in an ellipse who's radii are dx, dy.

    n            : The number of copies
    radius       : The radius of the circle (or it can be a 2 tuple, to create an ellipse)
    rotate       : Set to 1 to rotate the pieces, rather than mearly translating them.
    offset_angle : Which angle to begin from (default = 0).
*/
module ntc_arrange_circle( n, radius, rotate=0, offset_angle=0 )
{    
    if ( len(radius) == undef ) {
        ntc_arrange_circle( n, [radius, radius], rotate, offset_angle ) children();
    } else {
        
        for ( i=[0:n-1] ) {
            translate( [ radius[0]*cos( offset_angle + 360/n*i), radius[1]*sin( offset_angle + 360/n*i), 0 ] ) {
                if (rotate) {
                    rotate( [0,0, offset_angle + 360/n*i ] ) children();
                } else {
                    children();
                }
            }
        }
    }
}

/*
    Mirror image copies of the children.
    The defult is to mirror in the X=0 plane, creating two copies.
    
    If more than one mirror plane is selected, then you will get 4 or 8 copies of the children.
    
    mirror : The planes in which to mirror (a 3 tuple). 1 to mirror, otherwise 0. Do not use any other values!
*/
module ntc_arrange_mirror( planes=[1,0,0] )
{
    if ( planes[0] + planes[1] + planes[2] > 1 ) {

        if ( planes[0] ) {
                              ntc_arrange_mirror( [ 0, planes[1], planes[2] ] ) children();
            mirror( [1,0,0] ) ntc_arrange_mirror( [ 0, planes[1], planes[2] ] ) children();
            
        } else {
            // Must be planes Y and Z
                              ntc_arrange_mirror( [ 0, 0, 1 ] ) children();
            mirror( [0,1,0] ) ntc_arrange_mirror( [ 0, 0, 1 ] ) children();
        }

    } else {
        children();
        mirror( planes ) children();
    }   
}

/*
    A cuboid centered on x and y, but not centered on z, instead it lays on the z=0 plane.
    Useful, because it behaves in a similar manner to cylinder.
*/
module ntc_cube( size, center=[1,1,0] )
{
    dx = center[0] ? size[0] * -0.5 : 0;
    dy = center[1] ? size[1] * -0.5 : 0;
    dz = center[2] ? size[2] * -0.5 : 0;
    
    if ( len( size ) == undef ) {
        ntc_cube( [size, size, size ], center );
    } else {
        translate( [ dx, dy, dz] ) cube( size );
    }
}


