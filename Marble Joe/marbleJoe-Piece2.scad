
module tile2()
{

	color([1,0,0])
	floor();

	color([0,1,0])
	union() {
		// Exterior walls
		wall( 0, 0, NORTH, 5 );
		wall( 1, 5, EAST, 4 );
		wall( 5, 5, SOUTH, 4 );
		wall( 5, 0, WEST, 5 );

		// Interior walls
		wall( 1,0, NORTH );
		wall( 1,2, NORTH, 3 );
		wall( 2,0, NORTH );
		wall( 3,1, NORTH, 3 );

		wall( 1, 4, EAST );
		wall( 2, 1, EAST );
		wall( 3, 4, EAST );
		wall( 4, 1, EAST );
		wall( 4, 2, EAST );
		wall( 4, 3, EAST );


		// Rounded walls for the holes
		dead_end( 1,1, NORTH );
		dead_end( 2,1, NORTH );
		dead_end( 2,5, EAST);
		dead_end( 3,1, EAST);
		dead_end( 3,2, WEST );
		dead_end( 5,2, WEST );
		dead_end( 5,3, WEST );

		// Rounded walls along the path
		corner( 5, 5, NE );
		corner( 5, 4, SE );
		corner( 4, 4, NW );
		corner( 3, 4, SE );
		corner( 2, 4, NW );

		post();
	}
}

module holes2()
{
	hole( 1,1 );
	hole( 2,1 );
	hole( 2,5 );
	hole( 3,1 );
	hole( 3,2 );
	hole( 5,2 );
	hole( 5,3 );

	support_hole();
	dovetails();
}


