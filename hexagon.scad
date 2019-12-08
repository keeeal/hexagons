
$fn = 32;

radius = 70;
wall = 2;
pad_size = 10;

cherry_width = 13.9;
cherry_height = 9;
cherry_stem_width = 4.1;
cherry_stem_height = 3.6;
cherry_stem_wall = 1.17;

tol = 0.2;

module base() {
    height = cherry_height+wall+6.6;
    
    difference() {
        hull() for (n = [1:6]) rotate([0, 0, (n+0)*360/6])
            translate([radius-wall/2, 0, 0]) cylinder(height, r=wall/2);
        hull() for (n = [1:6]) rotate([0, 0, (n+0)*360/6])
            translate([radius-3*wall/2, 0, wall]) cylinder(height, r=wall/2);
        
        // slots for pads
        for (n = [1:6])
        rotate([0, 0, n*360/6]) translate([0, sqrt(3)*(radius-7*wall/16)/2, wall]) {
            translate([radius/4, 0, 0]) cylinder(height, r=pad_size/2+tol, $fn=6);
            translate([-radius/4, 0, 0]) cylinder(height, r=pad_size/2+tol, $fn=6);
        }
        
        // slots for connectors
        for (n = [1:2:6])
        rotate([0, 0, n*360/6]) translate([0, sqrt(3)*(radius-7*wall/16)/2, wall])
            translate([0, 0, height/2]) cube([2*wall+tol, 2*wall, height], true);
    }
    
    // connectors
    for (n = [1:2:6])
    rotate([0, 0, (n+1)*360/6]) translate([0, sqrt(3)*(radius-wall/2)/2, 0]) {
        translate([-wall, (wall-tol)/2, wall+tol]) cube([2*wall, wall+2*tol, height-wall-tol]);
        hull() {
            translate([2*wall, 2*wall+tol, wall+tol]) cylinder(height-wall-tol, r=wall/2);
            translate([-2*wall, 2*wall+tol, wall+tol]) cylinder(height-wall-tol, r=wall/2);
        }
    }
    
    // cherry mx mount
    difference() {
        for (n = [1:4]) hull() {
            rotate([0, 0, (n+0)*360/4])
            translate([(cherry_width+wall+tol)/2, (cherry_width+wall+tol)/2, wall])
                cylinder(cherry_height, r=wall/2);
            rotate([0, 0, (n+1)*360/4])
            translate([(cherry_width+wall+tol)/2, (cherry_width+wall+tol)/2, wall])
                cylinder(cherry_height, r=wall/2);
        }
        scale([1,2,1.3]) rotate([0,-90,0]) cylinder(10, r=cherry_width/2, $fn=3);
    }
}

module lid() {
    height = cherry_height+wall+6.6;
    
    hull() for (n = [1:6]) rotate([0, 0, (n+0)*360/6])
        translate([radius-wall/2, 0, 0]) cylinder(wall, r=wall/2);
    
    // corners
    difference() {
        hull() for (n = [1:6]) rotate([0, 0, (n+0)*360/6])
            translate([radius-3*wall/2-tol, 0, 0]) cylinder(height, r=wall/2);
        hull() for (n = [1:6]) rotate([0, 0, (n+0)*360/6])
            translate([radius-5*wall/2-tol, 0, wall]) cylinder(height, r=wall/2);
        for (n = [1:6]) rotate([0, 0, n*360/6])
        translate([0, sqrt(3)*(radius-3*wall/2-tol)/2, height/2+wall])
            cube([3*radius/4, 2*wall, height], true);
    }
    
    // cherry stem mount
    translate([0, 0, wall]) difference() {
        cylinder(cherry_stem_height, r=5.5/2);
        translate([0, 0, cherry_stem_height/2])
            cube([cherry_stem_width+tol, cherry_stem_wall+tol, cherry_stem_height], true);
        translate([0, 0, cherry_stem_height/2])
            cube([cherry_stem_wall+tol, cherry_stem_width+tol, cherry_stem_height], true);
    }
}

module pad() {
    height = cherry_height+wall+6.6;
    
    intersection() {
        cylinder(height-wall, r=pad_size/2, $fn=6);
        translate([0, 0, height/2]) cube([pad_size, wall+2*tol, height], true);
    }
}

module plug() {
    height = cherry_height+wall+6.6;
    
    difference() {
        intersection() {
            scale([1,0.5,1]) cylinder(height, r=2*radius/5);
            translate([0, wall/2-radius/2, height/2]) cube([radius,radius,height], true);
        }
        translate([0, 0, wall]) intersection() {
            scale([1,0.5-wall/radius,1]) cylinder(height, r=2*radius/5-wall);
            translate([0,-radius/2-wall/2,height/2]) cube([radius, radius, height], true);
        }
        
        // slots for pads
        translate([radius/4, 0, wall]) cylinder(height, r=pad_size/2+tol, $fn=6);
        translate([-radius/4, 0, wall]) cylinder(height, r=pad_size/2+tol, $fn=6);
    }
    
    // connector    
    translate([-wall, (wall-tol)/2, wall+tol]) cube([2*wall, wall+2*tol, height-wall-tol]);
    hull() {
        translate([2*wall, 2*wall+tol, wall+tol]) cylinder(height-wall-tol, r=wall/2);
        translate([-2*wall, 2*wall+tol, wall+tol]) cylinder(height-wall-tol, r=wall/2);
    }
}

base();
//lid();
//pad();
//plug();