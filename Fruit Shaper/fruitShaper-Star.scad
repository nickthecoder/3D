/*
    Grow cucumbers or other fruit inside the tube to force it into a star shape when sliced.
*/
use <fruitShaper.scad>;
include <generated-fruitShapes.scad>;

module starShape( d )
{
    translate([0,-d*0.12]) scale( d/10 ) ink2scad( star, center=true );
}

height=120;
diameter=40;

twoPieceTube( diameter, height ) starShape( diameter );

