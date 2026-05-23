module ALU(A, B, code, result);
    input [3:0] A;
    input [3:0] B;
    input [2:0] code;     // Changed to 3 bits to support more than 4 operations
    output reg [3:0] result;

    always @(*) begin
        case (addSub)
            3'b000 : result = A + B;       // ADD
            3'b001 : result = A - B;       // SUB
            3'b010 : result = A + 1'b1;    // INC
            3'b011 : result = A - 1'b1;    // DEC
            3'b100 : result = A << 1;      // LSL (Logical Shift Left A by 1 bit)
            3'b101 : result = A >> 1;      // LSR (Logical Shift Right A by 1 bit)
            
            default: result = 4'b0000;     // Prevents latch generation
        endcase
    end
endmodule