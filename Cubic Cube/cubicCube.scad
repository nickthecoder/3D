/*
    The classic 1970's crazy meets 21st century 3D printing.
    Print the whole cube in one go!
*/
include <ntc/tools.scad>;

SIZE  = 69; // The size of the whole cube
THIRD = SIZE/3; // A third the size of the cube
SLACK = 0.5; // How much room between the moving pieces.
LUG = THIRD*0.5-SLACK;

PIECE= THIRD-SLACK;

INNER_D= SIZE*0.35;
MIDDLE_D = SIZE*0.4;
FOO_D = THIRD*0.7;
BIG_D = THIRD*2.2;

ROD_D=4;

module lug()
{
    difference() {
        sphere( d=BIG_D );

        // Void for center piece
        sphere( d=MIDDLE_D + SLACK*2 );
        
        // Voids for the middle pieces' cylinders
                           cylinder( d=FOO_D + SLACK*2, h=SIZE, center=true );
        rotate( [0,90,0] ) cylinder( d=FOO_D + SLACK*2, h=SIZE, center=true );
        rotate( [90,0,0] ) cylinder( d=FOO_D + SLACK*2, h=SIZE, center=true );
    }
}

module miniCube( position )
{   
    difference() {
        translate( position ) cube( PIECE );
        sphere( d=BIG_D + SLACK*2 );
    }
}

module edge()
{
    foo = -THIRD*1.5+SLACK/2;
    miniCube([foo,-THIRD/2+SLACK/2, foo]);

    // The lug
    intersection() {
        lug();
        translate([-THIRD/2,0,-THIRD/2]) cube( [THIRD*1.1,LUG,THIRD*1.1] ,center=true );
    }
    
    // Connect the miniCube to the lug.
    translate([-THIRD*0.8,0,-THIRD*0.8]) rotate([0,45,0]) cube( [LUG,LUG,THIRD*0.6], center=true );
}

module middle()
{
    difference() {
        union() {
            miniCube( [-THIRD*1.5+SLACK/2, -THIRD/2+SLACK/2, -THIRD/2+SLACK/2] );
            // ...with an extra cylinder to bring it up to size
            translate([-THIRD*0.5-SLACK/2,0,0]) rotate([0,-90,0]) cylinder( d=FOO_D, h=THIRD*0.8 );
            // The corner and edge pieces will rotate around this cylinder.
        }

        // Void for center piece
        sphere( d=MIDDLE_D + SLACK*2 );
    }
    
    // Cylinder through the middle
    translate([-THIRD*0.8,0,0]) rotate([0,90,0]) cylinder( d=ROD_D, h=THIRD, center=true );
    
    // A weird shaped lug on the end, which is allowed to rotate inside the center sphere.
    intersection() {
        sphere( d=INNER_D );
        translate( [-THIRD*0.8,0,0] ) sphere( d=INNER_D );
    }
}

module corner()
{
    foo = -THIRD*0.5-SLACK/2;
    
    difference() {
        miniCube([-foo,-foo,-foo]);

        // Void for center piece
        sphere( d=MIDDLE_D + SLACK*2 );
    }

    intersection() {
        lug();
        translate([-THIRD-LUG/2-SLACK,-THIRD-LUG/2-SLACK,-THIRD-LUG/2-SLACK]) cube( THIRD );
    }

}

/*
    The heart of the cube is actually a hollow sphere.
    There are 6 holes for the "middle" pieces to poke a cylinder through.
*/
module center()
{
    difference() {
        sphere( d=MIDDLE_D );
        
        // Hollow out the sphere
        sphere( d=INNER_D+SLACK*2 );
        
        // Holes in all six directions
        cylinder( d=ROD_D+SLACK*2, h=SIZE, center=true );
        rotate([0,90,0]) cylinder( d=ROD_D+SLACK*2, h=SIZE, center=true );
        rotate([90,0,0]) cylinder( d=ROD_D+SLACK*2, h=SIZE, center=true );

    }
}

module kernel()
{
    difference() {
        sphere( d=INNER_D );
        ntc_arrange_mirror([1,0,0]) translate( [-THIRD*0.8,0,0] ) sphere( d=INNER_D+SLACK*2 );
        rotate([0,90,0]) ntc_arrange_mirror([1,0,0]) translate( [-THIRD*0.8,0,0] ) sphere( d=INNER_D+SLACK*2 );
        rotate([0,0,90]) ntc_arrange_mirror([1,0,0]) translate( [-THIRD*0.8,0,0] ) sphere( d=INNER_D+SLACK*2 );
    }
}

module corners()
{
    ntc_arrange_mirror([1,1,1]) corner();
}

module edges()
{
    ntc_arrange_mirror([1,0,1]) edge();
    rotate([90,0,0]) ntc_arrange_mirror([1,0,1]) edge();
    rotate([0,0,90]) ntc_arrange_mirror([1,0,1]) edge();
}

module middles()
{
    ntc_arrange_mirror([1,0,0]) middle();
    ntc_arrange_mirror([0,0,1]) rotate([0,90,0]) middle();
    ntc_arrange_mirror([0,1,0]) rotate([0,0,90]) middle();
}

/*
    Arrange all of the pieces, to form a complete cube
*/
module wholeCube()
{
    edges();
    middles();
    corners();  
    center();
    kernel();
}

/*
    The various intersections should be NOTHING - i.e. the different kind of pieces don't overlap
*/
module test()
{
    intersection() {
        center();
        corners();
    }
    
    intersection() {
        center();
        middles();
    }
    
    intersection() {
        center();
        edges();
    }
    
    
    intersection() {
        corners();
        middles();
    }
    
    intersection() {
        corners();
        edges();
    }
    
    intersection() {
        middles();
        edges();
    }
        
}

module rounded(r=3)
{
    intersection() {
        hull() {
            ntc_arrange_mirror([1,1,1]) translate( [SIZE/2-r,SIZE/2-r,SIZE/2-r] ) sphere( r );
        }
        children();
    }
}

/*
    One of each piece - useful during development, and to see how it works.
*/
module single()
{
    color([1,0,0]) edge();
    color([0,0,1]) corner();
    color([0,1,1]) middle();
    center();

    rotate([90,0,0]) color([1,0,0]) edge();

}

module inspect(angle=0, h=0)
{
    intersection() {
        translate( [0,0,SIZE*h] ) rotate([0,angle,0]) cube( [1000,1000,1], center=true );
        children();
    }
}

$fa=6;
$fs=0.8;

//single();
//test();

rounded()
//inspect(0,0.32)
wholeCube();

//ntc_arrange_mirror([1,0,0]) middle();
//ntc_arrange_mirror([0,1,0]) rotate([0,0,90]) middle();

//%center(0);
//kernel();


