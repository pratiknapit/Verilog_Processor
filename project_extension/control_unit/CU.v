module CU(
        input clk, reset,
        input[15:0] instruction,
        output[15:0] r_en_OH, //16 register enable signals
        output[15:0] tri_controller_OH, //16 register enable signals
        output A_en, G_en, G_out, status_reg_en, status_reg_out,
        output[2:0] ALU_mux,
        output inc_PC, PC_jump_en, PC_read_bus_en, brsh,
        output DMEM_out, DMEM_in,
        output[7:0] DMEM_addr,
        output[7:0] extern_data,
        output extern_en
    );

    wire[7:0] current_state_wire, next_state_wire; // Store in 4bit register
    wire [3:0] r_en, tri_controller;

    ns_CU next_state(.reset(reset), .state(current_state_wire), .inst(instruction), .n_state(next_state_wire));
    state_register_CU st_reg(.clk(clk), .reset(reset), .D(next_state_wire), .Q(current_state_wire));
    out_signal_CU output_signal(.state(current_state_wire), .code(instruction), .r_en(r_en), .tri_controller_out(tri_controller),
    .A_en(A_en), .G_en(G_en), .G_out(G_out), .status_reg_en(sreg_en), .status_reg_out(sreg_out), .ALU_mux(ALU_mux),
    .inc_PC(inc_PC), .PC_jump_en(jump_en), .PC_read_bus_en(PC_read_en), .brsh(brsh), .DMEM_out(dmem_out), .DMEM_in(dmem_in),
    .DMEM_addr(DMEM_addr), .extern_data(extern_data), .extern_en(extern_en));

    binary_to_onehot decoder_en(.fourbit(r_en), .onehot(r_en_OH));
    binary_to_onehot decoder_tri(.fourbit(tri_controller), .onehot(tri_controller_OH));
endmodule