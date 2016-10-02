/*
    A saftey cover for the blade while not in use.
    
    Note, there will be a small piece of blade showing, but impossible to touch it. In fact this could be
    consdered a feature, as you can cut string without taking off the cover!
    
    Print Notes
        To get a perfect fit, you will have to play with GAP.
        However, quick and simple way is to print it a little too big, and jam a piece a paper down the end!
        I think it works better with the paper, as it is easy to insert the blade, and only gets snug when the
        blade is 80% of the way in.
        
        THICKNESS should be a multiple of the printer's nozzle width, so that the lines are clean and smooth.
*/

use <craftKnife.scad>;
use <ntc/tools.scad>;

GAP=0.8;
THICKNESS=0.8;

module cover()
{
    rotate([90,0,0])
    difference() {
        scale([1.1,1.1,1]) bladeHole(THICKNESS*2+GAP);
        bladeHole(THICKNESS);
        translate([-23,20,-5]) rotate([0,0,-55]) cube([100,100,10]);
    }
}

ntc_arrange_grid(1,0,4,4) cover();

