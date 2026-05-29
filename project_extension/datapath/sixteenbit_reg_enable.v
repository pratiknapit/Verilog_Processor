module sixteenbit_reg_enable();
    input clk, reset, en;
    input [15:0] d_in;
    output reg [15:0] q_out;

    always @(posedge clk or reset) begin
        if (rst == 1'b1) 
            q_out <= 0;
        else begin
            if (en = 1'b1)
                q_out <= d_in;
            else 
                q_out <= q_out;
        end
    end
endmodule