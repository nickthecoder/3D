/*
A simple sign to stick to your front door, to put off some junk mail spammers.
*/
line = 16;
layer = 0.3;
thickness = layer*3;
height = layer*2;

module noPapers()
{
    r = 5;
    x1=30;
    y1=10;
    x2=54;
    y2=-34;

    difference() {
        linear_extrude( thickness ) {
            hull() {
                translate( [-x1, y1, 0 ] ) circle( r );
                translate( [x1, y1, 0 ] ) circle( r );
                translate( [-x2, y2, 0 ] ) circle( r );
                translate( [x2, y2, 0 ] ) circle( r );
            }
        }

        
        translate( [0,0,thickness - height] ) linear_extrude( height + 1 ) {
            text( "No Papers", halign="center" );
            translate( [0,-line,0] ) text( "No Junk Mail", halign="center" );
            translate( [0,-line * 2,0] ) text( "No Cold Callers", halign="center" );
        }
    }
}

noPapers();

