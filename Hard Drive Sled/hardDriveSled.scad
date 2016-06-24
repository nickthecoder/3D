/*
    Allows a 3.5" hard drive to be placed into my 5.25" removable drive bay.
    I use tape to hold the drive in the sled. It's simple, works very well, and looks a bit naff!
    
    This was one of my first truely useful items printed on my 3D printer,
    and something I couldn't buy in the shops!
*/

wall = 0.8;
drive_size = [70,100,10.5];
sled_size = [101,146, drive_size[2] ];

module chomp( size, across = 1, along = 1 )
{
    w = (size[0] - (wall * (across - 1))) / across;
    d = (size[1] - (wall * (along - 1))) / along;
    
    echo ( w, d );
    
    for ( y = [0 : along-1] ) {
        for ( x = [0 : across-1]) {
            translate( [ x * (w + wall), y * (d + wall), -1 ] )
            cube( [w, d, size[2]+2 ] );
        }
    }
}

module sled_gaps()
{
    translate( [ wall, drive_size[1] + wall, 0 ] )        
    chomp( [ drive_size[0] - wall, sled_size[1] - drive_size[1] - wall * 2, drive_size[2] ], across = 3, along = 2 );

    translate( [ drive_size[0] + wall, wall, 0 ] )
    chomp( [ sled_size[0] - drive_size[0] - wall * 2, sled_size[1] - wall * 2, drive_size[2] ], across = 2, along=4 );
}
    

module sled()
{
    difference() {
        cube( sled_size );
        sled_gaps();
    }
}

module drive()
{
    translate( [-1,-1,-1]) cube( drive_size + [1,1,2] );
}

difference() {
    sled();
    drive();
}

