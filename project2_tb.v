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
	wire [6:0] lcd;
	wire lcd_o;
	
	reg [6:0] expected_lcd;
	reg expected_ovf;
	
	//expected LCD outputs for re-use in testing
	wire [6:0] zero_lcd = 7'b0111111;
	wire [6:0] one_lcd = 7'b0000110;
	wire [6:0] two_lcd = 7'b1011011;
	wire [6:0] three_lcd = 7'b1001111;
	wire [6:0] four_lcd = 7'b1100110;
	wire [6:0] five_lcd = 7'b1101101;
	wire [6:0] six_lcd = 7'b1111101;
	wire [6:0] seven_lcd = 7'b0000111;
	wire [6:0] eight_lcd = 7'b1111111;
	wire [6:0] nine_lcd = 7'b1100111;
	wire [6:0] ten_or_more_lcd = 7'b0000000;
	
	wire under_ten_ovf = 1'b0;
	wire ten_or_over_ovf = 1'b1;

	project2_m uut (
		.a(a), 
		.b(b),
		.s(s), 
		.lcd(lcd), 
		.lcd_o(lcd_o)
	);

	initial begin
	
		$monitor("A=%b, B=%b, S=%b,\t\tLCD=%b expected=%b,\toverflow=%b expected=%b",a,b,s,lcd,expected_lcd,lcd_o,expected_ovf);
		// Initialize Inputs
		//test one-sided additions 0-10
		a = 0; b = 0; s = 0; expected_lcd = zero_lcd; expected_ovf = under_ten_ovf; #100;
        a = 1; b = 0; s = 0; expected_lcd = one_lcd; expected_ovf = under_ten_ovf; #100;
		a = 2; b = 0; s = 0; expected_lcd = two_lcd; expected_ovf = under_ten_ovf; #100;
		a = 3; b = 0; s = 0; expected_lcd = three_lcd; expected_ovf = under_ten_ovf; #100;
		a = 4; b = 0; s = 0; expected_lcd = four_lcd; expected_ovf = under_ten_ovf; #100;
		a = 5; b = 0; s = 0; expected_lcd = five_lcd; expected_ovf = under_ten_ovf; #100;
		a = 6; b = 0; s = 0; expected_lcd = six_lcd; expected_ovf = under_ten_ovf; #100;
		a = 7; b = 0; s = 0; expected_lcd = seven_lcd; expected_ovf = under_ten_ovf; #100;
		a = 8; b = 0; s = 0; expected_lcd = eight_lcd; expected_ovf = under_ten_ovf; #100;
		a = 9; b = 0; s = 0; expected_lcd = nine_lcd; expected_ovf = under_ten_ovf; #100;
		a = 10; b = 0; s = 0; expected_lcd = ten_or_more_lcd; expected_ovf = ten_or_over_ovf; #100;

	end
      
endmodule
