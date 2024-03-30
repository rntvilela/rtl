module fsm_tb;	
	reg clk;
	reg rst;
	reg go;
	reg wt;
	wire ds;
	wire rd;


	fsm dut (
		.clk(clk),
		.rst(rst),
		.go(go),
		.wt(wt),
		.ds(ds),
		.rd(rd)
	);
	
	initial begin
		$dumpfile("dump.vcp"); $dumpvars(0);
	end

	always #5 clk=~clk;

	initial begin
		clk=0; rst=1; go=0; wt=0; #3;

		rst=0; #3; rst=1; #20;

		wt=1; go=1; #50;

		wt=0; go=0;

		#50; $finish;
	end
endmodule
