/*
    Labels for the front of my containers in the shed.
*/

use <namePlaque.scad>;

module labels( names, columns=2 )
{
    for ( i = [0:len(names)-1] ) {
        translate( [60*(i%columns),19*floor(i/columns),0] ) {
            outlinedPlaque(margin=1.5, depth=2, thickness=1) plaqueText( halign="left", names[i], size=11 );
        }
    }
}

labels( ["Small Screws", "Large Screws",  "Roundheads", "Nails"], columns=1 );

