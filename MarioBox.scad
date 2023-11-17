
size = 30; // CHANGE length of inner surface along X

cubeDimsX = 10 + size;
cubeDimsY = 50;
cubeDimsZ = 60;
inner_offset = 10;

cubeSize = 100; // Referenced from STL. DO NOT CHANGE

clipLocX = 13+size/2; //contact: 15+size/2
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

//clip settings
clipThickness = 5;
clipWidth = 50; //how broad the clip is
clipClearance = 40; // gap of the clip - measure what you want to clip onto;

// Holes settings
// box
holesBoxDiameter = 3;
// clip
holesClipDiameter = 4.1;

// for modelling/debugging
clipToBoxSpacing = 10; //set to '0' for alignement

Main();

module Main() {
    union(){
        rotate([0,0,90]) import("Box.stl", convexity=10);
        translate([-3,-86,37]) cube([3,69,50]); //reinforcement
    }
    translate([clipToBoxSpacing,-75,40]) clip();
    
    holesClip();
    holesBox();
}

module clip() {
    difference(){
        union(){
            cube([clipThickness,clipWidth,50]); //plate connecting to cube
            translate([0,0,50]) cube([clipClearance,clipWidth,clipThickness]); //top plate
            translate([clipClearance-clipThickness,0,0]) cube([clipThickness,clipWidth,50]); //plate furthest from cube
        }
        
        translate([0, 40, 10]) holesClip();
    }
    
    
}

module holesClip() {
    translate([0,0,0]) rotate([0,90,0]) cylinder(h=clipThickness+1, r=holesClipDiameter);
    translate([0,-30,0]) rotate([0,90,0]) cylinder(h=clipThickness+1, r=holesClipDiameter);
    translate([0,0,30]) rotate([0,90,0]) cylinder(h=clipThickness+1, r=holesClipDiameter);
    translate([0,-30,30]) rotate([0,90,0]) cylinder(h=clipThickness+1, r=holesClipDiameter);
    }


module holesBox() {
    
    }