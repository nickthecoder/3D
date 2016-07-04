include <marbleJoe.scad>;


module tile_b()
{

  tile(
    walls = [
      // Exterior walls
      [ 0,0, NORTH, 2 ],
      [ 0,3, NORTH, 2 ],
      [ 0,5, EAST, 5 ],
      [ 5,5, SOUTH, 5 ],
      [ 5,0, WEST, 2 ],   
      [ 2,0, WEST, 2 ],

      // Interior walls
      [ 1,1, EAST, 3 ],
      [ 0,2, EAST, 4 ],
      [ 1,4, NORTH, 4 ],
      [ 2,4, EAST, 2 ],
      [ 3,3, NORTH, 1 ],
      [ 4,3, EAST, 1 ],
      [ 4,0, NORTH, 1 ],
      
      [ 2,3, EAST, 1 ]
    ],

    holes = [
      [ 1,5, SOUTH ],
      [ 3,4, WEST ],
      [ 3,3, EAST ],
      [ 4,1, WEST ],
      
      [ 5,1, NORTH ]
    ],

    corners = [
      [ 1,1, SW ],
      [ 2,5, NW ],
      [ 4,4, NW ],
      [ 1,2, NW ],
      [ 5,3, NE ],
      [ 5,4, SE ],
      [ 1,3, SE ],
      [ 5,5, NE ]
    ],

    exits = [
      [ 3,1, SOUTH ],
      [ 1,3, WEST ]
    ],

    post = [2,3]
  );

}

$fn = 30;
tile_b();


