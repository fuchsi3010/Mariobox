
size = 30; // CHANGE length of inner surface along X

cubeDimsX = 10 + size;
cubeDimsY = 50;
cubeDimsZ = 60;
inner_offset = 10;

cubeSize = 100; // Referenced from STL. DO NOT CHANGE

clipLocX = 5+size/2;
clipLocY = -50;
clipLocZ = 75;

boltHolesX = 0;
boltHolesY = 0;
boltHolesZ = 22.5;
boltHolesSp = 10;
boltHolesInset = 5;
boltHoleSizeDiam = 2; // CHANGE inner bolt shaft size (mm)
boltHeadSizeDiam = 6; // CHANGE bolt head shaft size (mm)
boltHoleLength = 30;
boltHeadLength = 10;


Main();

module Main() {
    difference() {
        AllModels();
        AllCutouts();
    }
}

module AllCutouts() {
    Cutout_BoltShaft(boltHoleSizeDiam, boltHoleLength);
    Cutout_BoltHead(boltHeadSizeDiam, boltHoleLength);
}

module Cutout_BoltShaft(size, depth) {
        translate([boltHolesX,boltHolesX,boltHolesZ]) rotate([0,0,90]) translate([cubeSize/-2,boltHoleLength/2,cubeSize/2]) boltholes(size, depth);
}

module Cutout_BoltHead(size, depth) {
        translate([boltHolesX,boltHolesX,boltHolesZ]) rotate([0,0,90]) translate([cubeSize/-2,boltHoleLength/2,cubeSize/2]) boltholes(size, depth);
}

module AllModels() {
    rotate([0,0,90]) import("box.stl", convexity=10);
    translate([clipLocX,clipLocY,clipLocZ]) clip(cubeDimsX,cubeDimsY,cubeDimsZ);
}


module clip(X,Y,Z) {
    difference() {
        cube([X,Y,Z-10], center = true);
        translate([0,0,-5]) cube([X-inner_offset,Y+inner_offset, Z-inner_offset], center = true);  
     }
}

module boltholes(size, depth) {
    translate ([boltHolesSp,0,boltHolesSp]) bolthole(size, depth);
    mirror([1,0,0]) translate ([boltHolesSp,0,boltHolesSp]) bolthole(size, depth);
    mirror([0,0,1]) translate ([boltHolesSp,0,boltHolesSp]) bolthole(size, depth);
    mirror([1,0,1]) translate ([boltHolesSp,0,boltHolesSp]) bolthole(size, depth);
}

module bolthole(size, depth) {
     rotate([90,0,0]) cylinder(h = depth, r1 = size/2, r2 = size/2, $fn = 12);
}
