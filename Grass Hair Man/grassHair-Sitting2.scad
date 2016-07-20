use <grassHair.scad>;

module sitting2()
{

    translate([0,0,38]) head();
    body();
    
    render() {
        ntc_arrange_mirror( [0,1,0] ) {
            translate([-4,-4,-6]) rotate( [0, 0, -10] ) rotate( [0,-85,0] ) leg( footAngle=30 );
        }
    }

}

sitting2();

