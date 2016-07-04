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
      [ 5,0, WEST, 5 ],

      // Interior walls
      [ 1,1, NORTH, 3 ],
      [ 4,1, NORTH, 3 ],
      [ 2,3, NORTH, 1 ],
      [ 3,3, NORTH, 1 ],

      [ 1,3, EAST, 1 ],
      [ 3,3, EAST, 1 ],
      [ 1,2, EAST, 3 ],
      [ 4,4, EAST, 1 ]
    ],

    holes = [
      [ 2,2, SOUTH ],
      [ 2,4, NORTH ],
      [ 4,2, SOUTH ],
      [ 4,4, NORTH ],
      [ 5,4, SOUTH ],
      [ 5,5, WEST ]

    ],

    corners = [
      [ 2,3, SW ],
      [ 2,3, NW ],
      [ 4,3, SE ],
      [ 4,3, NE ],

      [ 1,5, NW ],
      [ 1,1, SW ],
      [ 5,1, SE ]
    ],

    exits = [
      [ 5,3, EAST ]
    ],

    post = [3,2]
  );

}

$fn = 30;
tile1();


