include <generated.scad>;

postRadius = 6.2;
postDistance = 71;

module holes()
{
    for ( x=[-postDistance/2,postDistance/2] ) {
        translate( [x, -1, 0] )
        rotate( [-90,0,0] )
        cylinder( r=postRadius, h = 10 );
    };
    
    translate( [0,-96,0] ) rotate_extrude() translate( [120,0] ) circle(r=4);

}

module main(h)
{
    difference() {
        translate( [0,0, -h/2] ) translate( [ -filamentGuide[2][0]/2,0,0] ) linear_extrude( h, convexity=10 ) ink2scad( filamentGuide );
        holes();
    };
    
    %translate( [ -filamentGuide[2][0]/2,0,h/2] ) linear_extrude(1) ink2scad( alice, relativeTo=filamentGuide );
}

main(16);
