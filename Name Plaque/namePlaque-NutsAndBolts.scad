/*
    Labels for the front of my containers in the shed.
*/

use <namePlaque.scad>;

module labels( names, columns=2 )
{
    for ( i = [0:len(names)-1] ) {
        translate( [60*(i%columns),18*floor(i/columns),0] ) {
            outlinedPlaque(margin=1.5, depth=2, thickness=1) plaqueText( halign="left", names[i], size=11 );
        }
    }
}

labels( ["M5 M10 M6 M8", "1 2 3 4 5 6 7 8" ], columns=1 );


