module half_adder_tb;
	reg a;
	reg b;
	wire s;
	wire c;

	half_adder dut 
	(
		.a(a), 
		.b(b), 
		.s(s),
		.c(c)
	);

	initial begin
		$dumpfile("dump.vcd"); $dumpvars(0);
	end
	
	initial begin
		a=0; b=0; #10;
		if (s === 0 && c===0); else $error("00. Failed!");

		b=1; #10;
		if (s === 1 && c===0); else $error("01. Failed!");
		
		a=1; b=0; #10;
		if (s === 1 && c===0); else $error("10. Failed!");
		
		a=1; b=1; #10;
		if (s === 0 && c===1); else $error("11. Failed!");

		$finish;
	end
endmodule
