module FA(b, a,cin,cout,s);
	//all inputs and outputs are 1-bit
	input a, b, cin;
	output reg cout, s;

	assign inputs = {b, a, cin};
	always @(inputs) begin
		case(inputs) 
		3'b000 : begin cout = 0; s = 0; end
		3'b001 : begin cout = 0; s = 1; end
		3'b010 : begin cout = 0; s = 1; end
		3'b011 : begin cout = 1; s = 0; end
		3'b100 : begin cout = 0; s = 1; end
		3'b101 : begin cout = 1; s = 0; end
		3'b110 : begin cout = 1; s = 0; end
		default : begin cout = 1; s = 1; end
		endcase

	end
endmodule