module fifo_tb;
	localparam FIFO_WIDTH = 5'd8; 
	localparam FIFO_DEPTH = 6'd16;

	reg clk;
	reg rst;
	reg wenable;
	reg renable;
	reg [FIFO_WIDTH - 1:0] wdata;
	wire empty;
	wire full;
	wire [FIFO_WIDTH - 1:0] rdata;

	fifo #(.FIFO_WIDTH(FIFO_WIDTH), .FIFO_DEPTH(FIFO_DEPTH)) fifo_dut (
		.clk(clk),
		.rst(rst),
		.wenable(wenable),
		.renable(renable),
		.wdata(wdata),
		.empty(empty),
		.full(full),
		.rdata(rdata)
	);

	initial begin
		$dumpfile("dump.vcp"); $dumpvars(0);
	end

	always #5 clk=~clk;

	initial begin
		clk=0; rst=1; wdata=0; wenable=0; renable=0; #3;

		// TC-01
		rst=0; #3; rst=1;
		if (!empty || full) $display("TC_01 - Failed!");
		else $display("TC_01 - Passed!");
		
		// TC-02
		pop();
		if (!empty || full || fifo_dut.ptr_read != 4'h0) $display("TC_04 - Failed!");
		else $display("TC_04 - Passed!");

		// TC-03
		push(8'hca);
		if (empty || full) $display("TC_03 - Failed!");
		else $display("TC_03 - Passed!");
		
		// TC-04
		pop();
		if (!empty || full || rdata != 8'hca) $display("TC_04 - Failed!");
		else $display("TC_04 - Passed!");
		
		// TC-05
		for (integer i = 0; i < FIFO_DEPTH; i++) begin
			push(8'hF0 + i[3:0]);
		end
		push(8'hbc);
		if (empty || !full) $display("TC_05 - Failed!");
		else $display("TC_05 - Passed!");
		
		// TC-06
		for (integer i = 0; i < FIFO_DEPTH; i++) begin
			pop();
			if (rdata != (8'hf0 + i[3:0])) $display("TC_06 - %d Failed!", i);
			else $display("TC_06 - %d Passed!", i);
		end
		if (!empty || full) $display("TC_06 - Failed!");
		else $display("TC_06 - Passed!");


		#100; $finish;
	end

	task push (
		input [FIFO_DEPTH - 1:0] data
	);
		begin
			@(negedge clk) wdata=data; wenable=1; renable=0;
			@(negedge clk) wenable=0; wdata=0;
		end
	
	endtask
	
	task pop();
		begin
			@(negedge clk) wenable=0; renable=1;
			@(negedge clk) renable=0;
		end
	
	endtask

endmodule

