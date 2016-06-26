include <ink2scad_tools.scad>;
use <ntc/tools.scad>;
include <generated_mobilePhoneStand.scad>;

module simple_phoneHolder( h, chamfer_size, rough=true )
{
    difference(convexity=20) {
        linear_extrude( h, convexity=20 ) ink2scad( outline );
        if ( ! rough ) {
            translate( [0,0,h] ) mirror([0,0,1]) ink2scad_extrude_along_edges( outline ) ink2scad_chamfer(chamfer_size);
        }
    }
}

module piece( data, thickness, chamferSize=2, chamferBothSides=false, rough=true, relativeTo )
{
    if ( relativeTo ) {
        translate( data[3] - relativeTo[3] ) piece( data, thickness, chamferSize, chamferBothSides, rough );
    } else {
        difference() {
            linear_extrude( thickness ) ink2scad( data );
            translate([0,0,thickness]) ink2scad_extrude_along_edges( data, rough=rough ) ink2scad_chamfer( chamferSize );

            if ( chamferBothSides ) {
                ink2scad_extrude_along_edges( data, rough=rough ) ink2scad_chamfer( chamferSize );
            }
        }
    }
}

module phoneHolder( bodyWidth=30, headWidth=17, legWidth=10, armWidth=8, chamferSize=2, rough=true )
{
    piece( body, bodyWidth/2, chamferSize=chamferSize,rough=rough );
    piece( head, headWidth/2, chamferSize=chamferSize, relativeTo=body, rough=rough );
    translate([0,0,bodyWidth/2-armWidth]) piece( arm, armWidth, chamferSize=chamferSize, relativeTo=body, rough=rough, chamferBothSides=true );
    translate([0,0,bodyWidth/2-legWidth]) piece( leg, legWidth, chamferSize=chamferSize, relativeTo=body, rough=rough, chamferBothSides=true );
}

// Rough
//phoneHolder();

// Final, but very slow :
ntc_arrange_mirror( [0,0,1] ) render() phoneHolder( rough=false );

