/*
    Exmple button with a "power" symbol.
    Light will appear around the edge of the button, and through the power symbol.
    
    Print notes
        Print using 2 colours. Opaque for the first 0.8mm, and then transparent for the remainder.
        
*/

use <ledButton.scad>;
use <ntc/tools.scad>;

// Uncomment to create a batch.
//ntc_arrange_grid( 4,17, 4,17 )

// Uncoment to cut a slice, to check that everything looks OK.
//inspect()
labelledCap() offset(0.2) powerSymbol();

