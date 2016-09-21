thickness=1.6;
diameter = 27;
height = 50;
switchD = 23;
hidden=30;

baseH = 10;
chargeW = 21;
chargeH = 28;
usbX = 9.5;
usbY = 4;

thin = 0.3;
slack=0.8;

module head()
{

    module switchPosition()
    {
        translate([0,0,20]) rotate([90,0,0]) children();
    }

   
    difference() {
        union() {
            cylinder( d=diameter, h=height );
            switchPosition() {
                hull() {
                    cylinder( d=switchD + thickness *2, h=diameter/2 );
                    translate( [0,20,0] ) cylinder( d=10, h=diameter/2 );
                }
            }
            mirror([0,0,1]) cylinder( d1=diameter, d2=diameter+hidden/10, h=hidden );
        }
        
        translate( [0,0,-1] ) cylinder( d=diameter-thickness*2, h=height+2 );

        // Main hole for the switch
        switchPosition() translate([0,0,-1]) cylinder( d=switchD-2, h=diameter/2+2 );
        // Bigger hole, not quite to the edge for the switch
        switchPosition() translate([0,0,-1]) cylinder( d=switchD, h=diameter/2 );
        
        mirror([0,0,1]) translate([0,0,-0.1]) cylinder( d1=diameter-thickness*2, d2=diameter+hidden/10-thickness*2, h=hidden+0.2 );
        translate([-2,-diameter,-hidden-1]) cube( [4,diameter*2,hidden+1] );
        translate([-diameter,-2,-hidden-1]) cube( [diameter*2,4,hidden+1] );
    }

}


module lip( height=thickness*2 )
{
    foo=diameter-slack;
    
    difference() {
        union() {
            translate( [0,0,-thickness] ) cylinder( d=foo-thickness*2, h=height+thickness );
            translate( [0,0,-thickness-slack] ) cylinder( d=foo+slack, h=thickness+slack );
        }
        translate([0,0,-thickness-1]) cylinder( d=diameter-thickness*4, h=height+thickness+2 );
        translate( [0,0,-thickness-slack-0.01] ) cylinder( d1=diameter-thickness*2, d2=0, h=diameter/2 );
        
        translate([-0.5,-diameter/2,0]) cube([1,diameter,height+1]);
        translate([-diameter/2,-0.5,0]) cube([diameter,1,height+1]);
    }
}

module base()
{
    usbH = 0.6;
    chamfer=1;
    
    difference() {
        
        union() {
            cylinder(d1=diameter-chamfer*2, d2=diameter, h=chamfer );
            translate( [0,0,chamfer] ) cylinder(  d=diameter, h=baseH-chamfer );
        }
                
        translate( [0,0,thickness+usbH] ) cylinder ( d=diameter-thickness*2, h=baseH );
        // Slot for charger circuit  board
        translate([-chargeW/2,-0.5,usbH]) cube( [chargeW,2.5,4] );
        // Hole for USB connection
        translate([-usbX/2,-usbY+0.1,-1]) cube( [usbX, usbY,8] );
    }

    // Uprights for charger support
    translate([-usbX/2, 2.5, 0]) cube( [usbX, thickness, chargeH + thickness] );
    hull() {
        translate([-usbX/2, 2.5, 0]) cube( [usbX, thickness, 15] );
        translate([-usbX/2, 6,0]) cube( [usbX, thickness, 1] );
    }
    translate([-usbX/2, -6, 0])  cube( [usbX, thickness, chargeH + thickness] );

    // 1 layer span across supports
    translate([-usbX/2, -6, chargeH+thickness]) cube( [usbX, 2.5+6 + thickness, thin] );
    // Charger back stop (on top of the 1 layer span)
    translate([-usbX/2, -4.5+thickness, chargeH+thickness]) cube( [usbX, 7, thickness] );

    translate( [0,0,baseH] ) lip();
}


module inspect()
{
    intersection() {
        translate([-50,-0.5,0] )cube( [100,1,100] );
        children();
    }
}

module tube( height, lip=thickness*2 )
{
    linear_extrude( height ) {
        difference() {
            circle( d=diameter );
            circle( d=diameter-thickness*2 );
        }
    }
    translate( [0,0,height] ) lip(lip);
}


base();

//translate( [40,0,0] ) tube( 50 );
