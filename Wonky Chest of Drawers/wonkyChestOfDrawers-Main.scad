include <wonkyChestOfDrawers.scad>;
include <generated.scad>;
include <ink2scad_tools.scad>;

rough=false;

module chest( depth=30, overhang=6, slack=0.5, backThickness=1.5, chamferSize=1 )
{
    module cutDrawer( drawer )
    {
        offset( slack ) ink2scad( drawer, relativeTo=main );
    }
    
    module chamferDrawer( drawer )
    {
        ink2scad_relativeTo(drawer, main) {
            translate( [0,0,depth] ) {
                ink2scad_extrude_along_edges( drawer, rough=rough ) ink2scad_chamfer( chamferSize+slack );
            }
        }
    }
    

    difference() {
        union() {
            // The back
            linear_extrude( backThickness, convexity=6 ) {
                ink2scad( back, relativeTo=main );
            }
            // The top
            linear_extrude( depth+overhang, convexity=4 ) {
                ink2scad( top, relativeTo=main );
            }

            
            // The main part
            linear_extrude( depth, convexity=6 ) {
                difference() {
                    ink2scad( main );
                    cutDrawer( drawer1 );
                    cutDrawer( drawer2 );
                    cutDrawer( drawer3 );
                    cutDrawer( drawer4 );

                    
                }
            }
        }

        ink2scad_relativeTo(back, main) ink2scad_extrude_along_edges( back, rough=rough ) ink2scad_chamfer( chamferSize );
        translate( [0,0,depth] ) ink2scad_extrude_along_edges( main, rough=rough ) ink2scad_chamfer( chamferSize );
        chamferDrawer( drawer1 );
        chamferDrawer( drawer2 );
        chamferDrawer( drawer3 );
        chamferDrawer( drawer4 );
    
        
        translate( [0,0,depth+overhang] ) {
            ink2scad_relativeTo(top, main) {
                ink2scad_extrude_along_edges( top, rough=rough ) ink2scad_chamfer( chamferSize );
            }
        }
    
    }

}

if (rough) {
    chest();
} else {
    render() chest();
}

