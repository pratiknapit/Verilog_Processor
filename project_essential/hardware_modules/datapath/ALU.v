module ALU(A, Bus, result);
	input [3:0] A;
	input [3:0] Bus;
    output reg [3:0] result,

    always @(*) begin
                result = A + Bus;
    end
endmodule
