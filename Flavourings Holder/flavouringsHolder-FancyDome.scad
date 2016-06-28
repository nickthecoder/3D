// TODO. Instead of the pole and the lock shape,
// Create a thin dome, and then have the handle
// sticking out the top of it.
// The top of the dome is cageHeight
// Cut the dome where the innerRadius is, and
// intersection a solid dome with the walls of the cages.

bottleHeight=75;
cageHeight = bottleHeight + 2;
thickness = 1.6;

insideRadius = 14;
outsideRadius = insideRadius + thickness;
baseHeight = 1.6;
gap = 1;
wallHeight = 20;
handleSize = [10, 1.6];
poleSize = [3, cageHeight + 13];
lockRadius = handleSize[0] + 5;
lockThickness = handleSize[1] + baseHeight;

module cage()
{
    // Wall and Base
    difference() {
        translate( [0,0,wallHeight / 2] )
        cylinder( h = wallHeight, r = outsideRadius, center = true );
        
        translate( [0,0,wallHeight / 2 + baseHeight] )
        cylinder( h = wallHeight, r = insideRadius, center = true );

    }
    
    // Back
    difference() {
        translate( [0,0, cageHeight/2] )
        difference() {
            cylinder( h = cageHeight, r = outsideRadius, center = true );
            cylinder( h = cageHeight, r = insideRadius, center = true );
        }
        
        // Remove the front part
        translate( [0,-outsideRadius, 0] )
        cube( [outsideRadius, outsideRadius * 2, cageHeight] );
    }
    
}


module main() {

    // Cages
    for ( n = [ 0 : 5 ] ) {
        rotate( [ 0,0, n * 60 ] )
        translate( [ insideRadius + outsideRadius ,0,0] )
        cage();
    }
    
    // Middle base
    translate( [0,0,baseHeight / 2] )
    cylinder( r = outsideRadius * 2, h = baseHeight, center = true );

    // Handle's post
    //translate( [0,0,0] )
    //cylinder( r = poleSize[0], h = poleSize[1], center = true );

    // Handle
    //translate( [10,10,10] )
    //rotate( [90,0,0] )
    //cylinder( r = handleSize[0], h = handleSize[1], center = true );

    r = outsideRadius * 2.25;
    difference() {
        translate( [0,0, cageHeight - r] )

        difference() {
            sphere( r = r, center = true );

            union() {
                sphere( r = r - thickness, center = true );
                translate( [0,0,-r/2] )
                cube( [100,100,2*r], center = true );
            }
        }

        for ( n = [ 0 : 5 ] ) {

            translate( [0,0,wallHeight / 2 + baseHeight] )
            rotate( [ 0,0, n * 60 ] )
            translate( [ insideRadius + outsideRadius ,0,0] )
            cylinder( h = 200, r = insideRadius, center = true );
        }
    }


    
}

module slot()
{
    cube( [(handleSize[0] + gap) * 2, handleSize[1] + gap * 2, baseHeight * 2], center = true );
    
    sphere( r = poleSize[0] + gap );
}

module envelope()
{
    r = outsideRadius * 2.25;
    translate( [0,0, cageHeight - r] )
    sphere( r = r, center = true );
    
    translate( [0,0, (cageHeight - r) / 2 ] )
    cylinder( r = r*2, h = cageHeight - r, center = true );
}

module holder()
{    
    intersection() {
        difference()
        {
            main();
            slot();
        }
        envelope();
    }

    h = cageHeight - outsideRadius;
    for ( n = [ 0 : 5 ] ) {
            rotate( [ 0,0, n * 60 ] )
            translate( [ insideRadius + outsideRadius ,0,0] )
            union() {
                translate( [ 0, outsideRadius, h / 2 ] )
                cylinder( r = thickness, h = h, center = true );

                translate( [ 0, -outsideRadius, h / 2 ] )
                cylinder( r = thickness, h = h, center = true );

                translate( [ 0, outsideRadius, h ] )
                sphere( r = thickness, center = true );

                translate( [ 0, -outsideRadius, h ] )
                sphere( r = thickness, center = true );
          }
    }
}

holder();

//rotate([0,0,00])
//translate( [0,0,cageHeight + 0.5] )
//holder();


