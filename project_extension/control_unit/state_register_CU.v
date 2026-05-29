module state_register(clk, rst, D, Q); // D flip flop positive edge registers.
    input clk, rst;
    input[7:0] D;
    output reg[7:0] Q;

    always @(posedge clk or posedge rst) begin
        if (rst == 1'b1)
            Q <= 8'h00;
        else
            Q <= D; 
    end
endmodule