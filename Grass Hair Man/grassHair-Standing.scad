use <grassHair.scad>;


module standing()
{

    translate([0,0,38]) head();
    body();
    
    render() {
        ntc_arrange_mirror( [0,1,0] ) {
            translate([-6,-6,-6]) leg();
        }
    }
}

standing();

