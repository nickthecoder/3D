/*

I want to combine my Sony SRS X2 Bluetooth speaker and T400 Laptop, because the laptop's speakers
are a little quiet. This clip, adds a little shelf to the top of the screen for the speaker to sit on.

Print Notes :
    Support Type : Touching Build Plate
    Shell THickness : 1.6mm
    Top/Bottom Thickness : 1.6mm
    Infill : 20%
*/


THICKNESS = 1.2;

module seatProfile()
{
    difference() {
        hull() {
            circle( d=8 );
            translate([0,44]) circle( d=2 );
            translate([52,0]) circle( d=2 );
        }
        square( 100 );
    }
}
    
module clipProfile()
{
    // Clip
    d = 22;
    thick = 2;
    
    translate( [46,0,0] ) {
    
        translate( [0,-d/2] ) rotate( 160 ) {
            intersection() {
                difference() {
                    circle( d=d );
                    circle( d=d-thick*2 );
                }
                translate([0,-d]) square( d*3 );
            }    
            translate( [0,d/2-thick/2] ) circle( d=thick );
            translate( [0,- (d/2-thick/2)] ) circle( d=thick );
        }
        
        // Triangular support
        translate([ -25,0]) hull() {
            translate( [0,-17] ) circle( d=5 );
            translate( [-12.5,-THICKNESS] ) square([15,THICKNESS]);
        }
    }
}

module clip()
{
    height = 54;
    z = 5;
    
    difference() {
        linear_extrude( height, convexity=4 ) seatProfile();
        translate([-50,10, -10.5+height/2]) rotate([0,90,0]) cylinder( d=10, h=100 );
        translate([0,11,10.5+height/2]) cube( [100,8,13], center=true ) ;
    }
    
    translate([0,0,z]) linear_extrude( height-z*2 ) clipProfile();
}

clip();

