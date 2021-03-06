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

headInner = [
    [ [13.21,11.85], [12.39,8.50], [11.19,5.51], [9.70,3.01], [7.99,1.17], [6.20,0.14], [4.47,0], [2.90,0.73], [1.58,2.32], [0.61,4.64], [0.08,7.50], [0,10.72], [0.39,14.15], [1.22,17.50], [2.41,20.50], [3.90,22.99], [5.61,24.83], [7.40,25.86], [9.13,26], [10.70,25.27], [12.03,23.68], [12.99,21.36], [13.52,18.50], [13.60,15.28] ],
    [ [23,22,21,20,19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0] ],
    [13.60,26],
    [82.13,-211.92]
];


head = [
    [ [13.64,35.13], [11.46,34.86], [9.33,34.02], [7.31,32.64], [5.44,30.78], [2.33,25.82], [0.40,19.55], [0,15.99], [0.07,12.59], [0.58,9.43], [1.49,6.60], [2.78,4.17], [4.41,2.21], [6.34,0.81], [8.55,0.05], [10.89,0], [13.19,0.64], [15.39,1.91], [17.44,3.74], [19.28,6.08], [20.85,8.87], [22.09,12.03], [22.95,15.51], [23.36,19.08], [23.29,22.47], [22.78,25.63], [21.87,28.46], [20.58,30.89], [18.96,32.84], [17.02,34.24], [14.81,35],   [12.43,30.78], [13.10,30.73], [14.35,30.23], [15.41,29.26], [16.95,26.11], [17.59,21.74], [17.19,16.59], [15.78,11.62], [13.66,7.73], [11.12,5.31], [9.78,4.77], [8.45,4.74], [7.20,5.23], [6.13,6.20], [4.59,9.36], [3.95,13.73], [4.35,18.88], [5.65,23.57], [7.59,27.32], [9.92,29.83] ],
    [ [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30], [31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50] ],
    [23.36,35.13],
    [78.16,-216.65]
];


outline = [
    [ [74.14,92.11], [71.98,91.83], [69.87,90.98], [67.85,89.60], [65.98,87.74], [62.86,82.82], [60.89,76.60], [60.42,72.26], [60.66,68.20], [61.53,64.57], [63,61.52], [38.33,72.91], [38.93,79.44], [36.06,79.17], [33.67,70.90], [65.14,52.20], [65.08,45.80], [64.52,39.94], [62.86,31.39], [60.47,23.15], [58.48,18.07], [55.79,13.25], [52.02,19.32], [45.76,28.19], [41.55,32.90], [39.24,34.43], [36.57,34.79], [33.89,33.91], [31.50,32.03], [29.06,29.08], [26.23,24.99], [22.26,18.01], [18.57,11.40], [16.57,8.14], [14.38,5.30], [12.22,5.03], [9.19,5.65], [6.29,6.81], [4.50,8.20], [4.63,11.13], [3.35,12.40], [1.44,12.65], [0.57,10.82], [0,7.94], [0.28,7.03], [1.16,5.92], [4.07,3.47], [7.32,1.36], [9.53,0.36], [11.92,0], [15.85,0.22], [18.61,3.01], [21.42,6.92], [26.53,15.26], [31.37,22.92], [34.15,25.81], [35.65,26.66], [37.24,26.99], [38.40,26.76], [39.49,26.08], [41.45,23.65], [44.75,16.73], [48.14,10.13], [52.12,5.12], [54.08,3.36], [56.44,1.87], [59.16,0.85], [62.19,0.45], [65.28,1.08], [68.12,2.83], [70.67,5.40], [72.87,8.45], [76.44,15.44], [77.90,19.65], [79.14,24.59], [79.99,30.49], [80.24,36.97], [79.85,43.29], [78.74,48.73], [76.67,54.11], [74.50,58.58], [77.37,60.87], [79.87,64.10], [81.85,68.13], [83.16,72.77], [83.59,76.30], [83.56,79.66], [83.09,82.78], [82.21,85.58], [80.96,87.97], [79.37,89.90], [77.47,91.26], [75.29,92],   [72.85,88.38], [73.55,88.34], [74.87,87.85], [76,86.88], [77.64,83.72], [78.34,79.31], [77.96,74.11], [76.51,69.09], [74.31,65.15], [71.66,62.69], [70.25,62.13], [68.84,62.08], [67.53,62.57], [66.40,63.54], [64.76,66.70], [64.06,71.11], [64.44,76.30], [65.78,81.04], [67.78,84.85], [70.22,87.40],   [71.49,52.13], [71.90,52.13], [72.90,51.75], [73.86,50.68], [75.14,44.24], [75.64,37.89], [75.51,32.09], [74.89,27.27], [73.68,22.32], [71.66,16.49], [68.87,10.82], [67.20,8.36], [65.33,6.34], [63.71,6.54], [61.73,7.61], [59.99,9.09], [59.06,10.58], [64.18,20.99], [67.19,30.31], [68.76,39.83], [69.51,51.50] ],
    [ [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92], [93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112], [113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133] ],
    [83.59,92.11],
    [107.67,-276.61]
];


