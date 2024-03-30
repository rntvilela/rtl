module clk_div_3 
(
	input clk,
	input rst_n,
	output clk_div
);

	reg[1:0] counter;
	wire[1:0] counter_next;
	reg clk_shift;

	assign counter_next = (counter == 2'b10)? 2'b00 : counter + 1'b1;

	always @(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			counter <= 2'b0;
			clk_shift <= 1'b0;
		end
		else begin
			counter <= counter_next;
			clk_shift <= clk_div;
		end
	end

	assign clk_div = counter[1] & ~counter[0];

endmodule
