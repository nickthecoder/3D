use <ntc/tools.scad>;

/*
    Creates tapered boxes suitable as inserts into component boxes.
    Having inserts make it easy to take out one type of screw from the container
    while working on a job.
    It is also handy to colour code the compartments. For example, having all the M6
    nuts, bolts and washers using one colour, with M4, and M8 using difference colours.
*/

module taperedSquare( w, h, taper )
{
    polygon( [ [-w/2+taper,0], [-w/2,h], [w/2,h], [w/2-taper,0] ] );
}   

module taperedCube( l, w, d,  taper )
{
    translate( [0,w/2,0] ) rotate([90,0,0]) 
    linear_extrude( w ) {
        taperedSquare( l, d, taper );
    }
}

module doubleTaperedCube( l, w, d, taper )
{
    intersection() {
        taperedCube( l,w,d, taper );
        rotate( [0,0,90] ) taperedCube( w, l, d, taper );
    }

}

module insert( l, w, d, taper = 2, thickness=0.5, base=0.9 )
{
    difference() {
        doubleTaperedCube( l,w,d, taper );
        translate( [0,0,base] ) doubleTaperedCube( l-thickness*2, w-thickness*2, d, taper );
    }
}

/*
    A standard size insert.
        x,y : The size 1,1 is the smallest box
        
        My containers use sizes : 1x1, 2x1, 2x2, 4x1, 2x4
        
    My printer can't do the last one, and the 4x1 may just fit in if I rotate it. However, I need lots of
    small inserts rather than the large ones (which is why I need to print out more small ones!).
    
    With feet, you'll need to print with supports.
*/
module standardInsert( x=1, y=1, feet=true )
{
    width = x * 39;
    depth = y * 54;
    height = 44.5;
    taper = 1;
    footR = 2;
    footH = 1.5;
    
    insert( width, depth, height, taper=taper );
    
    if (feet) {
        ntc_arrange_mirror( [1,1,0] ) translate( [width/2-taper-footR, depth/2-taper-footR, -footH] ) foot( footR, footH );
        if ( x == 4 ) {
            ntc_arrange_mirror( [0,1,0] ) translate( [0, depth/2-taper-footR, -footH] ) {
                foot( footR, footH );
            }
        }        
        if ( y == 4 ) {
            ntc_arrange_mirror( [1,0,0] ) translate( [width/2-taper-footR, 0, -footH] ) {
                foot( footR, footH );
            }
        }        
    }
}

module foot( r, height=1.5 )
{
    cylinder( r=r, h=height );
}

/*
translate( [70,100,0]) standardInsert(2,2);

translate( [210,0,0]) standardInsert(4,1);

translate( [70,-160,0]) standardInsert(2,4);
*/

