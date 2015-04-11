`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Adam Perry
// 
// Create Date:    18:04:27 04/04/2015 
// Design Name: 
// Module Name:    project2_m 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module single_bit_full_adder(
	input a,
	input b,
	input cin,
	output o,
	output cout
	);
	
	wire w_carry0, w_carry1, w_carry2;
	
	//check to see if this bit overflows
	and (w_carry0, a, b);
	and (w_carry1, a, cin);
	and (w_carry2, b, cin);
	
	//if the bit overflows, send a 1 on carry out
	or (cout, w_carry0, w_carry1, w_carry2);
	
	//add the three bits together
	xor(s, a, b, cin);
endmodule

module adder(
	input a3,
	input a2,
	input a1,
	input a0,
	input b3,
	input b2,
	input b1,
	input b0,
	output out_3,
	output out_2,
	output out_1,
	output out_0,
	output overflow
	);

	wire first_carry;
	single_bit_full_adder(a0, b0, 0, out_0, first_carry);
	
	wire second_carry;
	single_bit_full_adder(a1, b1, first_carry, out_1, second_carry);
	
	wire third_carry;
	single_bit_full_adder(a2, b2, second_carry, out_2, third_carry);
	
	single_bit_full_adder(a3, b3, third_carry, out_3, overflow);
endmodule

module display_converter(
	input w,
	input x,
	input y,
	input z,
	input over_in,
	output a,
	output b,
	output c,
	output d,
	output e,
	output f,
	output g,
	output over_out
	);
		
	//prep the inversions
	wire w_not, x_not, y_not, z_not;
	not(w_not, w);
	not(x_not, x);
	not(y_not, y);
	not(z_not, z);
	
	//each of these is a minterm in the boolean equations
	//they are reused across lcd segments, so we'll
	//define them for reuse
	wire one, two, three, four, five, six, seven, eight, nine, zero;
	and(one, w_not, x_not, y_not, z);
	and(two, w_not, x_not, y, z_not);
	and(three, w_not, x_not, y, z);
	and(four, w_not, x, y_not, z_not);
	and(five, w_not, x, y_not, z_not);
	and(six, w_not, x, y, z_not);
	and(seven, w_not, x, y, z);
	and(eight, w, x_not, y_not, z_not);
	and(nine, w, x_not, y_not, z);
	and(zero, w_not, x_not, y_not, z_not);
	
	//each segment can be defined as a series of numbers
	//that turn it on
	or(a, two, three, five, six, seven, eight, nine, zero);
	or(b, one, two, three, four, seven, eight, nine, zero);
	or(c, one, three, four, five, six, seven, eight, nine, zero);
	or(d, two, three, five, six, eight, zero);
	or(e, two, six, eight, zero);
	or(f, four, five, six, eight, nine, zero);
	or(g, two, three, four, five, six, eight, nine);
	
	//numbers 10-15 also produce overflow
	//defined by: w(x+y)
	wire internal_overflow, four_or_two_bit;
	or(four_or_two_bit, x, y);
	and(internal_overflow, w, four_or_two_bit);
	
	or(over_out, over_in, internal_overflow);
	
endmodule

module project2_m(
    input a3,
    input a2,
    input a1,
    input a0,
    input b3,
    input b2,
    input b1,
    input b0,
	input s,
	output lcd_a,
	output lcd_b,
	output lcd_c,
	output lcd_d,
	output lcd_e,
	output lcd_f,
	output lcd_g,
	output lcd_o
	);

	wire s_a_0, s_a_1, s_a_2, s_a_3;
	
	//if we want to subtract, we must invert the a inputs
	xor(s_a_0, a0, s);
	xor(s_a_1, a1, s);
	xor(s_a_2, a2, s);
	xor(s_a_3, a3, s);
	
	wire result0, result1, result2, result3, overflow;
	
	adder(
		s_a_0, s_a_1, s_a_2, s_a_3, 
		b3, b2, b1, b0, 
		result3, result2, result1, result0, 
		overflow);
	
	//if we want to subtract, we must also invert the output
	wire final0, final1, final2, final3;
	xor(final0, result0, s);
	xor(final1, result1, s);
	xor(final2, result2, s);
	xor(final3, result3, s);
	
	display_convert(final3, final2, final1, final0, overflow,
		lcd_a, lcd_b, lcd_c, lcd_d, lcd_e, lcd_f, lcd_g, lcd_o);
	
endmodule
