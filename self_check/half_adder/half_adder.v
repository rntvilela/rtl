module half_adder (
	input a,
	input b,
	output s,
	output c
);

	//assign {c, s} = a + b;
	
	assign s = a ^ b;
	assign c = a & b;

endmodule
