include <marbles.scad>;

across = 2;
down = 2;

module test()
{
  tile(
    walls = [
      // Exterior walls
      [ 0, 0, NORTH, 2 ],
      [ 0, 2, EAST, 2 ],
      [ 2, 1, SOUTH, 1 ],
      [ 2, 0, WEST, 1 ],

      // Interior walls
      [ 1,1, NORTH, 1 ] ],


    holes = [
      [ 1,2, SOUTH ] ],

    corners = [
      [ 1, 2, NE ] ],

    exits = 
      [
      [ 1,1, SOUTH ],
      [ 2,2, EAST ] ],

    post = undef
  );
}

$fn = 30;
test();
/*
translate( [scale*across, -scale*down -0.1, 40] )
rotate( [0,0,90] )
test();
*/
