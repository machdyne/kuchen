/*
 * Kuchen Case
 * Copyright (c) 2023 Lone Dynamics Corporation. All rights reserved.
 *
 * required hardware:
 *  - 4 x M3 x 20mm countersunk bolts
 *  - 4 x M3 nuts
 *
 */

$fn = 100;

board_width = 50;
board_thickness = 1.5;
board_length = 60;
board_height = 1.6;
board_spacing = 2;

wall = 1.5;

top_height = 10;
bottom_height = 10;

//mdk_board();

//translate([0,0,15])
//	mdk_case_top();

translate([0,0,-15])
	mdk_case_bottom();

module mdk_board() {
	
	difference() {
		color([0,0.5,0])
			roundedcube(board_width,board_length,board_thickness,3);
		translate([5, 5, -1]) cylinder(d=3.2, h=10);
		translate([5, 55, -1]) cylinder(d=3.2, h=10);
		translate([45, 5, -1]) cylinder(d=3.2, h=10);
		translate([45, 55, -1]) cylinder(d=3.2, h=10);
	}	
	
}

module mdk_case_top() {
	
	difference() {
				
		color([0.5,0.5,0.5])
			roundedcube(board_width+(wall*2),board_length+(wall*2),top_height,2.5);

		// cutouts
			
		translate([2,9.5,-2])
			roundedcube(board_width-1.25,board_length-16,10.25,2.5);

		translate([9.5,3,-2])
			roundedcube(board_width-16,board_length-3,10.25,2.5);			
	
		translate([wall, wall, 0]) {

			// vents
			translate([50/2-(25/2),50,0]) cube([25,1,20]);
			translate([50/2-(25/2),45,0]) cube([25,1,20]);
			translate([50/2-(25/2),40,0]) cube([25,1,20]);			
	
			// USBC
			translate([30,14-(9.5/2),-1]) cube([30,9.5,3.5+1]);

			// HDMI
			translate([30,32-(15.5/2),-1]) cube([30,15.5,6.2+1]);
	
			// USBA
			translate([25-(15/2),-5,0]) cube([15,10,7.2+1]);
	

			// PMODA
			translate([-10,18.595-(16/2),0]) cube([25,16,5.1]);

			// PMODB
			translate([-10,41.455-(16/2),0]) cube([25,16,5.1]);
			
			// bolt holes
			translate([5, 5, -21]) cylinder(d=3.5, h=40);
			translate([5, 55, -21]) cylinder(d=3.5, h=40);
			translate([45, 5, -20]) cylinder(d=3.5, h=40);
			translate([45, 55, -21]) cylinder(d=3.5, h=40);

			// flush mount bolt holes
			translate([5, 5, top_height-1.5]) cylinder(d=5.25, h=4);
			translate([5, 55, top_height-1.5]) cylinder(d=5.25, h=4);
			translate([45, 5, top_height-1.5]) cylinder(d=5.25, h=4);
			translate([45, 55, top_height-1.5]) cylinder(d=5.25, h=4);

			// kuchen text
			rotate(270)
				translate([-18.5,25-3,top_height-0.5])
					linear_extrude(1)
						text("K U C H E N", size=4, halign="center",
							font="Ubuntu:style=Bold");

		}
		
	}	
}

module mdk_case_bottom() {
	
	difference() {
		color([0.5,0.5,0.5])
			roundedcube(board_width+(wall*2),board_length+(wall*2),bottom_height,2.5);
		
		// cutouts
		translate([3,10,1.5])
			roundedcube(board_width-3,board_length-17,10,2.5);
				
		translate([10.5,2.5,1.5])
			roundedcube(board_width-17.5,board_length-2,10,2.5);

		translate([wall, wall, 0]) {
			
		// board cutout
		translate([0,0,bottom_height-board_height])
			roundedcube(board_width+0.2,board_length+0.2,board_height+1,2.5);

		translate([wall, wall, 0]) {

			// USBC
			translate([38.5,14-(9.5/2),5]) cube([10.20,9.5,10.5+1]);

		}

		// bolt holes
		translate([5, 5, -11]) cylinder(d=3.2, h=25);
		translate([5, 55, -11]) cylinder(d=3.2, h=25);
		translate([45, 5, -11]) cylinder(d=3.2, h=25);
		translate([45, 55, -11]) cylinder(d=3.2, h=25);

		// nut holes
		translate([5, 5, -1]) cylinder(d=7, h=4, $fn=6);
		translate([5, 55, -1]) cylinder(d=7, h=4, $fn=6);
		translate([45, 5, -1]) cylinder(d=7, h=4, $fn=6);
		translate([45, 55, -1]) cylinder(d=7, h=4, $fn=6);

		}
		
	}	
}

// https://gist.github.com/tinkerology/ae257c5340a33ee2f149ff3ae97d9826
module roundedcube(xx, yy, height, radius)
{
    translate([0,0,height/2])
    hull()
    {
        translate([radius,radius,0])
        cylinder(height,radius,radius,true);

        translate([xx-radius,radius,0])
        cylinder(height,radius,radius,true);

        translate([xx-radius,yy-radius,0])
        cylinder(height,radius,radius,true);

        translate([radius,yy-radius,0])
        cylinder(height,radius,radius,true);
    }
}
