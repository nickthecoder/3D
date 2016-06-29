/*
    Support a spool of filament by the rim of the spool resting on bearings.
    Fits all spool widths.
    
    Print out two copies, and add a pair of "Roller Skate" bearings to each.
    (4 bearings in total).
*/
bearing_diameter = 26;
bearing_width = 9;
thickness = 2;
width = 4;
distance = 70;
hole_radius = 7.5 / 2;

$fn=100;

module spool2()
{

  module side()
  {
    w = bearing_diameter + 4;


    rotate( [90,0,0] )
    linear_extrude( thickness )
    union() {
      translate( [0,w/2] )
      circle( r = w / 2 );
      translate( [-w/2,0] )
      square( [w, w /2] );
    }

    translate( [-w/2,0,thickness] )
    difference() {
      cube( [ w, thickness * 2, thickness * 2 ] );
      translate( [-1, thickness * 2, thickness * 2 ] )
      rotate( [0,90,0] )
      cylinder( r = thickness * 2, h = w + 2 );
    }


    translate( [0,-thickness + 0.5,w/2] )
    rotate( [90,0,0] )
    difference() {
      cylinder( r=hole_radius, h = bearing_width / 2 );

      translate( [-hole_radius*2, hole_radius, bearing_width / 2 ] )
      rotate( [115,0,0] )
      translate( [0,0,0] )
      cube( [hole_radius * 4, hole_radius * 4, hole_radius * 4] );
    }

  }

  module base_end()
  {
    intersection() {
      union() {

        for ( i = [0,1] ) {
          mirror( [0,i,0] )      
          translate( [0,bearing_width/2 + thickness,0] )
          side();
        }
      }

      translate( [0,0,-4] )
      cylinder( r = bearing_diameter / 2, h = 100 );
    }
    difference() {
      cylinder( r = bearing_diameter / 2 + width, h = thickness );
      cube( [ bearing_diameter, bearing_width, thickness * 3 ], center = true );
    }
  }

  for ( i = [0,1] ) {
    mirror( [i,0,0] )
    translate( [distance / 2, 0, 0 ] )
    base_end();
  }

  r = 40;

  linear_extrude( thickness )
  intersection() {
  for ( i = [0,1] ) {
    mirror( [0,i,0] )
      translate( [0, r-13] )
      difference() {
        circle( r );
        circle( r-width );
      }
    }
    square( [distance - bearing_diameter, bearing_diameter * 2 ], center = true );
  }
}

module bearing()
{
  translate( [ distance/2, 0, bearing_diameter/2 + thickness ] )
  rotate( [90,0,0] )
  linear_extrude( bearing_width, center = true )
  difference() {
    circle( r = 23 / 2 );
    circle( r = hole_radius );
  }
}

spool2();
%bearing();
mirror([1,0,0]) %bearing();

