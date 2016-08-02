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

drawer3 = [
    [ [3.03,23.58], [2.54,23.57], [2.32,23.31], [1.25,20.39], [0.50,17.58], [0.04,14.34], [0,8.78], [0.20,6.99], [0.49,6.02], [0.61,5.61], [0.98,5.04], [2.26,4.24], [5.10,3.11], [8.31,2.05], [11.82,1.11], [15.84,0.38], [20.61,0], [25.72,0.06], [30.18,0.41], [34.54,1], [35.12,1.24], [35.55,1.59], [35.82,2.14], [35.81,7.66], [35.84,11.50], [35.74,13], [35.53,13.76], [27.47,15.87], [20.76,17.58], [14.90,19.30] ],
    [ [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29] ],
    [35.84,23.58],
    [73.08,-127.59]
];


handle4 = [
    [ [0,3.48], [0.13,0.75], [1.52,0.30], [4.28,0], [6.97,0.19], [8.35,0.51], [8.66,1.82], [8.59,3.24], [8.09,3.30], [7.11,3.14], [4.28,2.86], [1.40,3.25] ],
    [ [0,1,2,3,4,5,6,7,8,9,10,11] ],
    [8.66,3.48],
    [92.42,-142.16]
];


handle1 = [
    [ [0.42,4.62], [0,1.92], [1.28,1.20], [3.92,0.35], [6.59,0], [8.01,0.04], [8.57,1.26], [8.79,2.67], [8.31,2.82], [7.32,2.87], [4.49,3.15], [1.75,4.12] ],
    [ [0,1,2,3,4,5,6,7,8,9,10,11] ],
    [8.79,4.62],
    [99.40,-76.92]
];


handle2 = [
    [ [0.42,4.59], [0,1.88], [1.30,1.31], [3.97,0.62], [8.01,0], [8.57,1.23], [8.79,2.63], [7.34,2.98], [4.54,3.42], [1.77,4.23] ],
    [ [0,1,2,3,4,5,6,7,8,9] ],
    [8.79,4.59],
    [93.19,-97.76]
];


drawer2 = [
    [ [4.37,26.74], [3.95,26.20], [3.43,24.91], [2.27,21.12], [0.86,15.68], [0.39,14.09], [0,11.83], [0.24,10.88], [0.91,9.83], [2.27,8.72], [4.57,7.55], [10.33,5.71], [19.35,3.20], [31.81,0], [32.52,0.39], [33.24,1.55], [35.04,5.80], [38.21,12.66], [39.67,15.78], [40.21,17.25], [39.94,17.57], [39.37,17.69], [32.75,18.12], [26.62,18.94], [23.27,19.61], [19.90,20.50], [13.85,22.65], [9.14,24.72], [5.93,26.24] ],
    [ [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28] ],
    [40.21,26.74],
    [78.39,-108.56]
];


main = [
    [ [2.92,111.43], [3.86,109.69], [6,104.96], [7.19,101.71], [8.28,98], [9.15,93.91], [9.68,89.56], [9.69,87.36], [9.46,85.01], [8.41,79.93], [6.81,74.41], [4.93,68.57], [3.03,62.49], [1.40,56.29], [0.30,50.06], [0.03,46.96], [0,43.90], [0.51,38.79], [1.57,34.06], [3,29.68], [4.62,25.64], [7.68,18.57], [8.75,15.51], [9.27,12.76], [9.45,7.87], [9.36,3.81], [9.07,0], [15.07,0], [15.57,2.69], [15.72,4.97], [15.67,9.60], [20.44,8.62], [25.44,8.10], [30.39,7.95], [35.04,8.06], [42.35,8.65], [45.26,9.03], [45.07,0], [51.07,0], [51.46,5.38], [51.07,15], [50.64,18.50], [49.93,22.05], [48.12,29.20], [46.50,36.35], [46.04,39.89], [45.96,43.40], [46.54,47.17], [47.85,51.45], [49.68,56.14], [51.83,61.11], [56.31,71.49], [58.23,76.67], [59.67,81.70], [60.39,86.39], [60.50,90.94], [60.15,95.20], [59.50,99.01], [57.95,104.73], [57.15,106.90], [55.85,106.05], [52.36,104.17], [49.97,103.15], [47.24,102.24], [44.26,101.57], [41.09,101.25], [39.40,101.32], [37.57,101.61], [33.60,102.74], [29.36,104.41], [25.03,106.38], [16.84,110.30], [13.34,111.79], [10.48,112.64], [8.26,112.94], [6.52,112.97], [5.19,112.80], [4.23,112.50], [3.18,111.80] ],
    [ [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78] ],
    [60.50,112.97],
    [67.93,-163]
];


drawer1 = [
    [ [0,28.44], [1.19,24.49], [2.92,17.59], [3.32,14.71], [3.42,12.68], [3.46,10.56], [3.64,10.06], [4.05,9.62], [6.68,7.92], [9.98,6.31], [14.63,4.44], [22.66,1.70], [27.68,0.67], [32.43,0.15], [36.28,0], [38.58,0.09], [40.32,0.43], [41.22,0.80], [41.96,1.42], [42.70,2.81], [43.56,5.22], [44.29,8.30], [44.64,11.70], [44.56,14.81], [44.22,17.36], [43.27,21.16], [43.02,21.61], [42.71,21.68], [42.35,21.50], [41.41,21.02], [38.85,19.98], [35.09,18.93], [32.89,18.58], [30.54,18.45], [28.05,18.61], [25.43,19.04], [20.13,20.50], [15.25,22.36], [11.39,24.16], [5.96,26.87], [2.84,28.28], [0.50,29.08], [0.16,29.03], [0.01,28.81] ],
    [ [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43] ],
    [44.64,29.08],
    [79.41,-85.74]
];


