module fibonacci_tb;
	localparam DATA_WIDTH = 4;
	reg clk;
	reg rst_n;
	reg [DATA_WIDTH - 1:0] n;
	reg start;
	wire done;
	wire [(DATA_WIDTH * 2) + 1:0] f;


	fibonacci #(.DATA_WIDTH(DATA_WIDTH)) dut (
		.clk(clk),
		.rst_n(rst_n),
		.n(n),
		.start(start),
		.done(done),
		.f(f)
	);

	always #5 clk=~clk;
	
	initial begin
		$dumpfile("dump.vcd"); $dumpvars(0);
	end

	initial begin
		clk=0; rst_n=1; n=0; start=0; #1;
		
		rst_n=0; #1; rst_n=1; #1;

		@(negedge clk) n=8'hff; start=1;
		@(negedge clk) start=0;

		@(posedge done) start=0;
		#20;
		$finish;
	end
endmodule


