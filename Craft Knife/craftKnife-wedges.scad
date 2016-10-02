/*
    Just the wedges.
    Useful if you lose one, or if you want to use different print settings, or to print in a different colour.

    Print Notes
        High  infill density (80%), to make it strong.   
*/
use <ntc/tools.scad>;
use <craftKnife.scad>;

// Uncomment to create a batch
ntc_arrange_grid( 2,10, 2,10 )
rotate( [6,0,0] ) wedge( false );

// Note that the hard coded rotate "6", ensures that the wedge is printed flat on the print bed.
// If you change the knive's width, thickness or extraThickness, the 6 will need to be tweaked too.

