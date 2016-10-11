/*
    Usesul bits and pieces that I use in many of my 3D designs.
*/

use <label.scad>;

module ntc_tools_help()
{
    echo( "Modules in tools.scad : " );
    echo( "    ntc_segment, ntc_arc, ntc_rounded_arc, ntc_arrange_grid, ntc_arrange_circle, ntc_arrange_mirror, ntc_cube" );
    echo( "Suffix the module name with _help for textual help." );
}

module ntc_segment_help()
{
    echo( "Creates a circle segment." );
    echo();
    echo( "Parameters :" );
    echo( "    r      : radius of the circle" );
    echo( "    angle  : size of the segment" );
    echo( "    rotate : angle of rotate (so the segment doesn't start at 0 degrees." );
    echo();
    echo( "See ntc_segment_visualise() for a diagram" );
}

module ntc_segment( r, angle, rotate, sides=30 )
{
    n = 4;
    l = r*2;
    
    intersection() {
        circle( r=r, $fn=sides );
        for ( i = [1:n] ) {
            rotate( rotate ) polygon( [ [0,0], [l * cos(angle * (i-1) / n), l * sin( angle * (i-1) / n)], [l * cos(i * angle / n), l * sin(i * angle / n ) ] ] );
        }
    }
}


module ntc_segment_visualise()
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


module ntc_arc_help()
{
    echo( "Create a 2D arc" );
    echo( "Parameters:" )
    echo( "    r1     : outer radius" );
    echo( "    r2     : inner radius" );
    echo( "    angle  : the extent of arc in degrees." );
    echo( "    rotate : rotates the arc anticlockwise, so that it no longer starts along the x-axis");
}

module ntc_arc( r1, r2, angle=45, rotate=0 )
{
    intersection() {

        difference() {
            circle( r1 );
            circle( r2 );
        }
        ntc_segment( r1 * 2, angle, rotate );
    }
}
  
module ntc_rounded_arc_help()
{
    echo( "Create a 2D arc with rounded ends." );
    echo( "See ntc_arc_help() - the parameters are the same." );
}

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


module ntc_arrange_grid_help()
{
    echo( "Arrange copies of the children elements in a grid pattern." );
    echo( "Can be used to arrange items in a line, a 2D grid, or a 3D grid." );
    echo();

    echo( "Parameters" );
    echo( "    nx    : Number of repeated object along the x axis" );
    echo( "    distX : Distance between objects in the X direction" );
    echo( "    ny    : Number of repated objects along the y axis (default=1) " )
    echo( "    distY : Distance between objects in the Y direction (default=0)" );
    echo( "    nz    : Number of repeated objects along the z axis (default=1) " );
    echo( "    distZ : Distance between objects in the Y direction (default=0)" );
    echo( "Child Nodes : The objects to arrange" );
    echo();
    
    echo( "Examples: " );
    echo( "    ntc_arrange_grid( 4, 40 ) sphere( d=30 ); // Arrange 4 in a single row." );
    echo( "    ntc_arrange_grid( 4, 40, 3, 10 ) cirlce( d=30 ); // Arrange in  4x3 grid (overlapping in the Y direction)." );
    echo( "    ntc_arrange_grid( 4, 40, 3, 40, 2, 40 ) cirlce( d=30 ); // Arrange in a 4x3x2 3D grid, equally spaced." );
}

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

module ntc_arrange_circle_help()
{
    echo( "Arrange n copies of the children elements in an circular/elliptical fashion." );
    echo()
    echo( "Parameters:" );
    echo( "    n            : The number of copies" );
    echo( "    radius       : The radius of the circle (it can be a 2 tuple, to create an ellipse)" );
    echo( "    rotate       : Set to true to rotate the pieces, rather than mearly translating them (default=false)." );
    echo( "    offset_angle : Which angle to begin from (default=0)." );
    echo( "Child Nodes : The objects to arrange" );
}

module ntc_arrange_circle( n, radius, rotate=false, offset_angle=0 )
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

module ntc_arrange_mirror_help()
{
    echo( "Mirror image copies of the children." );
    echo( "The defult is to mirror in the X=0 plane, creating two copies." );
    echo( "If more than one mirror plane is selected, then you will get 4 or 8 copies of the children." );
    echo( "Note, unlike the built-in 'mirror' module, this module can use true & false values as well as 1 and 0" );
    echo();
    echo( "Parameters:" );
    echo( "    planes : The planes in which to mirror. A 3 tuple, with each being one of {true,false,1,0}" );
    echo( "Child Nodes : The objects to arrange" );
}

module ntc_arrange_mirror( planes=[1,0,0] )
{
    function count( b ) = b ? 1 : 0;

    x = count( planes[0] );
    y = count( planes[1] );
    z = count( planes[2] );
    
    total = x + y + z;

    if ( total > 1 ) {

        if ( planes[0] ) {
            //echo( "Plane X", planes );
                              ntc_arrange_mirror( [ 0, y, z ] ) children();
            mirror( [1,0,0] ) ntc_arrange_mirror( [ 0, y, z ] ) children();
            
        } else {
            //echo( "Planes Y and Z", planes );
                              ntc_arrange_mirror( [ 0, 0, 1 ] ) children();
            mirror( [0,1,0] ) ntc_arrange_mirror( [ 0, 0, 1 ] ) children();
        }

    } else {
        if (total == 0) {
            //echo( "No planes", planes );
            children();
        } else {
            //echo( "A Single plane", planes );
            children();
            mirror( [x,y,z] ) children();
        }
    }   
}

