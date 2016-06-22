

module ntc_array( x, distX, y=1, distY=0, z=1, distZ=0 )
{
    for ( tz=[0:z-1] ) {
       for ( ty=[0:y-1] ) {
            for ( tx=[0:x-1] ) {
                translate([tx*distX, ty*distY, tz*distZ]) children();
            }
        }
    }        
}

