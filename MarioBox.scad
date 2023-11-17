$fn=100;
//clip settings
clipThickness = 5;
clipWidth = 50; //how broad the clip is
clipClearance = 12; // gap of the clip - measure what you want to clip onto;

// Holes settings
// box
holesBoxDiameter = 3;
// clip
holesClipDiameter = 4.1;

// for modelling/debugging
clipToBoxSpacing = 10; //set to '0' for alignement



//////////////////////////////////////////////////
/////////////// beginning of code ////////////////
//////////////////////////////////////////////////

actualClipClearance = clipClearance+2*clipThickness;

Main();

module Main() {
    difference(){
        union(){
            rotate([0,0,90]) import("Box.stl", convexity=10);
            translate([-3,-86,37]) cube([3,69,50]); //reinforcement
        }
        translate([-3, -35, 50]) holes(3, holesBoxDiameter); //cube's wall = 3 mm
    }
    // translate([clipToBoxSpacing,-75,40]) clip(); // for alignement
    rotate([0,180,0]) translate([-3*clipToBoxSpacing,-50,-55]) clip(); //for printing
    
}

module clip() {
    difference(){
        union(){
            cube([clipThickness,clipWidth,50]); //plate connecting to cube
            translate([0,0,50]) cube([actualClipClearance,clipWidth,clipThickness]); //top plate
            translate([actualClipClearance-clipThickness,0,0]) cube([clipThickness,clipWidth,50]); //plate furthest from cube
            
            // chamfer (closer to box)
            difference(){ 
                translate([clipThickness,0,50-clipThickness]) cube([clipThickness,clipWidth,clipThickness]);
                rotate([90,0,0]) translate([2*clipThickness,50-clipThickness,-clipWidth]) cylinder(h=clipWidth,r=clipThickness);
                
            }
            // chamfer (away from box)
            difference(){ 
                translate([actualClipClearance-2*clipThickness,0,50-clipThickness]) cube([clipThickness,clipWidth,clipThickness]);
                rotate([90,0,0]) translate([actualClipClearance-2*clipThickness,50-clipThickness,-clipWidth]) cylinder(h=clipWidth,r=clipThickness);
            }
        }
        translate([0, 40, 10]) holes(clipThickness, holesClipDiameter);
    }
    
    
}

module holes(cylinderHeight, cylinderHoleDiameter) {
    translate([0,0,0]) rotate([0,90,0]) cylinder(h=cylinderHeight, r=cylinderHoleDiameter);
    translate([0,-30,0]) rotate([0,90,0]) cylinder(h=cylinderHeight, r=cylinderHoleDiameter);
    translate([0,0,30]) rotate([0,90,0]) cylinder(h=cylinderHeight, r=cylinderHoleDiameter);
    translate([0,-30,30]) rotate([0,90,0]) cylinder(h=cylinderHeight, r=cylinderHoleDiameter);
    }
