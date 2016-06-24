/*

My mum's backgammon set has a crappy cardboard box, and it is easy to lose the dice/pieces.
So ,why not print some plastic lids for the dice shakers, and then all of the pieces and the dice
can be stored in there, safe and sound.

The dice shakers are slightly concave, which helps the lids stay on, as the lid stretches the
dice shaker slightly.

Printed with PLA.

*/

module lid()
{
    thickness=0.6;
    lip = 2.4;
    side = 2;
    outer=29;
    inner=23.5;
    l=76.5;
    center_dist = l - outer;

    module oval( d ) {
        hull() {
            circle( d=d );
            translate( [center_dist,0] ) circle( d=d );
        }
    }

    linear_extrude(thickness) {
        oval( outer+side );
    }

    linear_extrude(thickness + lip) {
        difference() {
            oval( outer+side );
            oval( outer );
        }
    }

    linear_extrude(thickness + lip) {
        difference() {
            oval( inner );
            oval( inner-side );
        }
    }

}


lid();

