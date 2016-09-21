/*
    Extra labels for the front of my electronic component boxes
*/

use <namePlaque.scad>;

module labels( names, columns=2 )
{
    for ( i = [0:len(names)-1] ) {
        translate( [70*(i%columns),18*floor(i/columns),0] ) {
            outlinedPlaque(margin=1.5, depth=2, thickness=1) plaqueText( halign="left", names[i], size=11 );
        }
    }
}

labels( ["Heat Shrink","Ties etc","9 10 11 12" ], columns=1 );

