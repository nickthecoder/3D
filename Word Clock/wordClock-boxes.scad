/*
    Boxes to hold the LEDs.
    It is surprisingly easy to solder the LED's legs without melting the plastic.
*/
use <wordClock.scad>;
use <ntc/tools.scad>;

// Here are the sizes of the boxes (from top left to bottom right)

// 4 11 8,  9 5 4,  9 3 5.5 5.5
// 5 5 7 6,  5 4 7 7,  6 8 8,  4 6 4 9 

// I printed the wrong 2nd half, and I actually have
// 5 5 7 6,  5 4 7 7,  5 8 10,  4 6 4 9 

// So we need :
// 1x three 
// 5x fours
// 5x fives 
// 2x 5.5s 
// 3x sixes 
// 3x sevens 
// 3x eights
// 3x nines
// 1x eleven

translate( [  0,0,0] ) ntc_arrange_grid( 1,0, 5, 20 ) box( 4 );
translate( [ 25,0,0] ) ntc_arrange_grid( 1,0, 5, 20 ) box( 5 );
translate( [ 55,0,0] ) ntc_arrange_grid( 1,0, 2, 20 ) box( 5.5 );
translate( [ 55,40,0] ) ntc_arrange_grid( 1,0, 3, 20 ) box( 6 );

