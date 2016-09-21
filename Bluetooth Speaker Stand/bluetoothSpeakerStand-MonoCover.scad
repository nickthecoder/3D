use <bluetoothSpeakerStand.scad>;
use <ntc/tools.scad>;

module monoCover()
{
    difference() {
        cover();
        
        // Power button hole
        translate( [0,-45,10] ) ntc_cube( [20,30,30] );

        // USB charger hole
        translate( [-30,40,6] ) ntc_cube( [44,20,20] );
    }

}


monoCover();
