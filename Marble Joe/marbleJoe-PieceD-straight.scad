include <marbleJoe.scad>;


module tile_d()
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
      [ 1,1, EAST, 2 ],
      [ 1,3, EAST, 3 ],
      [ 1,4, EAST, 3 ],
      [ 4,2, EAST, 1 ],
      [ 4,1, EAST, 1 ],

      [ 1,0, NORTH, 1 ],
      [ 1,4, NORTH, 1 ],
      [ 1,2, NORTH, 1 ],
      [ 4,2, NORTH, 1 ]  
    ],

    holes = [
      [ 1,1, NORTH ],
      [ 2,1, EAST ],
      [ 5,1, WEST ],
      [ 5,2, WEST ],
      [ 5,3, NORTH ],
      [ 4,3, SOUTH ],
      [ 2,3, SOUTH ],
      [ 2,5, EAST ],

      [ 1,5, SOUTH ]
    ],

    corners = [
      [ 5,5, NE ]
    ],

    exits = [
      [ 3,1, SOUTH ],
      [ 3,5, NORTH ]
    ],

    post = [3,3]
  );

}

$fn = 30;
tile_d();


