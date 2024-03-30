module blocking;
	reg [0:7] A, B;

	initial begin : init1
		A = 3;

		#1 A = A + 1;
		B = A + 1;

		$display("Checking point 1: A= %b B= %b", A, B);
		$display("Checking point 1: A= %b B= %b", A[7], B[7]);
		
		A = 3;

		#1 A <= A + 1;
		B <= A + 1;

		#1 $display("Checking point 2: A= %b B= %b", A, B);
		$display("Checking point 2: A= %d B= %d", A, B);
	end
endmodule
