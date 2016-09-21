/*
    Create the bottom half of the words.
        one two three four five six seven eight nine eleven twelve set mins ten o'clock.

    Why is ten not placed after nine?
        The numbers don't need to be in sequence while displaying the time, and the "ten"
        is used when setting the clock. (Pressing "Set" will cycle through setting hours, tens of minutes,
        least significant digit of the minutes and then back to telling the time).
*/

use <wordClock.scad>;

width=23;
height=4;

data = [    
    [ 0 , 0, "one" ],
    [ 5 , 0, "two" ],
    [ 10, 0, "three" ],
    [ 17, 0, "four" ],

    [ 0,  1, "five" ],
    [ 5,  1, "six" ],
    [ 9, 1, "seven" ],
    [ 16, 1, "eight" ],
    
    [ 0,  2, "nine" ],
    [ 6,  2, "eleven" ],
    [ 14, 2, "twelve" ],
    [ 22, 2, "" ],
    

    [ 0,  3, "set" ],
    [ 4, 3, "mins" ],
    [ 10,  3, "ten" ],    
    [ 14, 3, "o'clock" ],
];

mirror()
{
    words( width, height, data );

    flaps( width, height, false );

    // OnE
    thin( 1, 0.5 );
    thin( 3.7, 0.5 );
    
    // twO
    thin( 8.9, 0.5 );
    
    // thrEE
    thin( 14.4, 0.5 );
    thin( 15.65, 0.5 );
    
    // fOur
    thin( 19, 0.5 );
    
    // fivE
    thin( 3.9, -0.5 );
    
    // sEvEn
    thin( 11.25, -0.5 );
    thin( 13.7, -0.5 );
    
    // EiGht
    thin( 17.1, -0.5 );
    thin( 19.1, -0.5 );
    
    // ninE
    thin( 4.5, -1.5 );
    
    // ElEvEn
    thin( 7.15, -1.5 );
    thin( 9.15, -1.5 );
    thin( 11.45, -1.5 );
    
    // twElvE
    thin( 17.85, -1.5 );
    thin( 20.95, -1.5 );
    
    // sEt
    thin( 2.25, -2.5 );
    
    // tEn
    thin( 11.8, -2.5 );
    
    // O'clOck
    thin( 15.1, -2.5 );
    thin( 18.85, -2.5 );

}

