/*
    Simple cap.
    
    Print Notes
        Use a rubbery plastic. The type I have sometimes is dodgy on the first layer.
        Using  brim may help.
*/

module cap( d1, d2, h, thickness )
{
    difference() {
        cylinder( d1=d1+thickness, d2=d2 + thickness, h=h+thickness );
        translate( [0,0,thickness] ) {
            cylinder( d1=d1, d2=d2, h=h+1 );
        }
    }
}

