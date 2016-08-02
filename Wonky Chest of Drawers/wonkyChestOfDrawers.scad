use <ink2scad_tools.scad>;

rough=false;

module drawer( drawer, handle, depth=28, thickness=3, handleSize=4, offset=0, chamferSize=1 )
{
    if (rough) {
        drawer2( drawer, handle, depth, thickness, handleSize, offset, chamferSize );
    } else {
        render()
        drawer2( drawer, handle, depth, thickness, handleSize, offset, chamferSize );
    }
}

module drawer2( drawer, handle, depth=28, thickness=3, handleSize=4, offset=0, chamferSize=1 )
{    
    difference() {
    
        linear_extrude( depth, convexity=6 ) {
            ink2scad( drawer, center=true );
        }
        
        translate( [0,0,thickness] ) linear_extrude( depth - thickness*2, convexity=6 ) {
            hull() {
                offset( -thickness ) ink2scad( drawer, center=true );
                translate([offset,20]) scale(0.8) ink2scad( drawer, center=true );
            }
        }
        
        ink2scad_center(drawer) ink2scad_extrude_along_edges( drawer, rough=rough ) ink2scad_chamfer( chamferSize );
        translate( [0,0,depth] ) ink2scad_center(drawer) ink2scad_extrude_along_edges( drawer, rough=rough ) ink2scad_chamfer( chamferSize );
    }
    
    translate([0,0,depth-0.1]) linear_extrude( handleSize ) {
        ink2scad( handle, relativeTo=drawer, center=true );
    }
}

