module register(clk, rst, D, Q); // D flip flop positive edge registers.
    input clk, rst;
    input D;
    output reg Q;

    always @(posedge clk or posedge rst) begin
        if (rst == 1'b1)
            Q <= 1'b0;
        else
            Q <= D; 
    end
endmodule



