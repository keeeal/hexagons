//  import("Nanoleaf_Body.stl");

$fn = 32;

base = 2;
wall = 4;
height = 10;
radius = 100;

module base() {
    difference() {
        union() {
            intersection() {
                cylinder(height+base-3, r=radius, $fn=3);
                rotate([0,0,180]) cylinder(height+base-3, r=1.6*radius, $fn=3);
            }
            intersection() {
                cylinder(height+base, r=radius-2, $fn=3);
                rotate([0,0,180]) cylinder(height+base, r=1.6*radius-2, $fn=3);
            }
        }
        translate([0,0,base]) intersection() {
            cylinder(height+base, r=radius-2*wall, $fn=3);
            rotate([0,0,180]) cylinder(height+base, r=1.6*radius-6*wall, $fn=3);
        }
    }
    
    for (i = [1:3]) {
        rotate([0,0,i*360/3]) translate([1.6*radius/2-1,0,height+base-1.5]) sphere(r=1);
    }
    for (i = [1:3]) {
        rotate([0,0,(i+0.5)*360/3]) translate([radius/2-2,10,height+base]) rotate([0,0,360/12]) cylinder(height, r=5, $fn=6);
    }
}


base();