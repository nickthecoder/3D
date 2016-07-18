use <ntc/tools.scad>;

DEFULT_THICKNESS=1.3;

module split(gap=1)
{

    intersection() {
        children();
        translate( [-100,0] ) square( 200, 200 );
    }

    translate( [0,-gap] ) intersection() {
        children();
        translate( [-100,-200] ) square( 200, 200 );
    }
}

module clipShape( thickness=DEFULT_THICKNESS, depth=6, angle=5, slack=0.3 )
{
    foo = depth * sin(angle);
    
    ntc_arrange_mirror() translate( [thickness*1.5+slack,0] ) rotate( angle ) square( [thickness, depth] );
    ntc_arrange_mirror() translate( [thickness*1.5+slack-foo,depth-0.2] ) square( [thickness, thickness] );
    translate( [-thickness*2-slack,0] ) square( [thickness*4+slack*2, thickness] );
}

module profile( d, thickness=DEFULT_THICKNESS )
{
    difference() {
        union() {
            children();
            square( [d+16, thickness*2], center=true );
        }
        offset( r=-thickness ) children();
    }
}

module twoPieceTube( diameter, height )
{
    linear_extrude( height ) split() profile( diameter ) children();
}


