
$fn = 32;

radius = 70;
wall = 3;
base = 2;
top = 1;

pad_size = 10;

cherry_width = 13.9;
cherry_height = 9;
cherry_stem_width = 4.1;
cherry_stem_height = 3.6;
cherry_stem_wall = 1.17;

tol = 0.2;

module base() {
    height = cherry_height+base+6.6;
    
    difference() {
        hull() for (n = [1:6]) rotate([0, 0, (n+0)*360/6])
            translate([radius-wall/2, 0, 0]) cylinder(height, r=wall/2);
        hull() for (n = [1:6]) rotate([0, 0, (n+0)*360/6])
            translate([radius-3*wall/2, 0, base]) cylinder(height, r=wall/2);
        
        // slots for pads
        for (n = [1:6])
        rotate([0, 0, n*360/6]) translate([0, sqrt(3)*(radius-7*wall/16)/2, base]) {
            translate([radius/4, 0, 0]) cylinder(height, r=pad_size/2+tol, $fn=6);
            translate([-radius/4, 0, 0]) cylinder(height, r=pad_size/2+tol, $fn=6);
        }
        
        // slots for connectors
        for (n = [1:2:6])
        rotate([0, 0, n*360/6]) translate([0, sqrt(3)*(radius-7*wall/16)/2, base])
            translate([0, 0, height/2]) cube([2*wall+tol, 2*wall, height], true);
    }
    
    // connectors
    for (n = [1:2:6])
    rotate([0, 0, (n+1)*360/6]) translate([0, sqrt(3)*(radius-wall/2)/2, base+tol]) {
        translate([-wall, (wall-tol)/2, 0]) cube([2*wall, wall+2*tol, height-base-tol]);
        hull() {
            translate([2*wall, 2*wall+tol, 0]) cylinder(height-base-tol, r=wall/2);
            translate([-2*wall, 2*wall+tol, 0]) cylinder(height-base-tol, r=wall/2);
        }
    }
    
    // cherry mx mount
    difference() {
        for (n = [1:4]) hull() {
            rotate([0, 0, (n+0)*360/4])
            translate([(cherry_width+wall+tol)/2, (cherry_width+wall+tol)/2, base])
                cylinder(cherry_height, r=wall/2);
            rotate([0, 0, (n+1)*360/4])
            translate([(cherry_width+wall+tol)/2, (cherry_width+wall+tol)/2, base])
                cylinder(cherry_height, r=wall/2);
        }
        scale([1,2,1.3]) rotate([0,-90,0]) cylinder(cherry_width, r=cherry_width/2, $fn=3);
    }
}

module rand_hex(r) {
    difference() {
        cylinder(10, r=2*r/sqrt(3), $fn=6);
        rotate([0,0,rands(0,360,1)[0]]) translate([0,0,6]) rotate([5,0,0]) cube([20,20,10], true);
    }
}

module lid() {
    height = cherry_height+top+6.6;
    
    // corners
    difference() {
        union() {
            hull() for (n = [1:6]) rotate([0, 0, (n+0)*360/6])
                translate([radius-wall/2, 0, 0]) cylinder(top, r=wall/2);
            hull() for (n = [1:6]) rotate([0, 0, (n+0)*360/6])
                translate([radius-3*wall/2-tol, 0, 0]) cylinder(height, r=wall/2);
        }
        hull() for (n = [1:6]) rotate([0, 0, (n+0)*360/6])
            translate([radius-7*wall/2-tol, 0, 0]) cylinder(height, r=wall/2);
        for (n = [1:6]) rotate([0, 0, n*360/6])
        translate([0, sqrt(3)*(radius-3*wall/2-tol)/2, height/2+top+5])
            cube([3*radius/4, 3*wall, height], true);
    }
    
    
    intersection() {
        difference() {
            hull() for (n = [1:6]) rotate([0, 0, (n+0)*360/6])
                translate([radius-7*wall/2-tol, 0, 0]) cylinder(height, r=wall/2);
            hull() for (n = [1:6]) rotate([0, 0, (n+0)*360/6])
                translate([cherry_width, 0, 0]) cylinder(height, r=wall/2);
        }
        for (i = [-10:10]) {
            for (j = [-10:10]) {
                translate([10*sqrt(3)*i/2, 10*j + 5*(i%2), 0]) rand_hex(5);
            }
        }
    }
    
    hull() for (n = [1:6]) rotate([0, 0, (n+0)*360/6])
        translate([cherry_width, 0, 0]) cylinder(top, r=wall/2);
}

module pad() {
    height = cherry_height+6.6;
    
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

//base();
lid();
//pad();
//plug();



























