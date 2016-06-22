
module sock( thickness=1, l=8, w=4, slack=0.3, curve=5, toe=3 )
{
    out = w+slack*2+thickness*2;
    
    translate([-out/2,-out/2,0])
    difference() {
        cube( [out,out,l ]);
        translate([thickness+slack,thickness+slack,thickness+slack]) cube( [w,w,l ]);
    }
    
    intersection() {
        translate( [0,0,curve-toe] ) sphere( r=curve );
        translate( [-out/2,-out/2,-toe] ) cube( [out,out,toe] );
    }

}

module grid( across, down, dist=8 )
{
    dist=8;
    for (y = [0:down-1] ) {
        for (x = [0:across-1] ) {
            translate([dist*x,dist*y,0]) children();
        }
    }
}

mirror( [0,0,1] ) sock();
//mirror( [0,0,1] ) grid(2, 3) sock();
