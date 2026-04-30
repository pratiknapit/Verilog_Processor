module circuitA (v, A);
	input [3:0] v;
	output [3:0] A;
  
	always @(*) begin
		if (v < 4'd9)
			A = v;
		else
			A = 4'd10 - v;
	end
endmodule;