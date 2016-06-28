/*
    The inner section of a ball, with pairs of holes for LED pins
    A ball, peppered with indentation for 5mm LEDs, with two holes for the pins.
    Printed in two halves, with screw holes at each end.
    
    Print Notes.
    Use a low in-fill : 10%
*/

r=40;
d=r*2;
thickness=1;

ledPinD=2;

rings = 5;
topLeds = 5;

module led()
{
    rotate([0,90,0]) {
        translate([1.3,0,0]) cylinder( d=ledPinD, h=r );
        translate([-1.3,0,0]) cylinder( d=ledPinD, h=r );
    }
}


module ringOfLedHoles(n, leds, topLeds=5)
{
    last = n == rings/2-2;

    aFrom = n * 90/rings;
    aTo = (n + 1) * 90/rings;
    
    a = (aFrom+aTo) /2;
    
    hFrom = sin( aFrom ) * r;
    hTo = sin( aTo ) * r;    
    
    for (i = [0:leds-1] ) {
        rotate( [0,0,i * 360/leds] ) rotate( [0,-a,0] ) led();
    }
}


module ball()
{    
    difference() {
        sphere( r );

        sphere( d=d-thickness * 2 );

        for ( n=[0:rings-2] ) {
            rotate( [0,0,n*17] ) ringOfLedHoles(n,floor(5 * rings - 4 * n));
        }
        translate( [0,0,-r-1] ) cylinder( r=r+2, h=r+1 );

        // Put an LED right at the top.
        ringOfLedHoles( rings-1.2, topLeds );

        // A hole for the screw
        cylinder( d=ledPinD, h=r+2 );

    }
    
    // Solid top, which helps printing. If it were just a shell, then the angle of overhang
    // would get too much, and fail. The floor of the solid top is printed by straddling the gap
    // from one side of the ball to the other.
    // The down side : the top set of LED pin holes need drilling out manually.
    intersection() {
        sphere( r-thickness );
        translate( [0,0,r*0.89] ) cylinder( r=r, h=r, $fn=4 );
    }
}

/*
    Used to inspect that the lip is correct, by cutting a thin slice.
    Not used in the final product.
*/
module slice()
{
    intersection() {
        children();
        translate( [-d, -1, -d] ) cube( [d*2, 2, d*2 ] );
    }
}


ball();

