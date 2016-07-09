// Generated by "ink2scad" inkscape extension. http://nickthecoder.co.uk/software/view/ink2scad
//
// Names are based on the inkscape path's id. Use Shift+Ctrl++O in inkscape to edit the paths' ids.
// For each inkscape path, a variable is created, which defines the path. The data takes the form :
//
//     [ points, paths, [ox,oy], [width,height] ]
//
//     points         : An array of 2D coordinates. Passed to polygon's 'points' parameter.
//     paths          : An array of array of integers. Passed to polygon's 'paths' parameter.
//     [width,height] : The size of the path's bounding box.
//     [left,bottom]  : The position of the path's bottom left corner (When exporting more than one object).
//
// Example simple extrusions : :
//     linear_extrude( height = 10 ) ink2scad( myshape );
//

// Creates a 2D polygon from the data generated by the ink2scad inkscape plugin.
//
// data        : The definition of your shape (see header above for details)
// center      : If true, the polygon is create centered at (0,0)
// relative    : If true, the polygon is created at a position relative to the other generated objects 
// convexity   : Only used during openSCAD's preview mode
//
module ink2scad( data, center=false, relativeTo, convexity=4 )
{
    if ( center ) {
        translate( -data[2]/2 ) polygon( points=data[0], paths=data[1], convexity=convexity );
    } else {
        if ( relativeTo ) {
            translate( data[3] - relativeTo[3] ) polygon( points=data[0], paths=data[1], convexity=convexity );
        } else {
            polygon( points=data[0], paths=data[1], convexity=convexity );
        }
    }
}

//
// Example usage :
// linear_extrude( 10 ) ink2scad( myshape, center=true );
//

hook = [
    [ [6.34,31.28], [4,30.70], [1.90,29], [0.92,27.20], [0.41,24.93], [0,19.31], [0.30,13.30], [1.07,8.40], [2.47,4.58], [3.98,1.83], [5.04,0.54], [5.94,0], [5.47,1.65], [4.53,3.74], [3.18,8.86], [2.66,13.49], [2.50,19.28], [2.88,24.54], [3.78,27.36], [5.13,28.47], [6.31,28.78], [7.36,28.49], [8.35,27.54], [8.96,25.36], [9.16,21.39], [8.91,13.51], [8.52,12.27], [7.78,12.02], [7.04,12.28], [6.69,13.43], [6.74,20.88], [6.40,21.80], [5.52,22.22], [4.62,21.84], [4.24,20.94], [4.19,13.40], [4.51,11.83], [5.31,10.60], [6.45,9.81], [7.76,9.52], [9.08,9.79], [10.23,10.59], [11.06,11.83], [11.40,13.43], [11.67,21.40], [11.44,25.68], [11.10,27.49], [10.39,29.01], [8.59,30.66] ],
    [ [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48] ],
    [11.67,31.28],
    [53,-145.64]
];

