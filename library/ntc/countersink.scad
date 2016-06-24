use <label.scad>;

/**
Creates a shape suitable for a countersink screw to fit in.
Note. Usually used as the 2nd part of a "difference()"

diameter : diameter of the hole
length   : length of the hole, including the countersink but NOT including the recess.
head_diameter : diameter of the widest part of the screw head.
angle    : The angle of the countersink (defaults to 45)
recess   : defaults to zero, which will give a head flush with the surface.
screw    : instead of parameters diameter, length, head_diameter and angle, pass a tuple.
*/
module ntc_countersink_hole( diameter, length, head_diameter, recess = 0, angle = 45, screw )
{
    countersink_depth = (head_diameter-diameter) / tan(90-angle) / 2;

    if ( screw ) {
        if ( screw[2] == undef ) {
            ntc_countersink_hole( diameter = screw[0], length = screw[1], head_diameter = screw[0] * 2, recess = recess );
        } else if ( screw[3] == undef ) {
            ntc_countersink_hole( diameter = screw[0], length = screw[1], head_diameter = screw[2], recess = recess );
        } else {
            ntc_countersink_hole( diameter = screw[0], length = screw[1], head_diameter = screw[2], angle = screw[3], recess = recess );
        }
    } else {

        translate( [0,0,recess] )
        {
            cylinder( r = diameter / 2, h = length );
            cylinder( r1 = head_diameter/2, r2 = diameter/2, h = countersink_depth );
        }

        if ( recess != 0 ) {
            cylinder( r = head_diameter/2, h = recess );
        }
    }
}

module ntc_countersink_hole_help()
{
    diameter = 10;
    length = 60;
    head_diameter = 25;
    recess = 15;
    angle = 45;

    ntc_countersink_hole( diameter = diameter, length = length, head_diameter = head_diameter, recess = recess, angle = angle );

    rotate( [90,0,0] )
    {
        translate([-20,recess,0])
        rotate( 90 )
        ntc_label_length( "length", length );

        translate([-60,0,0])
        rotate( 90 )
        ntc_label_length( "recess", recess );

        translate([-head_diameter /2 ,-30,0] )
        ntc_label_length( "head_diameter", head_diameter );

        translate([-diameter /2 , 80,0] )
        ntc_label_length( "diameter", diameter );

        translate( [10,20,0] )
        ntc_label_angle( "angle", angle, rotate = -angle );

        translate( [-80,-60,0] )
        ntc_label( "screw=[ diameter, length, head_diameter, angle ] (2 reqd)" );
    }

}

// ntc_countersink_hole_help();

/*
A hole use for securing with a countersunk screw, where the screw is screwed in place, and then the object being scecured is
attached, by sliding it down.
Often found on plastic items that are hung on walls, for example, electric extension sockets.

diameter      : The diameter of the hole for the screw's shaft
head_diameter : The diameter of the hole, larger than the diameter of the screw's head.
length        : The length of the screw hole, including the counter sink part, but not including any recess.
recess        : Additional depth, if the screw's head is not to be flush with the surface.
*/
module ntc_slotted_hole( diameter, head_diameter, length, recess=0 )
{
    d = head_diameter + 1;
    foo = (head_diameter-diameter) / 2;
    total = length + recess;
    
    hull() {
        ntc_countersink_hole( diameter=diameter, head_diameter=d, length=foo, recess=recess );

        translate( [0,head_diameter,0 ] ) {
            ntc_countersink_hole( diameter=diameter, head_diameter=d, length=foo, recess=recess );
        }
    }
    hull() {
        cylinder( r = diameter/2, h = total );

        translate( [0,head_diameter,0 ] ) {
            cylinder( r = diameter/2, h = total);
        }
    }
    cylinder( r = d/2, h = total);
}

module ntc_slotted_hole_help()
{
    diameter = 10;
    head_diameter=14;
    
    length = 26;
    recess = 10;
    
    ntc_slotted_hole( diameter = diameter, head_diameter = head_diameter, head_diameter = head_diameter, length = length, recess = recess );

    rotate( [90,0,0] ) {

        translate([-diameter /2 , length + 20,0] )
        ntc_label_length( "diameter", diameter );

        translate([-head_diameter /2 ,-20,0] )
        ntc_label_length( "head_diameter", head_diameter );

        translate( [20,recess,0] )
        rotate( 90 )
        ntc_label_length( "length", length );

        translate( [-20,-0,0] )
        rotate( 90 )
        ntc_label_length( "recess", recess );
    }
}

// ntc_slotted_hole_help();

