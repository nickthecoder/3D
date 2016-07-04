include <marbleJoe.scad>;


module tile_c()
{

  tile(
    walls = [
      // Exterior walls
      [ 0,0, NORTH, 5 ],
      [ 0,5, EAST, 2 ],
      [ 3,5, EAST, 2 ],
      [ 5,5, SOUTH, 5 ],
      [ 5,0, WEST, 2 ],   
      [ 2,0, WEST, 2 ],

      // Interior walls
      [ 0,1, EAST, 1 ],
      [ 1,2, EAST, 1 ],
      [ 1,4, EAST, 2 ],
      [ 2,2, EAST, 1 ],
      [ 3,3, EAST, 1 ],
      [ 4,4, NORTH, 1 ],
      [ 1,2, NORTH, 1 ],
      [ 1,4, NORTH, 1 ],
      [ 2,1, NORTH, 2 ],
      [ 3,3, NORTH, 1 ],
      
      [ 4,1, EAST, 1 ]
    ],

    holes = [
      [ 1,1, EAST ],
      [ 1,5, SOUTH ],      
      [ 2,3, NORTH ],
      [ 3,2, SOUTH ],
      [ 5,2, NORTH ],
      [ 5,1, WEST ],
      [ 2,5, EAST ],
      [ 5,5, SOUTH ]
    ],

    corners = [
      [ 1,2, SW ],
      [ 2,2, NE ],
      [ 3,4, NE ],
      [ 3,3, SW ],
      [ 4,4, SW ],
      [ 4,5, NE ]

    ],

    exits = [
      [ 3,1, SOUTH ],
      [ 3,5, NORTH ]
    ],

    post = [4,2]
  );

}

$fn = 30;
tile_c();


