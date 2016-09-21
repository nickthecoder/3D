use <bluetoothSpeakerStand.scad>;
use <ntc/tools.scad>;

module monoBase()
{
    difference() {
        base();

        // Button hole
        translate( [0,-45,10] )  rotate( [90,0,0] ) cylinder( d=7, h=10, center=true );
        
        // USB Charge hole
        translate( [-20,45,7] ) ntc_cube([9,20,5]);

    }

    translate( [ 0, -20,0] ) rotate( [0,0,0] ) battery();
    translate( [-16,3,0] ) rotate( [0,0,0] ) boost();
    translate( [18,18,0] ) rotate( [0,0,95] ) monoModule();
    translate( [  0,-37,0] ) buttonBottom();
    translate( [-20,45,0] ) rotate( [0,0,180] ) chargerSled( l=26.6 );

}

mirror([1,0,0]) monoBase();
//%flip() monoCover();

