module binary_to_7Seg(binary, sevenSeg);
    input[3:0] binary; // converts binary input in range [0-9]
    output[6:0] sevenSeg;

    always @(binary) begin
		case (binary)
		4'd0 : begin sevenSeg = 7'b1000000; end 
		4'd1 : begin sevenSeg = 7'b1111001; end 
		4'd2 : begin sevenSeg = 7'b0100100; end 
		4'd3 : begin sevenSeg = 7'b0110000; end 
		4'd4 : begin sevenSeg = 7'b0011001; end 
		4'd5 : begin sevenSeg = 7'b0010010; end 
		4'd6 : begin sevenSeg = 7'b0000010; end 
		4'd7 : begin sevenSeg = 7'b1111000; end 
		4'd8 : begin sevenSeg = 7'b0000000; end
		
		default : begin sevenSeg = 7'b0010000; end
	endcase
	end



endmodule