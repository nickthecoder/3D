/*
    A ball, peppered with indentation for 5mm LEDs, with two holes for the pins.
    Printed in two halves, with screw holes at each end.
    
    I'm a good amateaur juggler, and like something a little different, so four knobbly
    LED balls will do me just fine!
    
    Print Notes
    When printing with the small end touching the build plate, use a large brim to attach it well.
    The first part benefits for a low speed print, because there is a large overhang angle. Once it gets past
    the first 1/5th, full speed is fine for my printer.
    
    If printing the other way up, it will need lots of support.
    
    
    I haven't created the inside part yet, which holds the battery, switch and posts to attach the hemi-spheres.
*/

r=40;
d=r*2;
thickness=3;

ledD=6.5;
ledPinD=2;
indent=2.5;

slack=0.4;
lip=2;

rings = 5;

topLeds = 5;

module led()
{
    rotate([0,90,0]) {
        translate( [0,0,r-indent] ) cylinder( d=ledD, h=indent+1 );
        translate([1.3,0,r-thickness-1]) cylinder( d=ledPinD, h=thickness+2 );
        translate([-1.3,0,r-thickness-1]) cylinder( d=ledPinD, h=thickness+2 );
    }
}

module slice( r, hFrom, hTo )
{
    intersection() {
        sphere( r );
        translate( [0,0,hFrom] ) cylinder( d=r*2 + 2, h=hTo-hFrom );
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
        translate( [0,0,r-indent] ) cylinder( d=ledD, h=indent+2 );
        cylinder( d=ledPinD, h=r+2 );

    }

    // Create a lip, so that the two halves fit snuggly.
    difference() {
        union() {
            cylinder( r=r-thickness-slack, h=lip*2, center=true );
            translate( [0,0,0] ) cylinder( r1=r-thickness/2, r2=r-thickness, h=lip*2 );
        }

        cylinder( r1=r-thickness-slack-lip, r2= r-thickness, h=lip*2+0.1 );
        cylinder( r=r-thickness-slack-lip, h=lip*4, center=true );

        // Make the lip only half way round, so each half has half a lip.
        translate( [-slack,-r,-r/2] ) cube( [r,2*r, r] );
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

mirror( [0,0,1])
ball();

