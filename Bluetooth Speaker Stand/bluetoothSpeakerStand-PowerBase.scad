use <ntc/tools.scad>;
use <bluetoothSpeakerStand.scad>;
use <bluetoothSpeakerStand-PowerCover.scad>;


module powerBase()
{
    difference() {
        base();
        connectionHoles();
        
        // Button hole
        translate( [0,-45,10] )  rotate( [90,0,0] ) cylinder( d=7, h=10, center=true );
        
        // USB Charge hole
        translate( [-20,45,7] ) ntc_cube([9,20,5]);
    }
        
    translate( [ 22, -6,0] ) rotate( [0,0,95] ) battery();
    translate( [-20,-14,0] ) rotate( [0,0,90] ) boost();
    translate( [  0,-37,0] ) buttonBottom();
    translate( [-20,45,0] ) rotate( [0,0,180] ) chargerSled();
}

powerBase();

%flip() powerCover();

