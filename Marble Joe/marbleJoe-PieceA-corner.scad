include <marbleJoe.scad>;


module tile1()
{

  tile(
    walls = [
      // Exterior walls
      [ 0,0, NORTH, 5 ],
      [ 0,5, EAST, 5 ],
      [ 5,5, SOUTH, 2 ],
      [ 5,2, SOUTH, 2 ],
      [ 5,0, WEST, 2 ],
      [ 2,0, WEST, 2 ],

      // Interior walls
      [ 1,1, NORTH, 3 ],
      [ 1,4, EAST, 2 ],
      [ 1,2, EAST, 1 ],
      [ 2,1, NORTH, 1 ],
      [ 2,1, EAST, 1 ],
      [ 4,4, EAST, 1 ],
      [ 4,4, SOUTH, 1 ],
      [ 4,0, NORTH, 1 ],
      [ 2,3, EAST, 2 ]
    ],

    holes = [
      [ 2,2, SOUTH ],
      [ 3,2, NORTH ],
      [ 4,1, WEST ],
      [ 5,1, NORTH ],
      [ 5,4, SOUTH ],
      [ 5,5, WEST ]
    ],

    corners = [
      [ 1,5, NW ],
      [ 1,1, SW ],
      [ 2,3, SW ],
      [ 4,4, SE ],
      [ 2,4, NW ]
    ],

    exits = [
      [ 3,1, SOUTH ],
      [ 5,3, EAST ]
    ],

    post = [4,2]
  );

}

$fn = 50;
tile1();


