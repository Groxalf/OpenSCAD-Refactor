FINE_CYLINDERS_QUALITY = 100;
$fn = FINE_CYLINDERS_QUALITY;
HORIZONTAL_BACK_ROTATION = [0, 90, 0];

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
	back_x_offset = 3.5;
	front_x_offset = back_x_offset + 22;
	left_y_offset = 4;
	right_y_offset = left_y_offset + 13.5;

	CreateStandoffWith(back_x_offset, left_y_offset);
	CreateStandoffWith(front_x_offset, left_y_offset);
	CreateStandoffWith(back_x_offset, right_y_offset);
	CreateStandoffWith(front_x_offset, right_y_offset);
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

module Holes() {
    
        translate([3.5, 4, -1]){
            cylinder(r = 1.25, h = 20);
        }
        
        translate([25.5, 4, -1]){
            cylinder(r = 1.25, h = 20);
        }
        
        translate([3.5, 17.5, -1]){
            cylinder(r = 1.25, h = 20);
        }
        
        translate([25.5, 17.5, -1]){
            cylinder(r = 1.25, h = 20);
        }
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