use <cobLEDStripClip.scad>;
use <ntc/tools.scad>;

module doubleClip(w, heft, size, thickness, hole)
{
    extra = hole*2;

    rotate([-90,0,0]) {
        difference() {
            ntc_arrange_mirror([0,0,1]) {
                translate([0,-thickness-heft-0.5,0]) holelessClip(w,heft,size, thickness, hole);
            }

            ntc_arrange_mirror() {
                // Screw holes
                translate( [w/2+extra/2,0,0] ) rotate( [90,0,0]) cylinder( d=hole, h=50, center=true );
            }
        }
    }
}

doubleClip(15, 2.5, 6, 2, 4.5 );
