include <mazeGiftTube.scad>;

$fs = 0.5;

maze(

    solution = [
        [0,0,UP,2], [0,2,RIGHT,2], [2,2,DOWN],[2,1,RIGHT,5], [7,1,UP,3], [7,4,RIGHT,2], [9,4,DOWN,2], [9,2,RIGHT,2],
        [11,2,UP,3], [11,5,RIGHT,4], [15,5,DOWN,2], [15,3,RIGHT,2], [17,3,UP,2], [17,5,LEFT,1],[16,5,UP,2]
    ],

    //initial="L",

    others =[
        [0,1,RIGHT], [0,1,LEFT,2],
        [0,2,UP,2], [0,4,RIGHT,2], [2,4,DOWN], [2,3,LEFT],
        [2,2,RIGHT,2],
        [3,4,RIGHT],
        [5,3,DOWN], [5,3,RIGHT], [6,2,UP,2],
        [5,5,UP], [5,5,RIGHT,1], [6,5,UP],
        [3,5,UP], [3,6,LEFT,2],
        [-1,5,UP], [-1,6,RIGHT], [-1,6,LEFT, 2], [-2,6,DOWN,1],
        [9,4,RIGHT], [10,4,DOWN],
        [9,2,DOWN],
        [9,4,UP], [9,5,LEFT], [8,5,UP],
        [7,4,UP,2],
        [7,1,RIGHT], [7,2,RIGHT], [8,4,DOWN]

    ]
);


