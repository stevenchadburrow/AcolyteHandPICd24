
// bottom
translate([-3, -3, -2]) {
    difference() {
        cube([106, 106, 2], center = false);
        translate([3+5, 3+5, -1]) {
            cylinder(4, 3, 3);
        }
        translate([3+95, 3+5, -1]) {
            cylinder(4, 3, 3);
        }
        translate([3+95, 3+95, -1]) {
            cylinder(4, 3, 3);
        }
        translate([3+5, 3+95, -1]) {
            cylinder(4, 3, 3);
        }
    }
}

// front
translate([-3, -3, 0]) {
    difference() {
        cube([106, 2, 5], center = false);
        translate([73.5+3, -0.5, 0]) {
            cube([17, 3, 6], center = false);
        }
    }
}

// back
translate([-3, 101, 0]) {
    cube([106, 2, 5], center = false);
}

// left
translate([-3, -3, 0]) {
    cube([2, 106, 5], center = false);
}

// right
translate([101, -3, 0]) {
    cube([2, 106, 5], center = false);
}

// front left corner
translate([5, 5, 0]) {
    difference() {
        cylinder(3.25, 5, 5);
        translate([0, 0, -1]) {
            cylinder(4.5, 1.5, 1.5);
        }
    }
}
translate([4, -1, 0]) {
    cube([2, 3, 3.25], center = false);
}
translate([-1, 4, 0]) {
    cube([3, 2, 3.25], center = false);
}

// front right corner
translate([95, 5, 0]) {
    difference() {
        cylinder(3.25, 5, 5);
        translate([0, 0, -1]) {
            cylinder(4.5, 1.5, 1.5);
        }
    }
}
translate([94, -1, 0]) {
    cube([2, 3, 3.25], center = false);
}
translate([99, 4, 0]) {
    cube([3, 2, 3.25], center = false);
}

// back right corner
translate([95, 95, 0]) {
    difference() {
        cylinder(3.25, 5, 5);
        translate([0, 0, -1]) {
            cylinder(4.5, 1.5, 1.5);
        }
    }
}
translate([94, 99, 0]) {
    cube([2, 3, 3.25], center = false);
}
translate([99, 94, 0]) {
    cube([3, 2, 3.25], center = false);
}

// back left corner
translate([5, 95, 0]) {
    difference() {
        cylinder(3.25, 5, 5);
        translate([0, 0, -1]) {
            cylinder(4.5, 1.5, 1.5);
        }
    }
}
translate([4, 99, 0]) {
    cube([2, 3, 3.25], center = false);
}
translate([-1, 94, 0]) {
    cube([3, 2, 3.25], center = false);
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
