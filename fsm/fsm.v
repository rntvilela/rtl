module fsm (
	input clk,
	input rst,
	input go,
	input wt,
	output ds,
	output rd
);

	localparam IDLE = 2'b00;
	localparam READ = 2'b01;
	localparam WAIT = 2'b11;
	localparam DONE = 2'b10;

	reg [1:0] state;
	reg [1:0] state_next;

	// Register
	always @(posedge clk, negedge rst) begin : register_state
		if (!rst) begin
			state <= IDLE;
		end
		else begin
			state <= state_next;
		end
	end

	// Next state logic
	always @(*) begin : next_logic
		case(state)
			IDLE: state_next = (go)? READ : IDLE;
			READ: state_next = WAIT;
			WAIT: state_next = (wt)? WAIT : DONE;
			DONE: state_next = IDLE;
		endcase
	end

	// Output logic
	assign rd = (state == READ || state == WAIT);
	assign ds = (state == DONE);

endmodule
