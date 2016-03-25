FINE_CYLINDERS_QUALITY = 100;
$fn = FINE_CYLINDERS_QUALITY;
HORIZONTAL_BACK_ROTATION = [0, 90, 0];

STANDOFF_BACK_POSITION = 3.5;
STANDOFF_FRONT_POSITION = STANDOFF_BACK_POSITION + 22;
STANDOFF_LEFT_POSITION = 4;
STANDOFF_RIGHT_POSITION = STANDOFF_LEFT_POSITION + 13.5;


function calculateRadius(diameter) = diameter / 2; 

module CameraMountBase() {
	lenght = 29;
	width = 28;
	height = 9;
	cube([lenght, width, height]);
}

module CreateStandoffWith(offset_x, offset_y) {
	z_offset = 8;
	radius = 3;
	height = 3;

	translate([offset_x, offset_y, z_offset]){                
    	cylinder(r = radius, h = height);
   	}	
}

module Standoffs() {
	CreateStandoffWith(STANDOFF_BACK_POSITION, STANDOFF_LEFT_POSITION);
	CreateStandoffWith(STANDOFF_FRONT_POSITION, STANDOFF_LEFT_POSITION);
	CreateStandoffWith(STANDOFF_BACK_POSITION, STANDOFF_RIGHT_POSITION);
	CreateStandoffWith(STANDOFF_FRONT_POSITION, STANDOFF_RIGHT_POSITION);
}

module BaseArmsConnector(origin_position, dimensions) {
    cylinder_offset = [0, 7, 4];
    radius = calculateRadius(dimensions[2]);
    
    hull(){
        translate(origin_position)
            cube(dimensions);
        
        translate(origin_position + cylinder_offset)
            rotate(HORIZONTAL_BACK_ROTATION)
                cylinder(r = radius, h = dimensions[0]);
    }
}

module GapBetweenArms(origin_position, dimensions) {
    offset = [3, 0, 0];
    dimensions = [8, 12, 8];
    
    translate(origin_position + offset)
            cube(dimensions);
}

module ArmHole(origin_position, length) {
    offset = [0, 7, 4];
    radius = 1.4;
    translate(origin_position + offset){
        rotate(HORIZONTAL_BACK_ROTATION){
            cylinder(r = radius, h = length);
        }
    }
}    

module ArmsConnector() {
    
    origin_position = [7.5, 28, 0];
    base_dimensions = [14, 5, 8];
    
    difference(){
        BaseArmsConnector(origin_position, base_dimensions);
        GapBetweenArms(origin_position);
        ArmHole(origin_position, base_dimensions[0]);
    }
}

module CreateHole(position) {
    translate(position){
        cylinder(r = 1.25, h = 20);
    }
}

module Holes() {
    z_offset = -1;
    CreateHole([STANDOFF_BACK_POSITION, STANDOFF_LEFT_POSITION, z_offset]);
    CreateHole([STANDOFF_FRONT_POSITION, STANDOFF_LEFT_POSITION, z_offset]);
    CreateHole([STANDOFF_BACK_POSITION, STANDOFF_RIGHT_POSITION, z_offset]);
    CreateHole([STANDOFF_FRONT_POSITION, STANDOFF_RIGHT_POSITION, z_offset]);
}


module CameraMount() {
	difference(){
      	union(){
        	CameraMountBase();
            Standoffs();
			ArmsConnector();
    	}
        Holes();
    }
}

CameraMount();