module ntc_cube_help()
{
    echo( "Similar to the built-in 'cube' module, but with more flexibility of how the cube is aligned." );
    echo( "The default behaviour is to center the cube in the X and Y axises, but not in the Z axis." );
    ehco( "i.e. similar to how a cylinder is aligned." );
    echo();
    echo( "Parameters:" );
    echo( "    size   : The size of the cube. Either a 3 tuple, or a single value." );
    echo( "    center : Which axises to center. Either a 3 tuple, or a single value." );
    echo( "             Values {0,1,true,false}. Default=[1,1,0]" );
    echo( "    align  : A 3 tuple. Each value is usually in the range [0..1]." );
    echo( "             0 : left aligned, 0.5 : centered, 1 : right aligned" );
    echo( "             If 'align' is set, then 'center' is ignored." );
}

module ntc_cube( size, center=[1,1,0], align=undef )
{
    dx = align ? -size[0]*align[0] : center[0] ? size[0] * -0.5 : 0;
    dy = align ? -size[1]*align[1] : center[1] ? size[1] * -0.5 : 0;
    dz = align ? -size[2]*align[2] : center[2] ? size[2] * -0.5 : 0;
    
    if ( len( size ) == undef ) {
        ntc_cube( [size, size, size ], center=center, align=align );
    } else {
        translate( [ dx, dy, dz] ) cube( size );
    }
}

module ntc_rotateToAxis_help()
{
    echo( "If the child is pointing along the Z axis, then rotate it so that it points along the X or Y axis" );
    echo( "A trival, but useful module to make extrusions and cylinder point in an axis of your choice" );
    echo( "Used by ntc_cylinder and ntc_linear_extrude" );
    echo();
    echo( "Parameters:" );
    echo( "    axis  : Either {'x','y','z'}. Default='z'" );
}

module ntc_rotateToAxis( axis )
{
    if (axis == "x") {
        rotate( [0,90,0] ) children();
    } else if (axis == "y") {
        rotate( [-90,0,0] ) children();
    } else {
        children();
    }
}

module ntc_cylinder_help()
{
    echo( "Similar to the built-in 'cylinder' module, but with more flexibility of how it is aligned." );
    echo();
    echo( "Parameters:" );
    echo( "    d,r,d1,d2,r1,r2 : Diameter/radius (exactly the same as the built-in cylinder module" );
    echo( "    h               : Height (exactly the same as the build-in cylinder module" );
    echo( "    center          : exactly the same as the build-in cylinder module" );
    echo( "    align           : How the cylinder is aligned, usually in the range [0..1]" );
    echo( "                      0 : aligned on its base, 0.5 aligned in the middle, 1 aligned on its top" );
    echo( "                      If 'align' is set, then 'center' is ignored" );
    echo( "    axis            : Which axis to point the cylinder (default='z')");
}

module ntc_cylinder( d, d1, d2, r, r1, r2, h, center=false, align=undef, axis="z" )
{
    offset = align==undef ? center ? -h/2 : 0 : -h*align;

    ntc_rotateToAxis( axis ) {
        translate([0,0,offset]) cylinder( d=d, d1=d1, d2=d2, r=r, r1=r1, r2=r2, h=h );
    }
}

module ntc_linear_extrude_help()
{
    echo( "Similar to the built-in 'linear-extrude', but with extra flexibility of how it is aligned" );
    echo( "Parameters:" );
    echo( "    height, convexity, center, twist, slices, scale : All identical to the built-in 'linear_extrude'" );
    echo( "    axis : Which axis to extrude along {'x','y','z' }. Default = 'z'");
}

module ntc_linear_extrude( height, convexity=undef, center=undef, twist=undef, slices=undef, scale=undef, axis="z" )
{
    ntc_rotateToAxis( axis ) {
        linear_extrude( height=height, convexity=convexity, center=center, twist=twist, slices=slices, scale=scale ) children();
    }       
}


module ntc_rotate_extrude( angle=360, convexity=undef, axis="z" )
{
    ntc_rotateToAxis( axis ) {
        rotate_extrude( angle=angle, convexity=convexity ) children();
    }       
}

module ntc_inspect_help()
{
    echo( "Makes a slice through an axis, so that you can see the inner workings of your object" );
    echo();
    echo( "Parameters:" );
    echo( "    axis       : The thin axis of the slice (default='y')");
    echo( "    offset     : Translation of the slice along 'axis'" );
    echo( "    angle,tilt : The two angles of the slice" );
    echo( "    thickness  : The thickness of the slice (default=1)" );
    echo( "    size       : The size of the slice (default=1000)");

}

module ntc_inspect( axis="y", offset=0, angle=0, tilt=0, thickness=1, size=1000 )
{
    intersection() {
        ntc_rotateToAxis( axis ) translate([0,0,offset]) rotate( [tilt,angle,0] ) cube( [size,size,1], center=true );
        children();
    }
}

