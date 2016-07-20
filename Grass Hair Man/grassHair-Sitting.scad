use <grassHair.scad>;

module sitting()
{

    translate([0,0,38]) head();
    body();
    
    render() {
        ntc_arrange_mirror( [0,1,0] ) {
            translate([-4,-4,-6]) rotate( [0, 0, -20] ) rotate( [0,-90,0] ) leg();
        }
    }

}

sitting();

