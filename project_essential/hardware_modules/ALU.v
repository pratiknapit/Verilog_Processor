module ALU(
    input alu_op,
	 input [15:0] A;
	 input [15:0] Bus;
    output reg [15:0] result,



);

always @(*) begin


    case(alu_op)
        1'b0:
            result = A + Bus;

        1'b1:
            result = A - Bus;
    endcase

end


endmodule
