screwD = 2; // Diameter of screw holes.
washerD=3; // Diameter of washer holes.
slackD=0.4; // Difference in diameter of pegs and holes
slack=0.2; // Extra height of pegs compared to holes.
horn=2.2; // Depth of the horn attachment.

edge = 5; // Thickness of the edges
bar = 2; // Thickness of the bar


hinge = 0.5; // Thickness of the flexible hinge (must be very thin!)
gap = 1; // The gap between the two hinged parts.
back = 2; // Thickness of the backing for the switch holder
wing = 5; // Size of the wing attachments for the servo motors

// Size of the void to hold the
switchX = 13.5;
switchY = 9.5;
switchZ = 6;

// Length of the overhang, where the switch holder attaches to the main body.
overhang = 20;

// Size of the hole for a servo motor.
w = 23;
l = 16.5;
h = 12.5;


// "end" Constants passes to strut module
FOOT=0;
PEG=1;
HOLE=2;
ATTACHMENT=3;

capThickness=2;
surround=3; // Thickness of plastic around the pegs.

module spokeProfile(slack=0.3)
{
    hull() {
        circle( d=6 +slack );
        translate([14.5,0]) circle( d=4+slack );
    }
    circle( d=7 + slackD );
}


module attachment( thickness, depth=horn )
{
    translate([0,0,thickness-depth]) linear_extrude( thickness ) spokeProfile();
}

module doubleAttachment( depth=horn )
{   
    linear_extrude( depth ) {
        spokeProfile();
        mirror( [1,0] ) spokeProfile();
    }
}

module hole(d)
{
    cylinder( d=d, h=20, center=true );
}


module length( l, w=4.5, curve=0 )
{
    if (curve == 0) {
        hull() {
            circle( d=w );
            translate( [l, 0] ) circle( d=w );
        }
    } else {
        intersection() {
            translate([l/2,-sqrt( curve*curve/4 - l*l/4 ) ])
            difference() {
                circle( d=curve+w, $fa=5 );
                circle( d=curve-w, $fa=5 );
            }
            // Cut out just the segment of the circle we need.
            translate( [l/2, -l/2] ) rotate( 45 ) square( [curve,curve] );
        }
    }
}

