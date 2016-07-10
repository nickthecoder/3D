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

tail = [
    [ [1.50,9], [0.92,8.88], [0.44,8.56], [0.12,8.09], [0,7.50], [0,1.50], [0.12,0.92], [0.44,0.44], [0.92,0.12], [1.50,0], [7.50,0], [7.80,0.05], [8.07,0.18], [8.51,0.59], [8.82,1.09], [9,1.50], [9.35,2.59], [9.53,3.46], [9.60,4.50], [9.53,5.54], [9.36,6.40], [9,7.50], [8.81,7.92], [8.50,8.41], [8.06,8.83], [7.80,8.95], [7.50,9],   [3.99,7.25], [4.52,7.25], [6.12,7.20], [6.56,7.09], [6.88,6.87], [7.16,6.56], [7.42,6.11], [7.61,5.45], [7.69,4.50], [7.61,3.55], [7.41,2.88], [7.15,2.43], [6.86,2.11], [6.54,1.89], [6.10,1.78], [4.50,1.73], [2.18,1.80], [2.01,2.75], [1.88,3.51], [1.83,4.51], [1.88,5.46], [1.99,6.22], [2.16,7.22] ],
    [ [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26], [27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49] ],
    [9.60,9],
    [90,-146]
];


profile = [
    [ [0,6.03], [3.43,6.33], [6.64,6.54], [9.90,6.63], [12.95,6.52], [15.80,6.17], [17.05,5.91], [18.13,5.60], [19,5.24], [19.61,4.82], [20.41,3.89], [21.08,2.99], [21.43,2.61], [21.80,2.30], [22.24,2.11], [22.75,2.03], [23.60,2.02], [23.32,2], [23.32,0], [23.11,0.01], [21.85,0.04], [21.26,0.08], [20.81,0.22], [20.45,0.45], [20.12,0.77], [19.40,1.71], [18.25,3.04], [17.72,3.38], [16.89,3.66], [15.82,3.88], [14.56,4.05], [11.60,4.25], [8.38,4.30], [2.57,4.17], [0,4.04] ],
    [ [34,33,32,31,30,29,28,27,26,25,24,23,22,21,20,19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0] ],
    [23.60,6.63],
    [68.75,-156.03]
];


tab = [
    [ [0.50,3.21], [6.50,3.21], [6.70,3.17], [6.85,3.04], [7,2.63], [7,0.59], [6.85,0.17], [6.70,0.05], [6.50,0], [0.50,0], [0.30,0.05], [0.15,0.17], [0,0.59], [0,2.63], [0.15,3.04], [0.30,3.17] ],
    [ [15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0] ],
    [7,3.21],
    [71,-143.18]
];


head = [
    [ [1.50,9], [7.50,9], [8.08,8.88], [8.56,8.56], [8.88,8.08], [9,7.50], [9,1.50], [8.88,0.92], [8.56,0.44], [8.08,0.12], [7.50,0], [1.50,0], [0.92,0.12], [0.44,0.44], [0.12,0.92], [0,1.50], [0,7.50], [0.12,8.08], [0.44,8.56], [0.92,8.88] ],
    [ [19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0] ],
    [9,9],
    [70,-146]
];


neck = [
    [ [0,6], [0,3], [0,0], [0.71,0.41], [1.47,0.74], [3.03,1.20], [4.51,1.43], [5.70,1.50], [7.04,1.58], [7.82,1.59], [9.20,1.50], [10.04,1.37], [10.74,1.17], [11.76,0.67], [12.33,0.20], [12.50,0], [13.20,0], [13.20,3], [13.20,6], [12.50,6], [12.33,5.80], [11.76,5.33], [10.74,4.83], [10.04,4.63], [9.20,4.50], [7.82,4.41], [7.04,4.42], [5.70,4.50], [4.51,4.57], [3.03,4.80], [1.47,5.26], [0.71,5.59] ],
    [ [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31] ],
    [13.20,6],
    [77.80,-144.50]
];
