use <bluetoothSpeakerStand.scad>;
use <ntc/tools.scad>;


// Distance between the post holes on the wifi/amp board.
ampSpaceX = 44;
ampSpaceY = 76;

module ampBase()
{
    difference() {
        mirror([1,0,0]) base();
        flip() connectionHoles();
    }
    
    // Posts
    ntc_arrange_mirror([1,1,0]) {
        translate( [ampSpaceX/2,ampSpaceY/2,0] ) post(); 
    }

    
    // Supports running front to back
    ntc_arrange_mirror() {
        translate([ ampSpaceX/2,0,0 ]) ntc_cube( [ 8, ampSpaceY+8, 1.2 ] );
    }

}

ampBase();

%flip() cover();
