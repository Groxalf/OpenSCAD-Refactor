FINE_CYLINDERS_QUALITY = 100;
$fn = FINE_CYLINDERS_QUALITY;

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

module ArmConnector() {
    
    x_offset = 7.5;
    y_offset = 28;
    z_offset = 0;
    
    length = 14;
    width = 5;
    height = 8;
    
    
    difference(){
        hull(){
            translate([x_offset, y_offset, z_offset])
                cube([length, width, height]);
             
            translate([x_offset, y_offset + 7, z_offset + 4])
                rotate([0, 90, 0])
                    cylinder(r = 4, h = 14);
        }
        
        translate([10.5, 28, 0]){
            cube([8, 12, 8]);
        }
        
        translate([7.5, 35, 4]){
            rotate([0, 90, 0]){
                cylinder(r = 1.4, h = 14);
            }
        }
        
    }
}

module CameraMount() {
	difference(){
      	union(){
        	CameraMountBase();
       	Standoffs();   
			ArmConnector();
    	}
        
        // Holes
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
}

CameraMount();