/*
    Grow cucumbers or other fruit inside the tube to force it into a heart shape when sliced.
*/
use <fruitShaper.scad>;
include <generated-fruitShapes.scad>;

module heartShape( d )
{
    translate([0,-d*0.18]) scale( d/10 ) ink2scad( heart, center=true );
}

height=120;
diameter=40;

twoPieceTube( diameter, height ) heartShape( diameter );