arm = [
    [ [2.29,30.21], [0,21.68], [35.37,0], [35.13,9.91], [5.11,23.96], [5.81,30.52] ],
    [ [0,1,2,3,4,5] ],
    [35.37,30.52],
    [51.34,-224.81]
];


phone = [
    [ [35.39,123.81], [45.26,120.93], [9.86,0], [0,2.89] ],
    [ [3,2,1,0] ],
    [45.26,123.81],
    [112.18,-271.53]
];


headOuter = [
    [ [22.98,15.46], [21.77,10.97], [19.90,6.99], [17.49,3.71], [14.63,1.33], [11.57,0.07], [8.57,0], [5.78,1.10], [3.35,3.35], [1.50,6.58], [0.37,10.49], [0,14.87], [0.43,19.50], [1.63,23.99], [3.50,27.96], [5.92,31.24], [8.78,33.62], [11.83,34.88], [14.83,34.95], [17.62,33.85], [20.05,31.60], [21.90,28.37], [23.03,24.46], [23.41,20.09] ],
    [ [23,22,21,20,19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0] ],
    [23.41,34.95],
    [78.14,-216.59]
];


bodyInner = [
    [ [10.40,44.94], [12.31,45.40], [13.35,45.07], [14.29,44.05], [15.08,40.39], [15.89,35.21], [16.15,28.61], [15.25,20.70], [13.37,13.25], [11.13,7.61], [8.59,3.35], [5.81,0], [3.64,0.59], [1.85,1.74], [0,4.01], [4.09,11.99], [6.16,17.14], [8,23.42], [9.10,29.79], [9.85,36.85] ],
    [ [19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0] ],
    [16.15,45.40],
    [77.22,-267.54]
];


body = [
    [ [18.03,59.52], [12.21,59.08], [12.46,57.99], [12.71,53.95], [12.23,45.82], [10.29,32.43], [9.11,27.22], [7.65,22.83], [4.39,15.97], [1.51,10.85], [0.52,8.61], [0,6.43], [0.47,4.11], [2.32,2.15], [5.39,0.73], [9.51,0], [11.94,0.36], [14.57,1.70], [17.26,3.98], [19.89,7.12], [22.34,11.07], [24.48,15.77], [26.18,21.15], [27.33,27.16], [27.89,33], [27.97,38.04], [27.62,42.40], [26.92,46.21], [24.70,52.70], [21.84,58.58], [20.19,59.26],   [18.66,51.70], [19.84,51.43], [20.91,50.34], [21.70,46.68], [22.52,41.50], [22.77,34.90], [21.87,27], [19.99,19.54], [17.75,13.91], [15.21,9.65], [12.43,6.30], [10.25,6.89], [8.47,8.04], [6.62,10.31], [10.71,18.29], [12.78,23.44], [14.62,29.72], [15.72,36.09], [16.46,43.15], [17.02,51.23] ],
    [ [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30], [31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50] ],
    [27.97,59.52],
    [70.60,-273.83]
];