handle3 = [
    [ [0.42,4.59], [0,1.88], [1.23,1.34], [3.81,0.67], [8.01,0], [8.57,1.23], [8.79,2.63], [7.37,2.98], [4.59,3.42], [1.80,4.23] ],
    [ [0,1,2,3,4,5,6,7,8,9] ],
    [8.79,4.59],
    [86.64,-119.94]
];


drawer4 = [
    [ [0,20.65], [0.20,19.71], [1.03,17.49], [3.79,11.40], [5.09,8.45], [5.97,5.91], [6.74,3.16], [7.76,2.55], [10.62,1.57], [15.43,0.60], [22.32,0], [29.26,0.02], [34.21,0.49], [37.25,1.20], [38.07,1.57], [38.45,1.92], [38.53,3.31], [38.25,5.71], [37.72,8.40], [37.03,10.67], [35.61,14.85], [34.91,17.22], [34.74,17.61], [34.48,17.87], [34.04,17.99], [32.85,17.71], [30.03,17.14], [25.06,16.72], [17.46,16.84], [13.23,17.22], [9.65,17.76], [4.27,19.07], [1.13,20.22] ],
    [ [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32] ],
    [38.53,20.65],
    [75.08,-149.21]
];


top = [
    [ [4.98,4.88], [4,5.49], [2.35,6.88], [0,9.20], [0.91,10.82], [2.10,12.30], [3.74,13.96], [5.80,15.58], [8.26,16.96], [11.08,17.90], [14.25,18.18], [16.53,17.97], [18.87,17.51], [23.66,16.02], [28.50,14], [33.25,11.74], [37.79,9.52], [41.99,7.62], [45.72,6.34], [47.37,6.03], [48.85,5.97], [51.81,6.30], [54.31,6.86], [56.41,7.62], [58.17,8.54], [59.64,9.60], [60.89,10.77], [62.95,13.26], [64.95,16.45], [65.91,18.81], [66.45,20.92], [69.20,20.67], [71,20.21], [71.96,19.60], [71.87,18.29], [71.10,15.95], [69.73,13], [67.81,9.87], [65.19,6.81], [63.33,5.17], [61.10,3.58], [58.51,2.17], [55.55,1.03], [52.23,0.27], [48.55,0], [46.53,0.14], [44.41,0.51], [39.94,1.85], [35.31,3.75], [30.65,5.93], [21.84,10.05], [17.98,11.45], [16.25,11.87], [14.68,12.05], [12.48,11.81], [10.59,11.03], [9,9.89], [7.68,8.56], [5.84,6.04] ],
    [ [58,57,56,55,54,53,52,51,50,49,48,47,46,45,44,43,42,41,40,39,38,37,36,35,34,33,32,31,30,29,28,27,26,25,24,23,22,21,20,19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0] ],
    [71.96,20.92],
    [61.30,-62.45]
];


back = [
    [ [66.77,121.51], [66.45,121.47], [65.90,119.36], [64.95,117.01], [62.94,113.81], [60.89,111.32], [59.64,110.16], [58.17,109.10], [56.41,108.17], [54.31,107.41], [51.81,106.85], [48.85,106.52], [47.37,106.58], [45.72,106.89], [41.99,108.17], [37.79,110.07], [33.25,112.29], [28.50,114.55], [23.66,116.57], [18.86,118.06], [16.52,118.51], [14.24,118.73], [11.08,118.45], [8.26,117.51], [5.80,116.13], [3.74,114.51], [2.10,112.85], [0.91,111.37], [0,109.75], [2.35,107.43], [4,106.04], [4.98,105.43], [5.47,106.02], [6.41,107.46], [7.83,109.29], [9.76,111.05], [11.11,108.44], [13.14,103.63], [14.19,100.57], [15.12,97.16], [15.86,93.47], [16.31,89.56], [16.32,87.36], [16.09,85.01], [15.05,79.93], [13.44,74.42], [11.56,68.57], [9.66,62.50], [8.03,56.29], [6.93,50.06], [6.66,46.97], [6.63,43.90], [7.14,38.80], [8.20,34.06], [9.63,29.68], [11.25,25.64], [14.30,18.57], [15.38,15.51], [15.90,12.75], [16.08,7.87], [15.99,3.81], [15.70,0], [21.70,0], [22.21,2.69], [22.35,4.97], [22.30,9.60], [27.08,8.62], [32.07,8.10], [37.02,7.96], [41.67,8.07], [48.98,8.65], [51.88,9.03], [51.70,0], [57.70,0], [58.09,5.38], [57.70,15], [57.27,18.50], [56.57,22.05], [54.75,29.20], [53.13,36.36], [52.67,39.90], [52.59,43.40], [53.17,47.17], [54.48,51.45], [56.31,56.14], [58.46,61.12], [62.94,71.49], [64.86,76.68], [66.30,81.70], [66.97,85.80], [67.16,89.80], [66.96,93.61], [66.49,97.13], [65.16,102.89], [64.02,106.30], [66.24,108.46], [67.81,110.42], [69.73,113.55], [71.10,116.50], [71.87,118.84], [71.96,120.16], [71.18,120.70], [69.68,121.13] ],
    [ [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102] ],
    [71.96,121.51],
    [61.30,-163]
];

