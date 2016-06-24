/*
Loose drill bits annoy me, because I find it very difficult to read the diameters engraved on the shaft.
I rarely have a pair of calipers, so the drill bits often get put back in the wrong place,
or not left unsorted.

Now I have a drill bit sizer in each of my drill bit holders, so I can easily measure the bits.

Print Notes
===========

You will need to drill out each hole with the appropriate sized drill bit, because your printer isn't acurate
enough (well mine isn't!).


To Do
=====

Check the text size and position. I've refactored the code, and only tested on an old version of OpenSCAD, which
doesn't support text. Oops.

*/

thickness = 1.2;
textHeight = 0.8;

module sizer()
{
    module hole( d, margin=0 )
    {
        translate( [ d*d/2 + d,d/2,-1] ) circle( d=d + margin, h=10, $fs=1 );
    }

    module holes() {
        for ( d = [1:10] ) {
            hole( d, 0 );
            flip() hole( d - 0.5 );
        }
    }
    
    module flip() {
        translate( [0,-3,0] ) mirror( [0,1,0] ) children();
    }
    
    module base() {

        hull() {
            flip() hole( 0.5, margin=5 );
            flip() hole( 9.5, margin=5 );
            translate( [0,3] ) hole( 0, margin=5 );
            translate( [3,5] ) hole( 10, margin=5 );
            translate( [60,5] ) circle( d=10 );
        }
    }

    module label( d, size )
    {
        translate( [ d*d/2 + d, d + 2] ) {
            text( str(d), size=size, halign="center" );
            //circle( d=size );
        }
    }

    linear_extrude( thickness ) {
        difference() {
            base();
            holes();
        }
    }

    translate( [0,0,0.8] )
    linear_extrude( textHeight + thickness ) {
        for ( d = [1:10] ) {
            label( d, d < 4 ? 4 : (d + 5) / 2 );
        }
    }

}

sizer();

