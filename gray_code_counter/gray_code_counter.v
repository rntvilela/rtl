module gray_code_counter #(parameter DATA_WIDTH = 8) 
(
	input clk, 
	input rst_n,
	output [DATA_WIDTH - 1: 0] counter
);

	reg [DATA_WIDTH - 1: 0] counter_reg;
	wire [DATA_WIDTH - 1: 0] counter_next;

	assign counter_next = counter_reg + 1'b1;

	always @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			counter_reg <= {DATA_WIDTH{1'b0}};
		end
		else begin
			counter_reg <= counter_next;
		end
	end

	assign counter = counter_reg ^ (counter_reg >> 1);
endmodule

