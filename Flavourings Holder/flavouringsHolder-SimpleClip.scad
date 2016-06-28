module insert( height = 12, inside = 10.5, outside = 13.5 )
{
    d = (outside - inside) + 1;
    
    difference() {
        cylinder( r=outside, h = height, center = true );
        translate( [d, 0, 0] )
        cylinder( r = inside, h = height + 1, center = true);
    }
}

for ( n = [0 : 5] ) {
    rotate( [ 0, 0, n * 60 ] )
    translate( [26,0,0] )
    insert();
}




