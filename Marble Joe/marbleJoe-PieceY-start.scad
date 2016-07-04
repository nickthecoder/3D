include <marbleJoe.scad>;


module tile1()
{

  tile(
    walls = [
      // Exterior walls
      [ 0,0, NORTH, 5 ],
      [ 0,5, EAST, 2 ],
      [ 3,5, EAST, 2 ],
      [ 5,5, SOUTH, 5 ],
      [ 5,0, WEST, 5 ],

      // Interior walls
      [ 0,1, EAST, 4 ],
      [ 3,2, EAST, 1 ],
      [ 1,2, EAST, 1 ],
      [ 0,4, EAST, 1 ],
      [ 3,4, EAST, 2 ],

      [ 1,2, NORTH, 1 ],
      [ 2,2, NORTH, 1 ],
      [ 4,1, NORTH, 2 ]
    ],

    holes = [
      [ 1,5, EAST ],
      [ 2,3, NORTH ],
      [ 4,2, WEST ],
      [ 5,5, WEST ]

    ],

    corners = [
      [ 1,4, NW ],
      [ 3,3, NW ],
      [ 4,4, NW ],
      [ 5,4, NE ],
      [ 5,1, SE ],
      [ 4,3, SE ],
      [ 1,2, SW ]
    ],

    exits = [
      [ 3,5, NORTH ]
    ],

    trap = [ 1,1, 4, EAST ],

    post = [3,4]
  );

}

$fn = 30;
tile1();


