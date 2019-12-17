
$fn = 32;

base = 2;
wall = 4;
height = 15.6;
radius = 100;

cherry_width = 13.9;
cherry_height = 9;
cherry_stem_width = 4.1;
cherry_stem_height = 3.6;
cherry_stem_wall = 1.17;

tol = 0.2;

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
            rotate([0,0,180]) cylinder(height+base, r=1.6*radius-2*wall, $fn=3);
        }
        
        for (i = [1:3]) {
            
            // conductive pad holes
            rotate([0,0,(i+0.5)*360/3]) translate([radius/2-2, 20,base])
                rotate([0,0,360/12]) cylinder(height, r=5, $fn=6);
            rotate([0,0,(i+0.5)*360/3]) translate([radius/2-2,  0,base])
                rotate([0,0,360/12]) cylinder(height, r=5, $fn=6);
            rotate([0,0,(i+0.5)*360/3]) translate([radius/2-2,-20,base])
                rotate([0,0,360/12]) cylinder(height, r=5, $fn=6);
            
            // bolt holes
            rotate([0,0,(i+0.5)*360/3]) translate([radius/2-wall-1,-35,base+(height-3)/2])
                rotate([0,90,0]) cylinder(wall+2, r=2);
            rotate([0,0,(i+0.5)*360/3]) translate([radius/2-wall-1, 35,base+(height-3)/2])
                rotate([0,90,0]) cylinder(wall+2, r=2);
        }
    }
    
    for (i = [1:3]) {
        // bumps for lid
        rotate([0,0,i*360/3]) translate([1.6*radius/2-1,0,height+base-1.5]) sphere(r=1);
        
        // led mounts
        rotate([0,0,i*360/3]) translate([2*radius/3,0,base+5]) difference() {
            hull() {
                translate([0,0,5]) cube([2,10,1], true);
                translate([2,0,-6]) cube([6,18,1], true);
            }
            translate([-2,0,0]) rotate([0,90,0]) cylinder(6, r=2.5);
        }
    }
    
    // cherry mx mount
    difference() {
        for (n = [1:4]) hull() {
            rotate([0, 0, (n+0)*360/4])
            translate([(cherry_width+wall+tol)/2, (cherry_width+wall+tol)/2, base])
                cylinder(cherry_height, r=1);
            rotate([0, 0, (n+1)*360/4])
            translate([(cherry_width+wall+tol)/2, (cherry_width+wall+tol)/2, base])
                cylinder(cherry_height, r=1);
        }
        scale([1,2,1.3]) rotate([0,-90,0]) cylinder(cherry_width, r=cherry_width/2, $fn=3);
    }
}

module lid() {
    difference() {
        intersection() {
            cylinder(5, r=radius, $fn=3);
            rotate([0,0,180]) cylinder(5, r=1.6*radius, $fn=3);
        }
        translate([0,0,1]) intersection() {
            cylinder(height+base, r=radius-2, $fn=3);
            rotate([0,0,180]) cylinder(height, r=1.6*radius-2, $fn=3);
        }
        translate([0,0,-1]) intersection() {
            cylinder(height+base, r=radius-2*wall, $fn=3);
            rotate([0,0,180]) cylinder(height, r=1.6*radius-8*wall, $fn=3);
        }
        for (i = [1:3]) {
            // bumps for lid
            rotate([0,0,i*360/3]) translate([1.6*radius/2-2,0,2.5]) sphere(r=1.5);
        }
    }
    intersection() {
        cylinder(1, r=2*cherry_width, $fn=3);
        rotate([0,0,180]) cylinder(1, r=2*cherry_width, $fn=3);
    }
    for (i = [1:3]) {
        // bumps for lid
        rotate([0,0,(i+0.5)*360/3]) translate([radius/4,0,0.5]) cube([radius/2,wall,1], true);
    }
}

module pad() {
    intersection() {
        cylinder(height, r=5, $fn=6);
        translate([0,0,height/2]) cube([20,wall+2,height], true);
    }
}


base();
//lid();
//pad();