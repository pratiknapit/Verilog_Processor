module ALU(A, B, addSub, result);
	input [3:0] A;
	input [3:0] B;
    input addSub;
    output reg [3:0] result;

    always @(*) begin
        case (addSub)
            1'b0 : begin result = A + B; end //ADD
            1'b1 : begin result = A - B; end //SUB
        endcase
    end
endmodule