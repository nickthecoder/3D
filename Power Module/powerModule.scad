use <ntc/tools.scad>;

boardX = 74.5;
boardY = 43;
boardZ = 1.5;

caseX = boardX + 6;
caseY = 45;
frontZ = 12;

endThickness=1;
thickness=1.4;
endWidth=4;
angle=25;
slack=0.4;

module quad( a, width, height )
{
    polygon( [ [0,0], [width,0], [width, height + tan(a) * width], [0,height] ] );
}

module board()
{
    translate([boardX/2, boardY/2, 0]) {
    
        ntc_arrange_mirror() translate( [41/2, -14,0] ) cylinder( d=7, h= 10 );
        ntc_arrange_mirror() translate( [57/2, -14,0] ) cylinder( d=7, h= 10 );
    
        difference() {
            ntc_cube( [boardX, boardY, boardZ] );
            ntc_arrange_mirror( [1,1,0] ) {
                translate([35, 19, -1]) cylinder( d=2.5, h=10 );
            }
        }
    }
    
    // The display
    translate( [21.5, 3,0] ) cube( [33, 23, 7.5] );
}

module profile()
{
    quad( angle, caseY, frontZ );
    translate( [caseY, 0] ) rotate(90) quad( angle, 38, 12 );
}

module case()
{
    difference() {    

        linear_extrude( caseX, convexity=10 ) {
            difference() {
                profile();
                offset( -thickness ) profile();
                // Uncomment to remove the base (for easier construction).
                //translate( [thickness,-thickness] ) square( [caseY-thickness*2, thickness*3] );
            }
        }

        rotate([-90,0,0]) rotate([0,0,-90]) rotate( [angle,0,0] ) translate( [(caseX-boardX)/2,6,4] ) board();
    }
}

module end()
{
    difference() {
        linear_extrude(endWidth, convexity=4) {
            offset( r=thickness+slack, $fn=30 ) {
                profile();
            }
        }
        
        translate([0,0,endThickness]) linear_extrude( endWidth ) {
            offset( delta=slack ) profile();
        }
    }
    
    linear_extrude( 11, convexity=4 ) {
        translate([4,7.5]) rotate(angle) square( 4 );
        translate([38,23.5]) rotate(angle) square( 4 );
    }
    linear_extrude( 5, convexity=4 ) {
        translate([thickness+slack*2,thickness+slack]) square( [6,3] );
        translate([caseY-thickness-slack*2-6,thickness+slack]) square( [6,3] );
    }
}

module leftEnd()
{
    difference() {
        end();
    }
}

module rightEnd()
{
    rotate([180,0,0])
    difference() {
        mirror([0,0,1]) end();

        translate([30,30,-5]) cylinder( d=5, h=10 );
        translate([30,10,-5]) cylinder( d=5, h=10 );
        
        //translate([40,13,-5]) cylinder( d=5, h=10 );
        //translate([21,6,-5]) cylinder( d=5, h=10 );
    }
}


module test()
{
    %rotate( [0,0,90] ) rotate( [90,0,0] ) case();

    translate( [-thickness-slack,0,0] ) rotate( [0,0,90] ) rotate( [90,0,0] ) end();
    //mirror([1,0,0]) translate( [-caseX-thickness-slack,0,0] ) rotate( [0,0,90] ) rotate( [90,0,0] ) end();

    rotate( [angle,0,0] ) translate( [(caseX-boardX)/2,6,3.4] ) board();
}

test();

