FINE_CYLINDERS_QUALITY = 100;
$fn = FINE_CYLINDERS_QUALITY;

module CameraMountBase() {
	lenght = 29;
	width = 28;
	height = 9;
	cube([lenght, width, height]);
}

module Standoffs() {
	back_x_offset = 3.5;
	front_x_offset = back_x_offset + 22;
	left_y_offset = 4;
	right_y_offset = left_y_offset + 13.5;
	z_offset = 8;

  	translate([back_x_offset, left_y_offset, z_offset]){                
    	cylinder(r = 3, h = 3);
   	}
   	         
   	translate([front_x_offset, left_y_offset, z_offset]){
   		cylinder(r = 3, h = 3);
    }
            
    translate([back_x_offset, right_y_offset, z_offset]){
    	cylinder(r = 3, h = 3);
    }
            
    translate([front_x_offset, right_y_offset, z_offset]){
    	cylinder(r = 3, h = 3);
    }
}

module CameraMount() {
	difference(){
      	union(){
        	CameraMountBase();
       	Standoffs();     
            
            // Arm connector
            difference(){
                hull(){
                    translate([7.5, 28, 0]){
                        cube([14, 5, 8]);
                        
                        difference(){
                            translate([0, 7, 4]){
                                rotate([0, 90, 0]){
                                    cylinder(r = 4, h = 14);
                                }
                            }
                        }
                    } 
                }
                
                translate([7.5, 35, 4]){
                    rotate([0, 90, 0]){
                        cylinder(r = 1.4, h = 14);
                    }
                }
                
                translate([10.5, 28, 0]){
                    cube([8, 12, 8]);
                }
            }
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