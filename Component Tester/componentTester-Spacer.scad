/*
    A simple block to allow the ZIF+button circuit board to be attached level with the top of the case.
    
    Drill holes through spacer, then use it as a template to drill holes through the top of the case.
    Place the circuit board in the case, and drill through the circuit board.
    
    Use M3 nuts and bolts to hold all three pieces together.
*/
include <ntc/tools.scad>;

difference() {
    cube( [24,13, 3], center=true );
    ntc_arrange_mirror() {
        translate([16.5/2,0,0.3]) cylinder( d=3, h=10 );
    }
}

