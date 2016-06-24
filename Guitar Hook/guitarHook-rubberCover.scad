module cover( length, diameter,thickness )
{
    difference() {
        cylinder(d=diameter+thickness,h=length);
        translate( [0,0,thickness] ) cylinder(d=diameter,h=length);
    }
}

cover(80,7,2.4);

