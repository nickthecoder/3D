use <ratchetClip.scad>;

size = 30;
inPlace=true;

ratchetClip( size=size, inPlace=inPlace );

// Example attachment holes

#holePosition( size=size, angle=210 ) hole();
#holePosition( size=size, angle=270 ) hole();
#holePosition( size=size, angle=360 ) hole();

holePosition( size=size, angle=135 ) hole();
holePosition( size=size, angle=90 ) hole( flat=false );

armHolePosition( size, inPlace=inPlace ) hole();




