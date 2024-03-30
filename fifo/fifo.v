module fifo #(parameter FIFO_WIDTH = 5'd8, parameter FIFO_DEPTH = 6'd16) (
	input clk,
	input rst,
	input wenable,
	input renable,
	input [FIFO_WIDTH - 1:0] wdata,
	output empty,
	output full,
	output reg [FIFO_WIDTH - 1:0] rdata
);

	localparam PTR_WIDTH = $clog2(FIFO_DEPTH);

	reg [PTR_WIDTH:0] ptr_write;
	reg [PTR_WIDTH:0] ptr_read;

	reg [FIFO_WIDTH - 1:0] mem [FIFO_DEPTH - 1:0];

	wire msb_check;

	always @(posedge clk, negedge rst) begin
		if (!rst) begin
			ptr_write <= {PTR_WIDTH + 1{1'b0}};
		end
		else if (!full && wenable) begin
			mem[ptr_write[PTR_WIDTH - 1:0]] <= wdata;
			ptr_write <= ptr_write + 1;
		end
	end
	
	always @(posedge clk, negedge rst) begin
		if (!rst) begin
			ptr_read <= {PTR_WIDTH + 1{1'b0}};
		end
		else if (!empty && renable) begin
			rdata <= mem[ptr_read[PTR_WIDTH - 1:0]];
			ptr_read <= ptr_read + 1;
		end
	end

	assign msb_check = ptr_write[PTR_WIDTH] ^ ptr_read[PTR_WIDTH];
	assign full = msb_check && (ptr_write[PTR_WIDTH - 1:0] == ptr_read[PTR_WIDTH - 1:0]); 
	assign empty = !msb_check && (ptr_write[PTR_WIDTH - 1:0] == ptr_read[PTR_WIDTH - 1:0]); 

endmodule
