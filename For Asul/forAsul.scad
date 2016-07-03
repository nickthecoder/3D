module plaque( name )
{
    linear_extrude( 1.5 ) {
        translate([0,0]) hull() {
            translate( [ 30,0] ) circle( 20 );
            translate( [-30,0] ) circle( 20 );
        }
    }
    #linear_extrude( 5 ) text( name, font="Rufscript", size=26, valign="center", halign="center" );
}

