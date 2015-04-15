`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:		Adam Perry
//
// Create Date:   22:28:19 04/14/2015
// Design Name:   project2_m
// Module Name:   /home/adam/Dropbox/School/SER232/Project2/project2_tb.v
// Project Name:  Project2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: project2_m
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module project2_tb;

	// Inputs
	reg [3:0] a;
	reg [3:0] b;
	reg s;

	// Outputs
	wire lcd[6:0];
	wire lcd_o;

	project2_m uut (
		.a3(a[3]), 
		.a2(a[2]), 
		.a1(a[1]), 
		.a0(a[0]), 
		.b3(b[3]), 
		.b2(b[2]), 
		.b1(b[1]), 
		.b0(b[0]), 
		.s(s), 
		.lcd_a(lcd[0]), 
		.lcd_b(lcd[1]), 
		.lcd_c(lcd[2]), 
		.lcd_d(lcd[3]), 
		.lcd_e(lcd[4]), 
		.lcd_f(lcd[5]), 
		.lcd_g(lcd[6]), 
		.lcd_o(lcd_o)
	);

	initial begin
		$monitor("A=%b, B=%b, S=%b,\t\tLCD=%b, overflow=%b",a,b,s,lcd,lcd_o);
		// Initialize Inputs
		a = 0; b = 0; s = 0; #100;
        a = 1; b = 0; s = 0; #100;

	end
      
endmodule
