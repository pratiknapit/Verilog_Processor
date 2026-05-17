module seq_detector(clk, rst, in, detected);
    input clk, rst, in;
    output detected;
    wire[3:0] next_state_wire, curr_state_wire;

    n_state n_state(.state(curr_state_wire), .w(in), .next_state(next_state_wire));
    register inst_reg(.D(next_state_wire), .clk(clk), .rst(rst), .Q(curr_state_wire));
    output_signal signal(.state(curr_state_wire), .detected(detected));

endmodule