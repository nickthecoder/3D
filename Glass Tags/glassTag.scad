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

module roundName( name, angle=22, r=16, font=DEFAULT_FONT, size=10 )
{
    count = len(name);
    
    rotate( -(count-1)/2 * angle ) {
        for (i=[0:count-1]) {
            rotate( angle*i ) {
                translate([0,1-r]) text( name[i], valign="top", halign="center", font=font, size=size );
            }
        }
    }
}

module glassTag( name, thickness=3, r=16, size=10, angle=22, outline=1, font=DEFAULT_FONT )
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
            offset( r=outline ) {
                names();
            }
        }
    }
    
    color( [1,0,0] )
    linear_extrude( thickness, convexity=14 ) {
        names();
    }
    
    linear_extrude( thickness/2, convexity=6 ) {
        difference() {
            circle( r=r+thickness );
            circle( r=r );
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
            offset( r=outline ) {
                name();
            }
        }
    }
    
    color( [1,0,0] )
    linear_extrude( thickness, convexity=15 ) {
        name();
    }

    translate( [-2, -strip, 0 ] ) cube( [4, strip, thickness/2] );
    
}

module support( width=4, heft=1.5, thin=0.6 )
{
    h = 11-heft*2;
    
    color( [0.5,0.5,0.5] ) {
        translate([-width/2,13,0]) cube( [width,thin,h] ); // upright support at end
        translate( [-width/2,10,0] ) cube( [width,3,thin] ); // along the floor
    }
    children();
}

module clipped( heft=1.5, width=4 )
{
    h = 11-heft*2;
    
    clip( heft=heft, width=width );

    // Thin strip which - will be bent in half
    translate([-width/2,-width,0]) cube([width, width*2, 0.4]);
    
    translate( [0,-2,0] ) {
        children();
    }
}

module clip( heft=1.5, width=4 )
{
    h = 11-heft*2;
    
    module shape() {
        
        square( [14, heft ] ); // Long straight
        square( [heft,h] ); // Upright
        
        translate( [0,h-heft] ) square( [4,heft] ); // Short straight

        translate( [7,h] ) difference() { // Half Round
            circle( r=4, $fn=18 );
            circle( r=4-heft, $fn=18 );
            translate( [-10,0] ) square( 20 );
        }
    }
    
    
    translate( [-width/2, 0, h] ) mirror([0,0,1]) rotate([90,0,90]) {
        linear_extrude( width, convexity=6 ) shape();
    }
    
}

module verticalInitials( letters="ABCDEFGHIJKLMNOPQRSTUVWXYZ", rows=4, xspacing=12, yspacing=28 )
{
    for (i=[0:len(letters)-1]) {
        translate( [i*xspacing/rows,(i%rows)*yspacing,0] ) {
            support() clipped() verticalName(letters[i]);
        }
    }
}

module initials( letters="0123456789", rows=3, xspacing=40, yspacing=46 )
{
    for (i=[0:len(letters)-1]) {
        translate( [i*xspacing/rows,(i%rows)*yspacing,0] ) {
            glassTag( str("    ", letters[i], "    " ) );
        }
    }
}



