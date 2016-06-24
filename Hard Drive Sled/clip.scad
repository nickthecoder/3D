wall = 0.85;
width = 10;
thickness = 0.8;
depth = 5;

module clip( size = 14, overhang = 10 )
{
    module walls( size )
    {
        translate( [ wall,0,0 ] )
        difference() {
            cube( [width / 2 - wall, size, depth ] );
            translate( [wall, wall, 0 ] )
            cube( [ width / 2 - wall, size - wall*2, depth ] );
        }
    }
    
    l = size * 2 + wall * 2 + overhang;
    translate( [ -width / 2, -overhang, -thickness ] )
    cube( [ width, l, thickness] );

    walls( size );
    mirror( [1,0,0] )
    walls( size );
}


clip();
