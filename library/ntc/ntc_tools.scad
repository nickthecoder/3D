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
    For best results, the
*/
module ntc_arrange_circle( n, dx, dy=dx )
{
    for ( i=[0:n-1] ) {
        translate( [ dx*cos(360/n*i), dy*sin(360/n*i), 0 ] ) rotate( [0,0,360/n*i] ) children();
    }
}

