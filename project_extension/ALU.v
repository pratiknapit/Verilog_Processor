module ALU(A, B, code, result);
	input [3:0] A;
	input [3:0] B;
    input code;
    output reg [3:0] result;

    always @(*) begin
        case (code)
            1'b0 : begin result = A + B; end //ADD
            1'b1 : begin result = A - B; end //SUB
        endcase
    end
endmodule