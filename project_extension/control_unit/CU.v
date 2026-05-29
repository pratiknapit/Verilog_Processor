module CU(clk, reset, instruction, r_en_OH, tri_controller_OH, inc_PC, branch_en);
    input clk, reset;
    input[15:0] instruction; // 16bit instruction
    output[15:0] r_en_OH; //16 register enable signals
    output[15:0] tri_controller_OH; //16 register enable signals
    output A_en, G_en, G_out, status_reg_en, status_reg_out;
    output[2:0] ALU_mux;
    output inc_PC, PC_jump_en, PC_read_bus_en, brsh;
    output RAM_data_access;

    wire[7:0] current_state_wire, next_state_wire; // Store in 4bit register

    ns_CU next_state(.reset(reset), .state(current_state_wire), .inst(instruction), .n_state(next_state_wire));
    state_register_CU st_reg(.clk(clk), .reset(reset), .D(next_state_wire), .Q(current_state_wire));
    out_signal_CU output_signal(.state(current_state_wire), .code(instruction), .r_en(r_en), .tri_controller_out(tri_controller),
    .A_en(A_en), .G_en(G_en), .G_out(G_out), .status_reg_en(sreg_en), .status_reg_out(sreg_out), .ALU_mux(ALU_sig),
    .inc_PC(inc_PC), .PC_jump_en(jump_en), .PC_read_bus_en(PC_read_en), .brsh(brsh), .extern(extern));

    binary_to_onehot decoder_en(.fiveBit(r_en), .OH(r_en_OH));
    binary_to_onehot decoder_tri(.fiveBit(tri_controller), .OH(tri_controller_OH))
endmodule