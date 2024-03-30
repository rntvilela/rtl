module clk_div_3_tb;
	reg clk;
	reg rst_n;
	wire clk_div;

	clk_div_3 dut
	(
		.clk(clk),
		.rst_n(rst_n),
		.clk_div(clk_div)
	);

	initial begin
		$dumpfile("dump.vcd"); $dumpvars(0);
	end

	always #5 clk=~clk;

	initial begin
		clk=0;
		rst_n=1; #2; rst_n=0; #2; rst_n=1;


		#200;
		$finish;
	end
endmodule
