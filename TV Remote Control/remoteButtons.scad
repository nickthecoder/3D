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

module power()
{
    button(0,0) letter("x");
    button(15,0) letter("X");
    
    hull() {
        base(0,0);
        base(15,0);
    }
}

module three()
{
    button(0,0);
    button(0,4);
    button(0,8);

    hull() {
        base(0,0);
        base(0,8);
    }
}

module leftRight()
{    
    button(5,-3) rotate(180) arrow();
    button(10,-3) arrow();
    
    hull() {
        base(5,-3);
        base(10,-3);
    }
}


module volume()
{    
    button(0,6) plus();
    button(0,0) minus();
    
    hull() {
        base(0,6);
        base(0,0);
    }
}

module arrows()
{
    button(0,0) letter("ok");
    button(-4,0) rotate(180) arrow();
    button(4,0) arrow();
    button(0,4) rotate(90) arrow();
    button(0,-4) rotate(-90) arrow();
    
    hull() {
        base(4,0);
        base(-4,0);
    }
    hull() {
        base(0,4);
        base(0,-4);
    }
}

//power();
//leftRight();
//arrows();
//three();
volume();

