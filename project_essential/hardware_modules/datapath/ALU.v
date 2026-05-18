module ALU(A, B, result);
	input [3:0] A;
	input [3:0] B;
    output reg [3:0] result,

    always @(*) begin
                result = A + B;
    end
endmodule
