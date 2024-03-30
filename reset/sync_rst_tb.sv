module sync_rst_tb;
	reg in;
	reg clk;
	reg rst;
	wire out;

	sync_rst dut (
		.in(in),
		.clk(clk),
		.rst(rst),
		.out(out)
	);

	initial begin
		$dumpfile("dump.vcp"); $dumpvars(0);
	end

	always #5 clk=~clk;

	initial begin
		in=0; clk=0; rst=1;

		@(negedge clk) in=1; 
		@(negedge clk) rst=0; 
		@(negedge clk) rst=1; 
		@(negedge clk) in=0;

		#50;
		
		@(negedge clk) in=1; 
		@(negedge clk) rst=0; 
		@(negedge clk) rst=1; 
		@(negedge clk) in=0;
		

		#50; $finish;
	end

endmodule
