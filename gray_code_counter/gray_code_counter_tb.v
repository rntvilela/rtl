module gray_code_counter_tb;
	localparam DATA_WIDTH=4;
	reg clk;
	reg rst_n;
	wire [DATA_WIDTH-1:0] counter;

	gray_code_counter #(.DATA_WIDTH(DATA_WIDTH)) dut 
	(
		.clk(clk),
		.rst_n(rst_n),
		.counter(counter)
	);

	initial begin
		$dumpfile("dump.vcd"); $dumpvars(0);
	end

	always #5 clk=~clk;

	initial begin
		rst_n=1; clk=0; #3; rst_n=0; #3; rst_n=1;

		#200;
		$finish;
	end
endmodule

