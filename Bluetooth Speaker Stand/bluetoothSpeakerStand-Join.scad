/*
    Pieces used to join the two speakers together
*/
use <wifiSpeakerStand.scad>;
use <ntc/tools.scad>;

translate( [0,10,0] ) join();

ntc_arrange_mirror() {
    translate([10,0,0]) wireTidy();
    translate([-26,0,0]) washer(10,6,12);
}
