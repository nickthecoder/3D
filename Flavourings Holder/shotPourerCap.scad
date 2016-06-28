width=6;
thickness=2;
length=6;

module cap()
{
	difference() {
		union() {
			cylinder( d=width+thickness, h=length );
			translate( [0,0,length] ) sphere( d=width + thickness );
		}
		translate( [0,0,-1] ) cylinder( d=width, h= 1 + length-thickness );
		translate( [0,0,length-thickness] ) sphere( d=width );

	}
}

cap();
