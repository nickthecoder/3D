use <ntc/tools.scad>;
use <cobLEDStripClip-Narrow.scad>;


module doubleClip(w, heft, size, thickness, hole)
{
    ntc_arrange_mirror([0,1,0]) singleClip( w, heft, size, thickness, hole );
}

// Uncomment to create a batch
ntc_arrange_grid( 2, 24, 3, 24 )

doubleClip(15, 2.5, 6, 2, 4.5 );

