module processor (clk, reset, write, program_in);
    input clk,
    input reset,
    input write,     
    input start,
    input [7:0] write_pmem_address;
    input [15:0] program_in,

    // -------------------------------------------------------------------------------

    wire [15:0] bus;
    wire [15:0] code;
    wire [7:0] PC_address;
    wire inc_PC, jump_en, read_bus_en, brsh;
    wire [15:0] r_en_OH, tri_controller_OH; 
    wire A_en, G_en, G_out, status_reg_en, status_reg_out;
    wire [2:0] ALU_mux;
    wire dmem_out, dmem_in;
    wire [7:0] dmem_addr;
    wire [7:0] extern_data;
    wire extern_en; 




    // Program RAM / Flash Memory Instance - 16bit wide & 256 addresses. 
    program_ram PMEM(
        .clk(clk),
        .reset(reset),
        .write_enable(write), // Write = 1 at start of program -> Write = 0 once processor starts to Read-only
        .write_address(write_pmem_address), // Receives PC_address from PC counter and outputs the current code
        .read_address(PC_address),
        .data_in(program_in),
        .data_out(code) // Outputs code to instruction register (inst_reg)
    );

    // Program Counter Instance - Processes the current 
    program_counter inst_PC(
        .clk(clk),
        .reset(reset), // on reset -> PC = 
        .start(start),
        .inc_PC(inc_PC),
        .jump_en(jump_en),
        .read_bus_en(read_bus_en),
        .brsh(brsh),
        .bus(bus), // accept branch amount from bus if branch_en = 1;
        .address(PC_address) // output the PC address.
    );

    // Instruction Register Instance
    // Captured from RAM ('code') on the clock edge
    instruction_reg my_inst_reg(
        .clk(clk),
        .reset(reset),
        .d_in(code),
        .q_out(ir_code) // This is your stable, clocked instruction
    );

    // Controller Instance - Pratik
    my_controller control(
        .clk(clk),
        .reset(reset),
        .instruction(ir_code), // Gets 16-bit code from IR
        .r_en_OH(r_en_OH),
        .tri_controller_OH(tri_controller_OH),
        .A_en(A_en), 
        .G_en(G_en), 
        .G_out(G_out), 
        .status_reg_en(sreg_en), 
        .status_reg_out(sreg_out), 
        .ALU_mux(ALU_sig),
        .inc_PC(inc_PC), // Go to PC
        .PC_jump_en(jump_en), // Go to PC
        .PC_read_bus_en(read_bus_en), // Go to PC
        .brsh(brsh), // Go to PC
        .DMEM_out(dmem_out), 
        .DMEM_in(dmem_in),
        .DMEM_addr(dmem_addr), 
        .extern_en(extern_en),
        .extern_data(extern_data),
    );

    // Datapath Instance
    datapath my_datapath(
        .clk(clk),
        .reset(reset),
        .r_en_OH(r_en_OH),
        .tri_controller_OH(tri_controller_OH),
        .A_en(A_en), 
        .G_en(G_en), 
        .G_out(G_out), 
        .status_reg_en(sreg_en), 
        .status_reg_out(sreg_out), 
        .ALU_mux(ALU_sig), 
        .DMEM_out(dmem_out), 
        .DMEM_in(dmem_in),
        .DMEM_addr(dmem_addr), 
        .extern_en(extern_en),
        .extern_data(extern_data),
        .bus(bus);
    );

endmodule