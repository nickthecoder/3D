include <marbleJoe.scad>;


module tile_e()
{

  tile(
    walls = [
      // Exterior walls
      [ 0,0, NORTH, 5 ],
      [ 0,5, EAST, 2 ],
      [ 3,5, EAST, 2 ],
      [ 5,5, SOUTH, 2 ],
      [ 5,2, SOUTH, 2 ],
      [ 5,0, WEST, 5 ],   

      // Interior walls
      [ 4,1, EAST, 1 ],
      [ 1,2, EAST, 1 ],
      [ 3,4, EAST, 1 ],

      [ 1,2, NORTH, 2 ],
      [ 2,4, NORTH, 1 ],
      [ 2,1, NORTH, 1 ],
      [ 3,1, NORTH, 3 ],
      [ 4,4, NORTH, 1 ],
      [ 4,1, NORTH, 2 ],

      [ 0,1, EAST, 1 ]  
    ],

    holes = [
      [ 1,1, EAST ],
      [ 2,3, NORTH ],
      [ 3,2, SOUTH ],
      [ 5,2, NORTH ],
      [ 5,1, WEST ],
      [ 4,5, WEST ],

      [ 5,5, SOUTH ]
    ],

    corners = [
      [ 2,5, NE ],
      [ 3,4, SE ],
      [ 4,4, NW ],
      [ 2,2, NE ],
      [ 1,2, SW ],
      [ 1,5, NW ]
    ],

    exits = [
      [ 5,3, EAST ],
      [ 3,5, NORTH ]
    ],

    post = [3,3]
  );

}

$fn = 30;
tile_e();


