/*
    Labels for the front of my electronic component boxes
*/

use <namePlaque.scad>;

module labels( names, columns=2 )
{
    for ( i = [0:len(names)-1] ) {
        translate( [70*(i%columns),24*floor(i/columns),0] ) {
            outlinedPlaque(margin=3, depth=2, thickness=1) plaqueText( halign="left", names[i], size=11 );
        }
    }
}

labels( ["Passives", "LEDs", "Chips", "Switches", "Connectors", "Power", "Spares", "Modules", "1 2 3 4 5 6 7 8" ] );

