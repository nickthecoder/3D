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

italic = [
    [ [5.44,40.76], [4.37,39.77], [7.13,36.76], [12.63,36.76], [13.13,36.76], [15.64,36.76], [20.13,36.76], [23.36,39.77], [22.45,40.76], [15.95,40.76], [13.44,40.76], [12.94,40.76],   [3.83,39.26], [2.75,38.27], [2.20,31.11], [2.13,30.26], [1.89,27.12], [1.44,21.26], [1.90,20.76], [3.40,20.76], [5.56,22.76], [5.89,27.12], [6.13,30.26], [6.20,31.11], [6.60,36.27],   [23.83,39.26], [20.59,36.27], [20.20,31.11], [20.13,30.26], [19.94,27.76], [19.89,27.12], [19.55,22.76], [21.40,20.76], [22.90,20.76], [23.44,21.26], [23.89,27.12], [24.13,30.26], [24.20,31.11], [24.75,38.27],   [6.02,22.41], [3.87,20.42], [5.72,18.41], [11.72,18.41], [17.22,18.41], [18.72,18.41], [20.88,20.42], [19.02,22.41], [17.52,22.41], [12.03,22.41],   [1.84,20.06], [1.31,19.56], [0.86,13.71], [0.55,9.71], [0,2.57], [0.92,1.57], [4.15,4.57], [4.61,10.57], [4.81,13.06], [5.19,18.06], [3.34,20.06],   [21.34,20.06], [19.19,18.06], [18.80,13.06], [18.55,9.71], [18.15,4.57], [20.92,1.57], [22,2.57], [22.61,10.57], [22.86,13.71], [23.31,19.56], [22.84,20.06],   [24.80,4.13], [23.99,3.97], [23.34,3.52], [22.89,2.87], [22.73,2.06], [22.89,1.26], [23.34,0.60], [23.99,0.16], [24.80,0], [25.60,0.16], [26.26,0.60], [26.70,1.26], [26.86,2.06], [26.70,2.87], [26.26,3.52], [25.60,3.97],   [4.61,4.07], [1.38,1.07], [2.30,0.06], [10.31,0.06], [12.81,0.06], [19.31,0.06], [20.38,1.07], [17.61,4.07], [13.11,4.07], [10.61,4.07] ],
    [ [0,1,2,3,4,5,6,7,8,9,10,11], [12,13,14,15,16,17,18,19,20,21,22,23,24], [25,26,27,28,29,30,31,32,33,34,35,36,37,38], [39,40,41,42,43,44,45,46,47,48], [49,50,51,52,53,54,55,56,57,58,59], [60,61,62,63,64,65,66,67,68,69,70], [71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86], [87,88,89,90,91,92,93,94,95,96] ],
    [26.86,40.76],
    [66.35,-92.42]
];
