/*
    Boxes to hold the LEDs.
    It is surprisingly easy to solder the LED's legs without melting the plastic.
*/
use <wordClock.scad>;
use <ntc/tools.scad>;

translate( [124,0] ) ntc_arrange_grid( 1,0, 3, 20 ) box( 7 );
translate( [166,0] ) ntc_arrange_grid( 1,0, 3, 20 ) box( 8 );
translate( [166,60] ) ntc_arrange_grid( 1,0, 3, 20 ) box( 9 );

translate( [164,60] ) rotate(90) box( 11 );
translate( [128,60] ) box( 3 );


/*
translate( [124,0] ) box( 9 );
translate( [124,-20] ) box( 10 );
*/
