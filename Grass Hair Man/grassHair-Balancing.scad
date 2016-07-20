use <grassHair.scad>;

module balancing()
{
    bodyAngle=24;
    legAngle=80;
    
    rotate( [-bodyAngle,0,0] ) {
        translate([0,0,36]) rotate([bodyAngle,0,0]) head();
        body();
    }

    render() {
        translate([-6,-6,-4]) rotate([-legAngle,0,0]) leg( dx=2, dy=4, footAngle=0 );
        mirror([0,1,0]) translate([-6,-3,-6]) leg( footAngle=0 );
    }
}

balancing();
