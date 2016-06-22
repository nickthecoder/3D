include <spider.scad>;

module washer( peg=7 )
{
    difference() {
        cylinder( d=peg+surround, h=capThickness );
        translate([0,0,-1]) cylinder( d=washerD, h=capThickness + 2 );
    }
}

module strut( l, endA, endB, w=4.5, thickness=4, peg=7, curve=0, angle=0)
{
    bulge = peg+surround;

    module endPositive( type )
    {
        if ( type == FOOT ) {
            cylinder( d=w, h=thickness );
        } else {
            hull() {
                cylinder( d=bulge, h=thickness );
                rotate([0,0,angle]) translate( [16,0,0] ) cylinder( d=w, h=thickness );
            }
        }
        if (type == PEG) {
            translate( [0,0,1] ) cylinder( d=peg-slack, h=thickness*2 -1+slack );
        }

    }

    module endNegative( type )
    {
        if (type == PEG) {
            translate( [0,0,0.2] ) cylinder( d=screwD, h=thickness*2+2 );
        }
        if (type == HOLE) {
            hole(peg);
        }

        if (type == ATTACHMENT) {
            rotate([0,0,angle]) attachment(thickness);
            translate([0,0,-1]) linear_extrude(10) screwHole();
        }
    }

    difference() {

        union() {
            linear_extrude( thickness ) {
                length( l=l, w=w, curve=curve );
            }
            endPositive( endA );
            translate( [l,0,0] ) mirror( [1,0,0] ) endPositive( endB );
        }

        endNegative( endA );
        translate( [l,0,0] ) mirror( [1,0,0] ) endNegative( endB );

    }
}

module extraHole( x, y=0, peg=7, thickness=4 )
{
    difference() {
        union() {
            translate([x,y,0]) cylinder(d=peg+surround, h=thickness);
            children();
        }
        translate([x,y,0]) hole(d=peg);
    }
}

module screwHole()
{
    circle( d=screwD );
}


module washers(n=3)
{
    for ( i = [0:n-1]) {
        translate( [-12,i * 12,0] ) washer();
    }
}

module pieces()
{
    // Longest (shin)
    translate([0,8,0]) extraHole( 20, 7 ) strut( 100, HOLE, FOOT, curve=250, angle=20 );
    
    // Thigh
    translate([25,0,0]) strut( 50, PEG, ATTACHMENT , curve=150, angle=13 );

    // Inner thigh
    translate([0,30,0]) strut( 40, PEG, PEG, curve=110, angle=13 );
    
    // Arm pit
    translate([62,30,0]) strut( 22, ATTACHMENT, HOLE );

    washers(3);
}


//mirror([1,0,0]) pieces();
pieces();
//washers( 3 );


