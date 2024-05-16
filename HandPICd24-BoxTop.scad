
// top
translate([-3, -3, -2]) {
    difference() {
        cube([106, 106, 2], center = false);
        
        translate([3, 3, 0]) {
            translate([6.06, 38.1, -1]) {
                cylinder(4, 4, 4);
            }
            translate([13.68, 45.72, -1]) {
                cylinder(4, 4, 4);
            }
            translate([21.3, 38.1, -1]) {
                cylinder(4, 4, 4);
            }
            translate([13.68, 30.48, -1]) {
                cylinder(4, 4, 4);
            }
            
            translate([6.06+72.68, 38.1, -1]) {
                cylinder(4, 4, 4);
            }
            translate([13.68+72.68, 45.72, -1]) {
                cylinder(4, 4, 4);
            }
            translate([21.3+72.68, 38.1, -1]) {
                cylinder(4, 4, 4);
            }
            translate([13.68+72.68, 30.48, -1]) {
                cylinder(4, 4, 4);
            }
        }
    }
}

// buttons
translate([6.06, 38.1, 0]) {
    difference() {
        cylinder(7, 6, 6);
        cylinder(7, 4, 4);
    }
/*
// testing buttons
translate([0, 0, 7]) {
rotate([180, 0, 0]) {
translate([0, 0, -2]) {
// insert button here
difference() {
    cylinder(2, 5, 5);
    cylinder(9, 1.5, 1.5);
}
translate([0, 0, 2]) {
    difference() {
        cylinder(7+2+2.5, 3.75, 3.75);
        cylinder(9, 1.5, 1.5);
    }
}
// end of button
}}}
*/
}
translate([13.68, 45.72, 0]) {
    difference() {
        cylinder(7, 6, 6);
        cylinder(7, 4, 4);
    }
/*    
// testing buttons
translate([0, 0, 7]) {
rotate([180, 0, 0]) {
translate([0, 0, -2]) {
// insert button here
difference() {
    cylinder(2, 5, 5);
    cylinder(9, 1.5, 1.5);
}
translate([0, 0, 2]) {
    difference() {
        cylinder(7+2+2.5, 3.75, 3.75);
        cylinder(9, 1.5, 1.5);
    }
}
// end of button
}}}
*/
}
translate([21.3, 38.1, 0]) {
    difference() {
        cylinder(7, 6, 6);
        cylinder(7, 4, 4);
    }
/*   
// testing buttons
translate([0, 0, 7]) {
rotate([180, 0, 0]) {
translate([0, 0, -2]) {
// insert button here
difference() {
    cylinder(2, 5, 5);
    cylinder(9, 1.5, 1.5);
}
translate([0, 0, 2]) {
    difference() {
        cylinder(7+2+2.5, 3.75, 3.75);
        cylinder(9, 1.5, 1.5);
    }
}
// end of button
}}}
*/    
}
translate([13.68, 30.48, 0]) {
    difference() {
        cylinder(7, 6, 6);
        cylinder(7, 4, 4);
    }
/*    
// testing buttons
translate([0, 0, 7]) {
rotate([180, 0, 0]) {
translate([0, 0, -2]) {
// insert button here
difference() {
    cylinder(2, 5, 5);
    cylinder(9, 1.5, 1.5);
}
translate([0, 0, 2]) {
    difference() {
        cylinder(7+2+2.5, 3.75, 3.75);
        cylinder(9, 1.5, 1.5);
    }
}
// end of button
}}}
*/
}

translate([6.06+72.68, 38.1, 0]) {
    difference() {
        cylinder(7, 6, 6);
        cylinder(7, 4, 4);
    }
}
translate([13.68+72.68, 45.72, 0]) {
    difference() {
        cylinder(7, 6, 6);
        cylinder(7, 4, 4);
    }
}
translate([21.3+72.68, 38.1, 0]) {
    difference() {
        cylinder(7, 6, 6);
        cylinder(7, 4, 4);
    }
}
translate([13.68+72.68, 30.48, 0]) {
    difference() {
        cylinder(7, 6, 6);
        cylinder(7, 4, 4);
    }
}

// back
translate([-3, -3, 0]) {
    difference() {
        cube([106, 2, 20], center = false);
        translate([3+9, -1, 5]) {
            cube([82, 4, 16], center = false);
        }
    }
}

// front
translate([-3, 101, 0]) {
    difference() {
        cube([106, 2, 20], center = false);
        translate([3+9, -1, 5]) {
            cube([82, 4, 16], center = false);
        }
    }
}

// right
translate([-3, -3, 0]) {
    cube([2, 106, 20], center = false);
}

// left
translate([101, -3, 0]) {
    cube([2, 106, 20], center = false);
}

// corner
translate([5, 5, 0]) {
    difference() {
        cylinder(20, 5, 5);
        translate([0, 0, -1]) {
            cylinder(21.25, 1.5, 1.5);
        }
    }
}
translate([4, -1, 0]) {
    cube([2, 3, 20], center = false);
}
translate([-1, 4, 0]) {
    cube([3, 2, 20], center = false);
}

// corner
translate([95, 5, 0]) {
    difference() {
        cylinder(20, 5, 5);
        translate([0, 0, -1]) {
            cylinder(21.25, 1.5, 1.5);
        }
    }
}
translate([94, -1, 0]) {
    cube([2, 3, 20], center = false);
}
translate([99, 4, 0]) {
    cube([3, 2, 20], center = false);
}

// corner
translate([95, 95, 0]) {
    difference() {
        cylinder(20, 5, 5);
        translate([0, 0, -1]) {
            cylinder(21.25, 1.5, 1.5);
        }
    }
}
translate([94, 99, 0]) {
    cube([2, 3, 20], center = false);
}
translate([99, 94, 0]) {
    cube([3, 2, 20], center = false);
}

// corner
translate([5, 95, 0]) {
    difference() {
        cylinder(20, 5, 5);
        translate([0, 0, -1]) {
            cylinder(21.25, 1.5, 1.5);
        }
    }
}
translate([4, 99, 0]) {
    cube([2, 3, 20], center = false);
}
translate([-1, 94, 0]) {
    cube([3, 2, 20], center = false);
}


/*
// CSG.scad - Basic example of CSG usage

translate([-24,0,0]) {
    union() {
        cube(15, center=true);
        sphere(10);
    }
}

intersection() {
    cube(15, center=true);
    sphere(10);
}

translate([24,0,0]) {
    difference() {
        cube(15, center=true);
        sphere(10);
    }
}

echo(version=version());
// Written by Marius Kintel <marius@kintel.net>
//
// To the extent possible under law, the author(s) have dedicated all
// copyright and related and neighboring rights to this software to the
// public domain worldwide. This software is distributed without any
// warranty.
//
// You should have received a copy of the CC0 Public Domain
// Dedication along with this software.
// If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.
*/
