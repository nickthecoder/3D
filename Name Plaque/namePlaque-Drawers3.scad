/*
    Extra labels for the front of my electronic component boxes
*/

use <namePlaque.scad>;

module labels( names, columns=2 )
{
    for ( i = [0:len(names)-1] ) {
        translate( [50*(i%columns),20*floor(i/columns),0] ) {
            outlinedPlaque(margin=1.5, depth=2, thickness=1) plaqueText( halign="left", names[i], size=11 );
        }
    }
}

//labels( ["240V", "Wires", "Modules", "Strip Board", "Paper" ], columns=2 );
//labels( ["Spares", "Cable Tidy", "Lights", "Toys" ], columns=2 );
labels( ["Boxes" ], columns=2 );