path2984 = [
    [ [74.14,92.11], [71.98,91.83], [69.87,90.98], [67.85,89.60], [65.98,87.74], [62.86,82.82], [60.89,76.60], [60.42,72.26], [60.66,68.20], [61.53,64.57], [63,61.52], [38.33,72.91], [38.93,79.44], [36.06,79.17], [33.67,70.90], [65.14,52.20], [65.08,45.80], [64.52,39.94], [62.86,31.39], [60.47,23.15], [58.48,18.07], [55.79,13.25], [52.02,19.32], [45.76,28.19], [41.55,32.90], [39.24,34.43], [36.57,34.79], [33.89,33.91], [31.50,32.03], [29.06,29.08], [26.23,24.99], [22.26,18.01], [18.57,11.40], [16.57,8.14], [14.38,5.30], [12.22,5.03], [9.19,5.65], [6.29,6.81], [4.50,8.20], [4.63,11.13], [3.35,12.40], [1.44,12.65], [0.57,10.82], [0,7.94], [0.28,7.03], [1.16,5.92], [4.07,3.47], [7.32,1.36], [9.53,0.36], [11.92,0], [15.85,0.22], [18.61,3.01], [21.42,6.92], [26.53,15.26], [31.37,22.92], [34.15,25.81], [35.65,26.66], [37.24,26.99], [38.40,26.76], [39.49,26.08], [41.45,23.65], [44.75,16.73], [48.14,10.13], [52.12,5.12], [54.08,3.36], [56.44,1.87], [59.16,0.85], [62.19,0.45], [65.28,1.08], [68.12,2.83], [70.67,5.40], [72.87,8.45], [76.44,15.44], [77.90,19.65], [79.14,24.59], [79.99,30.49], [80.24,36.97], [79.85,43.29], [78.74,48.73], [76.67,54.11], [74.50,58.58], [77.37,60.87], [79.87,64.10], [81.85,68.13], [83.16,72.77], [83.59,76.30], [83.56,79.66], [83.09,82.78], [82.21,85.58], [80.96,87.97], [79.37,89.90], [77.47,91.26], [75.29,92],   [72.85,88.38], [73.55,88.34], [74.87,87.85], [76,86.88], [77.64,83.72], [78.34,79.31], [77.96,74.11], [76.51,69.09], [74.31,65.15], [71.66,62.69], [70.25,62.13], [68.84,62.08], [67.53,62.57], [66.40,63.54], [64.76,66.70], [64.06,71.11], [64.44,76.30], [65.78,81.04], [67.78,84.85], [70.22,87.40],   [71.49,52.13], [71.90,52.13], [72.90,51.75], [73.86,50.68], [75.14,44.24], [75.64,37.89], [75.51,32.09], [74.89,27.27], [73.68,22.32], [71.66,16.49], [68.87,10.82], [67.20,8.36], [65.33,6.34], [63.71,6.54], [61.73,7.61], [59.99,9.09], [59.06,10.58], [64.18,20.99], [67.19,30.31], [68.76,39.83], [69.51,51.50] ],
    [ [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92], [93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112], [113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133] ],
    [83.59,92.11],
    [17.87,-274.04]
];


leg = [
    [ [56.33,1.92], [53.75,3.65], [51.13,6.16], [47.52,10.73], [41.98,22.68], [40.58,24.91], [39.03,26.36], [37.09,26.86], [34.96,26.09], [33.27,24.80], [31.75,23.03], [20.56,5.09], [17.70,1.58], [16.13,0.09], [13.38,0], [9.28,0.32], [6.07,1.95], [3.33,3.88], [1.34,5.53], [0,7.46], [0.20,10.10], [1.42,13.04], [3.59,12.80], [4.61,12.09], [5.03,11.34], [4.84,10.06], [4.87,8.45], [5.56,7.65], [8.29,6.39], [11.56,5.49], [14.34,5.61], [17.16,9.44], [20.29,14.72], [23.89,21.42], [27.26,26.77], [29.95,30.70], [31.95,33.01], [33.97,34.22], [36.11,35.01], [38.38,35.03], [40.82,33.97], [42.98,32.15], [45.01,29.86], [48.78,24.85], [54.40,16.37], [57.57,11.15] ],
    [ [45,44,43,42,41,40,39,38,37,36,35,34,33,32,31,30,29,28,27,26,25,24,23,22,21,20,19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,0] ],
    [57.57,35.03],
    [17.74,-274.17]
];


path3766 = [
    [ [12.22,59.08], [12.46,57.99], [12.71,53.95], [12.23,45.82], [10.29,32.43], [9.11,27.22], [7.65,22.82], [4.39,15.97], [1.51,10.85], [0.52,8.61], [0,6.43], [0.47,4.11], [2.32,2.15], [5.39,0.73], [9.51,0], [11.94,0.36], [14.57,1.70], [17.26,3.98], [19.89,7.12], [22.34,11.07], [24.47,15.77], [26.18,21.15], [27.33,27.15], [27.89,33.03], [27.95,38.15], [27.60,42.62], [26.88,46.56], [24.64,53.31], [21.77,59.30], [15.70,59.42] ],
    [ [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29] ],
    [27.95,59.42],
    [70.60,-273.84]
];

