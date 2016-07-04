include <marbleJoe.scad>;


module tile1()
{

  tile(
    walls = [
      // Exterior walls
      [ 0,0, NORTH, 2 ],
      [ 0,3, NORTH, 2 ],
      [ 0,5, EAST, 5 ],
      [ 5,5, SOUTH, 2 ],
      [ 5,2, SOUTH, 2 ],
      [ 5,0, WEST, 5 ],

      // Interior walls

      [ 0,3, EAST ],
      [ 0,1, EAST ],
      [ 0,4, EAST ],
      [ 1,2, EAST, 1 ],
      [ 2,4, EAST, 2 ],
      [ 2,1, EAST, 2 ],
      [ 4,3, EAST, 1 ],
      [ 2,2, NORTH, 2 ],
      [ 4,1, NORTH, 1 ],
      [ 1,1, NORTH, 1 ]
    ],

    holes = [
      [ 1,1, EAST ],
      [ 1,4, EAST ],
      [ 1,5, EAST ],
      [ 4,2, WEST ],
      [ 1,2, NORTH ]
    ],

    corners = [
      [ 5,5, NE ],
      [ 5,4, SE ],
      [ 3,4, NW ],
      [ 2,2, NW ],
      [ 2,3, SE ],
      [ 5,1, SE ],
      [ 5,3, NW ],
    ],

    exits = [
      [ 1,3, WEST ],
      [ 5,3, EAST ]
    ],

    post = [4,3]
  );

}

$fn = 30;
tile1();


