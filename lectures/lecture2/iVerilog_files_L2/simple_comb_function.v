module simple_comb_function (a, b, x, y);
	input     		a, b;
	output  reg	    	x, y;
	
	wire[2:0] temp;
	
	assign temp = {a, b};
	
	always @(temp) begin
		case (temp)
			2'b00 : begin x = 1'b0; y = 1'b0; end 
			2'b01 : begin x = 1'b1; y = 1'b0; end 
			2'b11 : begin x = 1'b1; y = 1'b1; end 
			default 	 : begin x = 1'b0; y = 1'b1;end 
		endcase
	end
	
endmodule
