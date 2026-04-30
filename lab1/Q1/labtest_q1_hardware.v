module labtest_q1_hardware(a,b,c,x,y);
    input a,b,c;
    output reg x,y;
    
    wire[2:0] temp; //this is an optional wire you may/may not wish to use
    
    // complete the rest of the code
     assign temp = {a, b, c}; // 3-bit wire
     
     always @(temp) begin
        case (temp)
            3'b000       : begin x = 1'b1 ; y = 1'b0; end 
            3'b001       : begin x = 1'b0 ; y = 1'b0; end 
            3'b010       : begin x = 1'b0 ; y = 1'b0; end 
            3'b011       : begin x = 1'b0 ; y = 1'b1; end 
            3'b100       : begin x = 1'b0 ; y = 1'b0; end 
            3'b101       : begin x = 1'b1 ; y = 1'b0; end 
            3'b110       : begin x = 1'b0 ; y = 1'b1; end 
            3'b111       : begin x = 1'b0 ; y = 1'b0; end 
            default     : begin x = 1'b0 ; y = 1'b0; end 
        endcase
    end

endmodule

