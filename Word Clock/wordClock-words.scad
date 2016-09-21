/*
    Create the top half of the words.
        It's just_gone,nearly twenty five ten quarter to half past
*/

use <wordClock.scad>;

width=23;
height=3;

data = [
    [ 0,   0, "It's" ],
    [ 4,   0, "just gone" ],
    [ 15,  0, "nearly" ],
    
    [ 3,   1, "twenty" ],
    [ 12,  1, "five" ],
    [ 17,  1, "ten" ],
    [ 21,  1, "" ],

    [ 0,   2, "quarter" ],
    [ 9,   2, "to" ],
    [ 12,  2, "half" ],
    [ 17.5,2, "past" ],
];


mirror() {

    words( width, height, data );

    flaps( width, height );

    // GOnE
    thin( 10.4, 0.5 );
    thin( 11.65, 0.5 );
    thin( 14.3, 0.5 );

    // nEArly
    thin( 17.6, 0.5 );
    thin( 18.7, 0.15 );

    // twEnty
    thin( 6.9, -0.5 );

    // fivE
    thin( 16, -0.5 );

    // tEn
    thin( 18.9, -0.5 );

    // QuArtEr
    thin( 1.15, -1.6 );
    thin( 3.85, -1.85 );
    thin( 6.95, -1.5 );

    // tO
    thin( 10.9, -1.5 );

    // hAlf
    thin( 14.48, -1.85 );

    // PAst
    thin( 18.6, -1.5 );
    thin( 20, -1.85 );

}

