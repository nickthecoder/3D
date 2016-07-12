pitch=2.55;
width = 10;
thickness=0.6;
height=thickness + 4.1;
extra=2;
roundness=1.5;
textHeight=1;

module button(x,y)
{
    translate( [x*pitch, y*pitch] ) {
        difference() {
            union() {
                translate( [0,0,height-roundness] ) rotate_extrude( angle = 360, convexity = 6 ) {
                    translate( [width/2-roundness,0] ) circle( r=roundness, $fn=10 );
                }
                cylinder( d=width, h=height-roundness );
                cylinder( d=width-roundness*2, h=height );
            }
            translate( [0,0,height-textHeight] ) linear_extrude( textHeight+1 ) children();
        }
    }
}

module base(x,y)
{
    translate( [x*pitch, y*pitch] ) {
        cylinder( d=width+extra*2, thickness );
    }
}

module letter( t )
{
    text( t=t, halign="center", valign="center" );
}

module arrow()
{
    circle( d= width-roundness-2, $fn=3 );
}

module minus()
{
    square( [width-roundness-2, 2], center=true );
}

module plus()
{
    minus();
    rotate( 90 ) minus();
}

