include <generated_forAsul.scad>;

module plaque( name )
{
    linear_extrude( 2 ) {
        translate([0,0]) hull() {
            translate( [ 50,0] )circle( 30 );
            translate( [-50,0] ) circle( 30 );
        }
    }
    #linear_extrude( 6 ) text( name, font="Rufscript", size=36, valign="center", halign="center" );
}

plaque( "Jishna" );
//plaque( "Eesha" );

