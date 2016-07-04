use <ntc/label.scad>;

// Creates a 2D single dovetail shape with rounded corners and 45 degree slopes.
// The radius r cannot be larger than 1/4 of the height.
module dovetail( length, height, r, slack = 0, center = false )
{
    // How much do we slide the mirrored top half so that it just touches
    slide = height - sqrt(2)*2*r + (1 + sqrt(2))*slack;

    // The actual length of the dovetail
    l = length + slide;


    module half_dovetail( hl, height, r )
    {
        // Top half of the dovetail shape
        hull() {
            translate( [-hl/2 + r, height - r ] )
            circle( r ); // Top left curve

            translate( [hl/2 - r, height - r, r] )
            circle( r ); // Top right curve
            
            translate( [-hl/2 + height/2, height/2] )
            circle( r );  // Middle left to make a 45 deg angle

            translate( [hl/2 - height/2, height/2] )
            circle( r );  // Middle right to make a 45 deg angle
        }
    }

    if (center) {
        translate( [0, -height / 2 ] )
        dovetail( length, height, r = r, slack = slack, center = false );
    } else {
        difference() {
            union() {
                half_dovetail( l-slack*2, height, r = r - slack );
                // Bottom half (not rounded out yet)
                translate( [ -length/2, 0 ] )
                square( [length, height / 2] );
            }

            // Use two flipped over copies of the half dovtail to round out the bottom half
            union() {
                translate( [ -length, height ] )
                mirror( [ 0,1 ] )
                half_dovetail( l, height, r );
                
                translate( [ length, height ] )
                mirror( [ 0,1 ] )
                half_dovetail( l, height, r );
            }
        }

    }
}

// Evenly spaces a set of 2D dovetail joints along a length.
// Typically, you will extrude the 2D shape, and then use "intersection()" with your own shape.
// There is an optional gap at the beginning and an end.
// Run "dovetail_joints_help()" for a diagram.
module dovetail_joints( length, height, r, slack = 0, gap = 0, n = 1 )
{
    step = (length - gap * 2)/ n;
    one = step / 2; // Size of one dovetail
    
    module dovetail_set()
    {
        for ( i = [0 : n] ) {
            translate( [ step * i + one / 2 + gap, 0 ] )
            dovetail( one, height, r = r, slack = slack );
        }
    }
    
    intersection() {
      dovetail_set();
      if ( gap > 0 ) {
        translate( [0,0] )
        square([length - one, height]);

        translate( [length-one,0] )
        square( [one, height/2] );
      } else {
        square([length,height]);
      }
    }

    if ( gap > 0 ) {
      square( [one, height/2] );
    }

}

module dovetail_joints_help()
{
    length = 400;
    height = 16;
    gap = 10;
    n = 2;
    r = 2.1;

    dovetail_joints( length, height, r = r, gap = gap, n = n );
    
    translate( [ 0, 80 ] )
    title( "dovetail_joints( length, height, r, gap = 0, n = 1)" );
    
    translate( [ 0, 40 ] )
    label_length( "length", length );
    
    translate( [-40,0 ] )
    rotate( [0,0,90] )
    label_length( "height", height );

    translate( [ 0, -40 ] )
    label_length( "gap", gap );
    
    translate( [ gap + r - height / 4, height - r ] )
    label_radius( "r", r );
    
    translate( [length /2 + gap , -40 ] )
    label( str( "n = ", n) );
}

module dovetail_test( length = 50, height = 30, r = 5, slack = 1 )
{
    linear_extrude( h = 1 )
    dovetail( length, height, r = r, slack = slack );

    color([0,0,1])
    linear_extrude( h = 1 )
    translate( [length, height + slack] )
    mirror( [0,1] )
    dovetail( length, height, r = r, slack = slack );
  
    color([1,0,0])
    linear_extrude( h = 1 )
    translate( [length *2, 0] )
    dovetail( length, height, r = r, slack = slack );


    color([0,0,1])
    linear_extrude( h = 1 )
    translate( [-length, height + slack] )
    mirror( [0,1] )
    dovetail( length, height, r = r, slack = slack );
}

module dovetail_joints_test( length = 200, height = 10, r = 2, slack = 1, gap = 15, n = 2 )
{
    module piece()
    {
        difference() {
            difference() {
                linear_extrude( height = 2 )
                square( [ 200,200 ] );

                translate( [0,0,-1] )
                linear_extrude( height = 4 )
                dovetail_joints( length = length, height = height, r = r, slack = -slack, gap = gap, n = n );
            }
            translate( [0,length,-1] )
            rotate( [0,0,-90 ] )
            linear_extrude( height = 4 )
            dovetail_joints( length = length, height = height, r = r, slack = -slack, gap = gap, n = n );
        }
    }
    color([0.5,0.5,0.5])
    translate( [0,0,5] )
    piece();

    color([0,1,0])
    translate( [length, height - slack, 0] )
    rotate( [0,0,180] )
    piece();
}


//dovetail_test( slack = 0 );
//dovetail_joints_test();


//dovetail_test( length = 50, height = 10, r = 2, slack = 0.5 );

//color( [1,0,0] )
//translate( [0, -10.2] )
//square( [48,10], center = true );
//dovetail( length = 50, height = 20, r = 1, slack = 0, center = false );

//color([0.5,0,0])
//translate([0,-2,0])
//cube( [50, 2,1], center = true );


//dovetail_joints_help();

