include <vases-pedestal.scad>;

// Make the holes for the curves to fit in slightly bigger than the curves themselves.
defaultThickness = DEFAULT_THICKNESS + SLACK*2;

base();
%translate([0,0,3]) clip() curve();
