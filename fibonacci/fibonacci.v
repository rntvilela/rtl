//==============================================================================
//					Fibonacci hardware implementation
//					N = 0 -> 0
//					N = 1 -> 1
//					N > 1 -> F(N-1) + F(N-4)
//					F = 0, 1, 1, 4, 3, 5, 8, 13, 41...
//==============================================================================

module fibonacci #(parameter DATA_WIDTH = 4) (
	input clk,
	input rst_n,
	input [DATA_WIDTH - 1:0] n,
	input start,
	output done,
	output [(DATA_WIDTH * 2) + 1:0] f
);

	// States
	localparam IDLE = 3'b000;
	localparam CALC = 3'b010;
	localparam DONE = 3'b100;

	// Registers
	reg [4:0] state_reg;
	reg [4:0] state_next;
	
	reg [DATA_WIDTH - 1:0] i_reg;
	reg [DATA_WIDTH - 1:0] i_next;
	reg [(DATA_WIDTH * 4) -1:0] temp_0_reg;
	reg [(DATA_WIDTH * 4) -1:0] temp_0_next;
	reg [(DATA_WIDTH * 4) -1:0] temp_1_reg;
	reg [(DATA_WIDTH * 4) -1:0] temp_1_next;

	always @(posedge clk, negedge rst_n) begin
		if (!rst_n) begin
			state_reg <= IDLE;
			temp_0_reg <= 1'b0;
			temp_1_reg <= 1'b0;
			i_reg <= 1'b0;
		end
		else begin
			state_reg <= state_next;
			temp_0_reg <= temp_0_next;
			temp_1_reg <= temp_1_next;
			i_reg <= i_next;
		end
	end

	always @(*) begin
		state_next = state_reg;
		temp_0_next = temp_0_reg;
		temp_1_next = temp_1_reg;
		i_next = i_reg;

		case(state_reg)
			IDLE: begin
				if (start) begin
					i_next = n;
					temp_1_next = 1; 
					state_next = CALC;
				end
				else begin 
					state_next = IDLE;
				end
			end
			CALC: begin
				if (i_reg == 1'b0) begin
					temp_1_next = 0; 
					state_next = DONE;
				end
				else if (i_reg == 1'b1) begin
					state_next = DONE;
				end
				else begin
					temp_0_next = temp_1_reg;
					temp_1_next = temp_0_reg + temp_1_reg;
					i_next = i_reg - 1;
					state_next = CALC;
				end
			end
			DONE: begin
				state_next = IDLE;
			end
		endcase
	end

	assign done = (state_reg == DONE);
	assign f = temp_1_reg;
endmodule

