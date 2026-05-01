module counter_26bit(clk, reset, sec_1);
    input clk;
    input reset;
    output reg sec_1;
    
    wire [25:0] Q;
    wire [25:0] T;

    genvar i;

    generate 
        for (i = 0; i < 26; i++) begin: tff_chain
            if (i == 0) begin
                assign T[i] = 1'b1;
            end else begin
                assign T[i] = &Q[i-1:0];
            end

            // Instantiate flip flop
            t_ff t_ff_inst(.T(T[i]), .clk(clk), .reset(reset), .Q(Q[i]));
        end
    endgenerate

// pulse generation (synchronous)
    always @(posedge clk) begin
        if (reset) begin
            sec_1 <= 1'b0;
        end
        else if (Q == 26'd49999999) begin
            sec_1 <= 1'b1;
        end
        else begin
            sec_1 <= 1'b0;
        end
    end

endmodule 