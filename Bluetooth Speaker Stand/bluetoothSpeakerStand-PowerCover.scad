use <bluetoothSpeakerStand.scad>;
use <ntc/tools.scad>;

module powerCover()
{
    mirror( [1,0,0] ) difference() {
        cover();
        
        // Power button
        translate( [0,-45,10] ) ntc_cube( [20,30,30] );

        // USB charger
        translate( [-30,40,6] ) ntc_cube( [44,20,20] );
    }
}

powerCover();
