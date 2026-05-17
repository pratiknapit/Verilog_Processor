module control_unit(clk, rst, instruction, datapath_signals);
    input clk, rst;
    input[7:0] instruction; // 8bit instruction
    output[13:0] datapath_signals; //14 signals

    wire[1:0] operation_code = instruction[7:6]; // Extract Operation for State Transition
    wire[3:0] current_state_wire, next_state_wire; // Store in 4bit register

    next_state_cu next_state(.state(current_state_wire), .in(operation_code), .rst(rst), .n_state(next_state_wire));
    four_bit_register inst_reg(.clk(clk), .rst(rst), .D(next_state_wire), .Q(current_state_wire));
    output_signal output_signal(.state(curr_state_wire), .datapath_output_signals(datapath_signals));

endmodule