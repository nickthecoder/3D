module insert( height = 18, inside = 12, outside = 13.5 )
{
    a = 27/2;
    b = 21/2;
    d = (outside - inside)/2 - 3;
    
    difference() {
        cylinder( r=outside, h = height, center = true );
        translate( [d, 0, 0] )
        cylinder( r = inside, h = height + 1, center = true);
    }
}

insert();


