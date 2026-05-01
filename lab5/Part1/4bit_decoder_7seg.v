module decoder_7seg(code, decoded_output1, decoded_output2);

	input[3:0] code; // 4-bit input
	output reg[6:0]  decoded_output1;
	output reg[6:0] decoded_output2;
	
 
	//either do with equations: 
	/*
	output[6:0]  decoded_output;
	assign decoded_output[0] = (code[1] & code[0]) | (~code[1] & ~code[0]);
	assign decoded_output[1] = (code[1] & code[0]) | (~code[1] & ~code[0]);
	assign decoded_output[2] = ...;
	*/
	
	// or with case statement:
	/*
	output reg[6:0]  decoded_output;
	always @(code) begin
		case (code)
		4'b0000 : begin decoded_output = 7'b???????; end
		...
		default : begin ... end
	endcase
	end
	*/
	
	// active-low = on is 0 on the segment display.
	always @(code) begin
		case (code)
		4'd0000 : begin decoded_output1 = 7'b0000000; decoded_output2 = 7'b0000000;end // 0 0
		4'b0001 : begin decoded_output1 = 7'b0000000; decoded_output2 = 7'b1111001;end // 0 1
		4'b0010 : begin decoded_output1 = 7'b0000000; decoded_output2 = 7'b0100100;end // 0 2
		4'b0011 : begin decoded_output1 = 7'b0000000; decoded_output2 = 7'b0110000;end // 0 3
		4'b0100 : begin decoded_output1 = 7'b0000000; decoded_output2 = 7'b0011001;end
		4'b0101 : begin decoded_output1 = 7'b0000000; decoded_output2 = 7'b0010010;end
		4'b0110 : begin decoded_output1 = 7'b0000000; decoded_output2 = 7'b0000010;end
		4'b0111 : begin decoded_output1 = 7'b0000000; decoded_output2 = 7'b1111000;end
		4'b1000 : begin decoded_output1 = 7'b0000000; decoded_output2 = 7'b0000000;end
		4'b1001 : begin decoded_output1 = 7'b0000000; decoded_output2 = 7'b0010000;end // 0 9
		4'b1010 : begin decoded_output1 = 7'b1111001; decoded_output2 = 7'b0000000;end // 1 0
		4'b1011 : begin decoded_output1 = 7'b1111001; decoded_output2 = 7'b1111001;end // 1 1
		4'b1100 : begin decoded_output1 = 7'b1111001; decoded_output2 = 7'b0100100;end // 1 2
		4'b1101 : begin decoded_output1 = 7'b1111001; decoded_output2 = 7'b0110000;end // 1 3
		4'b1110 : begin decoded_output1 = 7'b1111001; decoded_output2 = 7'b0011001;end // 1 4

		default : begin decoded_output1 = 7'b1111001; decoded_output2 = 7'b0010010;end // 1 5
	endcase
	end



 
endmodule
