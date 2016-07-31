use <ratchetClip.scad>;
use <ntc/tools.scad>;

size = 30;
inPlace=true;

ntc_arrange_mirror() translate( [size-1.5,0,0] ) {
    ratchetClip( size=size, inPlace=inPlace );
}
translate( [size-1.5,0,0] ) holePosition( size=size, angle=217 ) hole( flat=false );


