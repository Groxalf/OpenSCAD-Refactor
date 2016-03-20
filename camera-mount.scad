FINE_CYLINDERS_QUALITY = 100;
$fn = FINE_CYLINDERS_QUALITY;

module CameraMountBase() {
	cube([29, 28, 8]);
}

module CameraMount() {
    difference(){
        union(){
            CameraMountBase();
            
            // Standoffs
            translate([3.5, 4, 8]){                
                cylinder(r = 3, h = 3);
            }
            
            translate([25.5, 4, 8]){
                cylinder(r = 3, h = 3);
            }
            
            translate([3.5, 17.5, 8]){
                cylinder(r = 3, h = 3);
            }
            
            translate([25.5, 17.5, 8]){
                cylinder(r = 3, h = 3);
            }
            
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