module instruction_register(clk, rst, D, Q); // D flip flop positive edge registers.
    input clk, rst;
    input[15:0] D;
    output reg[15:0] Q;

    always @(posedge clk or posedge rst) begin
        if (rst == 1'b1)
            Q <= 16'h0000;
        else
            Q <= D; 
    end
endmodule