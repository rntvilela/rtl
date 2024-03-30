module sync_rst (
	input in,
	input clk,
	input rst,
	output out
);

	reg ff_d;

	always @(posedge clk) begin
		if (!rst) begin
			ff_d <= 1'b0;
		end
		else begin
			ff_d <= in;
		end
	end

	assign out = ff_d;

endmodule
