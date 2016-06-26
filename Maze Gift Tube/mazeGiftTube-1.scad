include <mazeGiftTube.scad>;

$fs = 0.5;

// To customize this, look at the variables at the top of "mazeGiftTube.scad"
// and change any of their values here, as well as your customised cover.

// These mazes take a long time to preview, therefore, while designing the maze, use the "test_maze" module
// and when you are happy with the results, use the "maze" module to render the real object.

// Parameters "solution" and "others" are lists of tuples in the form [x,y,direction,length],
// where direction is UP/DOWN/LEFT/RIGHT, and length is optional (the default is 1).
// The only difference between "solution" and "others" is that they are drawn in different colours when using
// the test_maze module (which I find helpful when designing a maze).
maze(

    solution = [
        [0,0,UP], [0,1,RIGHT], [1,1,UP], [1,2,RIGHT,3],
        [4,2,DOWN], [4,1,RIGHT,5], [9,1,UP], [9,2,LEFT,2], [7,2,UP],
        [7,3,RIGHT,3], [10,3,UP,2], [10,5,LEFT,3],
        [7,5,LEFT,2], [5,5,UP], [5,6,LEFT,2], [3,6,UP]
    ],

    //initial="M",
  
    others =[
        [2,1,UP], [6,1,UP],
        [9,1,RIGHT], [10,1,UP], [10,2,RIGHT],
        [4,2,UP,2], [4,4,RIGHT,2], [6,4,DOWN],
        [2,4,RIGHT,2],
        [1,2,UP ], [1,3,LEFT],
        [2,3, UP, 2],
        [0,6,RIGHT,3],
        [7,5,DOWN],
        [10,4,RIGHT,2], [12,4,UP], [12,5, LEFT],
        [10,5,UP], [10,6,LEFT,3]
    
    ]

);

