/*
    Attaches to a wine glass, so people know which drink is theirs at a party.

    Print Notes
    
        Using "clipped() verticalName()" need support (everwhere). I had trouble printed this, 
        so, I printed the verticalName() and the clip() separately, and glue them together.
        On closer inspection of "clipper() verticalName()", I found that Cura has a bug when printing
        such narrow supports - it was printing the supports in mid air! I had to move the print to align
        with the support lines, and adjust the support %, so that lines fell at the far left and far right.
        This is obviously not acceptable, so I've added my own support.

        glassTag() prints cleanly without any supports
        
        Use two colours (switching filament when the name is being printed on its own).
            This is after 1.5mm when using the default thickness of 3mm.
        
*/

use <ntc/tools.scad>;

DEFAULT_FONT="Rufscript";

module roundName( name, angle=22, r=20, font=DEFAULT_FONT, size=10 )
{
    count = len(name);
    
    rotate( -(count-1)/2 * angle ) {
        for (i=[0:count-1]) {
            rotate( angle*i ) {
                translate([0,-r]) text( name[i],valign="middle", halign="center", font=font, size=size );
            }
        }
    }
}

module glassTag( name, thickness=3, r=20, size=10, angle=22, outline=1, font=DEFAULT_FONT )
{
    two = len(name) * angle < 170;
    
    module names()
    {
        rotate( two ? -80 : 0 ) {
            roundName( name, angle=angle, r=r, size=size, font=font );
            if (two) {
                rotate( 160 ) roundName( name, angle=angle, r=r, size=size, font=font );
            }
        }
    }
    
    if (outline>0) {
        linear_extrude( thickness/2, convexity=14 ) {
            minkowski() {
                names();
                circle( r=outline );
            }
        }
    }
    
    color( [1,0,0] )
    linear_extrude( thickness, convexity=14 ) {
        names();
    }
    
    linear_extrude( thickness/2, convexity=6 ) {
        difference() {
            circle( r=r );
            circle( r=r-thickness );
            translate( [-thickness,0] ) square( [thickness*2,100] );
        }
    }
}


module verticalName( name, thickness=3, size=10, font=DEFAULT_FONT ,outline=1 )
{
    strip = (len(name) -0.5) * size;
    
    module name()
    {
        for ( i=[0:len(name) -1] ) {
            translate( [0,-i*size] ) text( text=name[i], size=size, font=font, halign="center", valign="top" );
        }
    }
    
    if (outline>0) {
        linear_extrude( thickness/2, convexity=15 ) {
            minkowski() {
                name();
                circle( r=outline );
            }
        }
    }
    
    color( [1,0,0] )
    linear_extrude( thickness, convexity=15 ) {
        name();
    }

    translate( [-2, -strip, 0 ] ) cube( [4, strip, thickness/2] );
    
}

module support( thickness=3, heft=1, nozzle=0.4 )
{
    #ntc_arrange_mirror() translate([thickness/2,4.5,heft+0.15]) cube( [nozzle, 5, 2.6] );

    children();
}

module clipped( heft=1, width=4 )
{
    clip( heft=heft, width=width );

    translate([-width/2,-width,0]) cube([width, width*2, 0.4]);
    
    translate( [0,-2,0] ) {
        children();
    }
}

module clip( heft=1, width=4 )
{
    module shape() {
        square( [12, heft ] );
        square( [heft,7] );
        translate( [0,6] ) square( [4,heft] );

        translate( [7,6+heft] ) difference() {
            circle( r=4, $fn=12 );
            circle( r=4-heft, $fn=12 );
            translate( [-10,0] ) square( 20 );
        }
    }
    
    translate( [-width/2, 0,0] ) rotate( [0,0,90]) rotate( [90,0,0] )
    linear_extrude( width, convexity=6 ) shape();
    
}

support() clipped() verticalName("N");

