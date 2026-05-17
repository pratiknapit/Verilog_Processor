module four_bit_register(clk, rst, D, Q); // D flip flop positive edge registers.
    input clk, rst;
    input[3:0] D;
    output reg[3:0] Q;

    always @(posedge clk or posedge rst) begin
        if (rst == 1'b1)
            Q <= 4'b0;
        else
            Q <= D; 
    end
endmodule