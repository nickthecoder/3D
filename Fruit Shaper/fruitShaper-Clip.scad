/*
    Clips to hold the two halves of the fruit shaper together while the fruit is growing.
*/
use <fruitShaper.scad>;
use <ntc/tools.scad>;



ntc_arrange_grid( 2, 10, 2, 10 )

linear_extrude( 30 ) clipShape();


