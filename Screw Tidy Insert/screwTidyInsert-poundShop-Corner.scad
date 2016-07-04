use <screwTidyInsert.scad>;
use <ntc/tools.scad>;

/*
    Grr, I just found out that the corner compartments are rounded. Lets bodge a rounded
    version...
*/

intersection() {
    doubleTaperedCube( 44,38, 25, 1 );

    union() {
        ntc_arrange_mirror() translate([16,13,0]) rotate( [-2,2,0] ) cylinder( d=10, h=100, center=true );
        ntc_cube([44,28,25]);
        ntc_cube([34,38,25]);
        translate([0,-5,0]) ntc_cube([44,38,25]);
    }
    
}



