module counter_4bit(clk, reset, Q);
    input clk;
    input reset;
    output [3:0] Q;

    wire [3:0] T;

    genvar i;

    generate 
        for (i = 0; i < 4; i++) begin: tff_chain
            if (i == 0) begin
                assign T[i] = 1'b1;
            end else begin
                assign T[i] = &Q[i-1:0];
            end

            // Instantiate flip flop
            t_ff t_ff_inst(.T(T[i]), .clk(clk), .Q(Q[i]));
        end
    endgenerate

endmodule 