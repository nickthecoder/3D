include <spider.scad>;

thickness=4;
width=8;

out=10;
in=20;
across=80;
dist=60;

module frame()
{
    module lengths( w )
    {

        diagonal = sqrt( 2 * dist*2 * across ) + 2;

        // Horizontals
        translate( [-across/2, -dist] ) length( across, w=w );
        translate([-out-across/2,0]) length( across + out*2, w=w );
        translate([-across/2,dist]) length( across,w=w );
        
        // Verticals
        translate( [-across/2, -dist] ) rotate( 90 ) length( dist*2, curve=350, w=w );
        translate( [ across/2,  dist] ) rotate(-90 ) length( dist*2, curve=350, w=w );
        
        // Diagonals
        rotate( atan( dist*2/across) ) translate( [-diagonal/2, 0] ) length( diagonal, w=w );
        rotate(-atan( dist*2/across) ) translate( [-diagonal/2, 0] ) length( diagonal, w=w );
    }
    
    module mountPoints()
    {
        translate( [-across/2+in,dist] ) children();
        translate( [ across/2-in,dist] ) children();

        translate( [-across/2-out+in,0] ) children();
        translate( [ across/2+out-in,0] ) children();

        translate( [-across/2+in,-dist] ) children();
        translate( [ across/2-in,-dist] ) children();
    }
    
    
    difference() {
        union() {
            linear_extrude( thickness ) {
                lengths( width );
            }
            mountPoints() {
               cylinder( d=12, h=thickness );   
            }
        }
    
        mountPoints() {
            topAttachment();
        }
    }
    
    translate( [0,0,thickness-0.1] ) linear_extrude( thickness + 0.1 ) {
        lengths( 2 );
    }
}


frame();
