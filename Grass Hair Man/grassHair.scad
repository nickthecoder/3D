/*
    Decorative figures. Grow grass seed in their head, for spikey green hair.
    
    Print Notes
        Support Everywhere
        Small layer height recommended, as there are lot of overhangs.
*/

include <generated-grassHair.scad>;
include <ink2scad_tools.scad>;
include <ntc/tools.scad>;

ROUGH=true;

module head()
{
    rotate_extrude() {
        ink2scad( headProfile );
    }
}

module body()
{
    
    hull() {
        translate([-4,0,26]) scale([1, 1.2, 1]) sphere( d=30 );
        translate([-2,0,0]) rotate( [0,20,0] ) scale( [1.1, 1.3, 1.3] ) sphere( d=35 );
    }
}

module leg( length=16, extra=6, footAngle=-30, dx=0, dy=-6 )
{    
    hull() {
        scale([ 1, 1, 1.1 ]) sphere( d=33 );
        
        rotate([0,0,footAngle]) translate( [dx,dy,-length ] ) {
            linear_extrude(1) ink2scad( anklePath, center=true );
        }
    }
    
    rotate([0,0,footAngle]) {
        translate( [dx,dy,-length-extra] ) {
            linear_extrude( extra ) ink2scad( anklePath, center=true );
        }
            
        translate( [dx,dy,-length-extra] ) {
            foot();
        }
    }
}

module foot()
{
    curve = 3;
    hull() {

        linear_extrude(1) ink2scad( anklePath, center=true );

        ink2scad_center( footPath, anklePath )
        translate([ 0, 0, -14]) {
            ink2scad_extrude_along_edges( footPath, rough=ROUGH ) {
                circle( r=curve );
            }
        }
    }
}


