
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