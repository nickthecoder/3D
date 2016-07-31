use <ratchetClip.scad>;
use <ntc/tools.scad>;

size = 30;
inPlace=true;

ntc_arrange_mirror() translate( [size,0,0] ) {
    ratchetClip( size=size, inPlace=inPlace );
}
translate( [size,0,0] ) holePosition( size=size, angle=214 ) hole( flat=false );


