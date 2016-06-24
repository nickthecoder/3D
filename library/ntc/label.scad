
module ntc_label_length( label, l )
{
  color([ 0,1,0 ])
  union() {
    // Line
    square( [l,1] );
    
    // Arrow head (start)
    polygon( [ [0,0],[4,4], [4,-4] ] );
    
    // Arrow head (end)
    translate( [l, 0] )
    mirror( [1,0] )
    polygon( [ [0,0],[4,4], [4,-4] ] );
    
    // Label
    translate( [ l / 2, 6 ] )
    text( str(label), halign = "center" );
  }
}

module ntc_label_angle( label, a, l = 10, rotate = 0, halign="left" )
{
  color([ 0,1,0 ])
  union() {
    rotate( rotate )
    union() {
      square( [l,1] );

      rotate( a )
      square( [l,1] );
    }

    translate( [l,0] )
    text( str(label) );
  }
}

module ntc_label_radius( label, r )
{
  color([ 0,1,0 ] )
  union() {
        
    if ( r < 5 ) {
        circle( r );
    } else {
      difference() {
        circle( r );
        circle( r - 1 );
      }
    }
       
    // Label
    translate( [ 0, r + 4 ] )
    text( str(label), halign = "center" );
  }
}

module ntc_title( label )
{
    color([ 0,1,0 ] )
    text( str(label), size=14 );
}
module ntc_label( label, halign = "left" )
{
    color([ 0,1,0 ] )
    text( str(label), halign = halign);
}


