/*
    I have a dial indicator measuing device, that I want to use to measure the flatness of surfaces of machines
    (for example, the flatness of my 3D printer bed). Alas, it didn't come with a means to attach it to anything.
    
    This adds an attachment, which is then easy to clamp to the machine, using standard clamps.
    
    Print Notes
        I printed with 
*/

baseD=49.8;
slot=1.2;
thickness=2;
rodD=5.5;
rodH=10;

screwD1=2;
screwD2=4;
screwH=15;

post=12;
height=21;

module attachment()
{
    difference() {
        cylinder( d=baseD, h=thickness );
        for (a=[45,45+90, -45, -45-90]) {
            rotate( [0,0,a] ) translate( [45/2,0,0] ) {
                // screw head indent
                translate([0,0,thickness/2]) cylinder( d=6, h=10 );
                // screw hole
                translate([0,0,-1]) cylinder( d=3, h=10 );
            }
        }
    }
    
    // Protrusion, which can be connected to a 6mm round rod.
    difference() {
        // Square peg
        union() {
            translate( [-post/2, -post/2,0] ) cube( [post, post, height-post/2] );
            translate( [-post/2,0,height-post/2] ) rotate([0,90,0]) cylinder( d=post, h=post );
        }
        
        // Hole for the rod
        #translate( [0,20,rodH] ) rotate( [90,0,0] ) cylinder( d=rodD, h=40 );
        // Slot, which is squeezed to hold the rod.
        translate( [-slot/2,-10,thickness+2] ) cube( [slot,20,140] );
        // Screw hole
        translate( [-post,0,screwH] ) rotate( [0,90,0] ) cylinder( d=screwD1, h=post*2 );
        // Bolt head indent
        translate( [0,0,screwH] ) rotate( [0,90,0] ) cylinder( d=screwD2, h=post );
    }
}

attachment();

