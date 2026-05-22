module output_signal(state, instruction_argument, datapath_output_signals);
    input[3:0] state;
    input[5:0] instruction_argument;

     // 14 signals for the datapath to handle 
     // - Done, Extern, AddSub, Gout, Gin, Ain, R3_out, R2_out, R1_out, R0_out, R3_in, R2_in, R1_in, R0_in,
    output reg[13:0] datapath_output_signals;

    wire[1:0] Rx = instruction_argument[5:4];
    wire[1:0] Ry = instruction_argument[3:2];
    // wire[3:0] data = instruction_argument[3:0];

    always @(*) begin
        datapath_output_signals = 14'b0; // RESET EVERYTHING

        case(state)
            4'd0: begin // RESTART
            end

            4'd1: begin // LOAD
                datapath_output_signals[Rx] = 1;
                datapath_output_signals[12] = 1;
                datapath_output_signals[13] = 1;
            end

            4'd2: begin // ADD1
                datapath_output_signals[Rx+4] = 1;
                datapath_output_signals[8] = 1;
            end

            4'd3: begin // ADD2
                datapath_output_signals[11] = 0; //AddSub = 0
                datapath_output_signals[Ry+4] = 1;
                datapath_output_signals[9] = 1;
            end

            4'd4: begin // ADD3
                datapath_output_signals[10] = 1;
                datapath_output_signals[Rx] = 1;
                datapath_output_signals[13] = 1;
            end

            4'd5: begin // MOVE
                datapath_output_signals[Rx] = 1;
                datapath_output_signals[Ry+4] = 1;
                datapath_output_signals[13] = 1;
            end

            4'd6: begin //SUB1
                datapath_output_signals[Rx+4] = 1;
                datapath_output_signals[8] = 1;
            end
 
            4'd7: begin //SUB2
                datapath_output_signals[11] = 1; //AddSub = 1
                datapath_output_signals[Ry+4] = 1;
                datapath_output_signals[9] = 1;
            end

            4'd8: begin //SUB3
                datapath_output_signals[10] = 1;
                datapath_output_signals[Rx] = 1;
                datapath_output_signals[13] = 1;
            end
        endcase
    end

endmodule