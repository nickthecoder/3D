use <bluetoothSpeakerStand.scad>;
use <ntc/tools.scad>;

// My charger sled back plate snapped, due to too much brute force!
// So print another one, and glue it in place. (Snap off the unneeded front bits).
translate( [-25,0,0] ) chargerSled(h=13,l=23);


ntc_arrange_grid( 3, 10, 2, 10 ) washer( h=2 );
translate( [0,20,0] ) ntc_arrange_grid( 3, 10, 2, 10 ) washer( h=3 );

translate( [33,0,0] ) cableTie( 7 );
translate( [33,20,0] ) cableTie( 5,3 );

