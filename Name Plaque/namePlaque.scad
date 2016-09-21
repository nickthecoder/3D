/*
    Print using two colours, for a words/names outlined with a different colour.
    
    Print Notes
        Use the "Pause at Height" feature, and swap filament.
        I use a base thickness of 1mm, so I Cura's "Pause at Height" z value of 1.2mm when using 0.2mm 
*/


PLAQUE_FONT="Rufscript";

module roundedPlaque( width=60, height=40, depth=5, thickness=1.5 )
{
    linear_extrude( thickness ) {
        translate([0,0]) hull() {
            translate( [ width/2,0] ) circle( d=height );
            translate( [-width/2,0] ) circle( d=height );
        }
    }
    #linear_extrude( depth ) children(); 
}

module namePlaque( text, width=60, height=40, depth=5, thickness=1.5 )
{
    roundedPlaque( width, height, depth, thickness ) plaqueText( text );
}

module plaqueText( text, size=26, font=PLAQUE_FONT, valign="center", halign="center", lineHeightRatio=1 )
{
    lineHeight = size * lineHeightRatio;
    z = valign == "center" ? (len(text)-1)/2 * lineHeight : valign=="top" ? 0 : (len(text)-1) * lineHeight;
    
    if (str(text) == text) {
        text( text, size=size, font=font, valign=valign, halign=halign );
    } else {
        for ( i = [0:len(text)-1] ) {
            translate( [0,z-lineHeight*i] ) text( text[i], size=size, font=font, valign=valign, halign=halign );
        }
    }
}

module outlinedPlaque( depth=5, thickness=1.5, margin=2.5 )
{
    linear_extrude( thickness ) {
        offset( r=margin ) children();
    }
    
    #linear_extrude( depth ) children();
}

module engravedOutlinedPlaque( depth=1, thickness=2, margin=2.5 )
{
    difference() {
        linear_extrude( thickness, convexity=10 ) {
            offset( d=margin ) children();
        }
        
        translate( [0,0,thickness-depth] ) linear_extrude( thickness, convexity=10 ) children();
    }
}



