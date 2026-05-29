module processor (clk, reset, write, program_in);
    input clk,
    input reset,
    input write,     
    input start,
    input [7:0] write_pmem_address;
    input [15:0] program_in,

    // -------------------------------------------------------------------------------


    wire [15:0] r_en_OH, tri_controller_OH; // one hot encoding - r_en_OH[0] enables Reg0.
    wire [15:0] bus;
    wire inc_PC, branch;
    wire [7:0]  PC_address; // 8 bit address
    
    wire [7:0]  data_ram_address;
    wire [15:0] code, ir_reg;


    // Program RAM / Flash Memory Instance - 16bit wide & 256 addresses. 
    program_ram PMEM(
        .clk(clk),
        .reset(reset),
        .write_enable(write), // Write = 1 at start of program -> Write = 0 once processor starts to Read-only
        .write_address(write_pmem_address), // Receives PC_address from PC counter and outputs the current code
        .read_address(PC_address)
        .data_in(program_in),
        .data_out(code) // Outputs code to instruction register (inst_reg)
    );

    // Program Counter Instance - Processes the current 
    program_counter inst_PC(
        .clk(clk),
        .reset(reset), // on reset -> PC = 
        .start(start),
        .inc_PC(inc_PC),
        .branch(branch_en),
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
        .inc_PC(inc_PC),
        .branch(branch_en),
        .extern(extern),
        .RAM_data_access(data_save)
    );

    // Datapath Instance
    my_Datapath datapath(
        .clk(clk),
        .reset(reset),
        .extern(extern),
        .code(ir_reg), // FIXED: Commonly needs immediate values or register fields from IR
        .r_en_OH(r_en_OH),
        .tri_controller_OH(tri_controller_OH),
    );

    // Program RAM / Flash Memory Instance - 16bit wide & 256 addresses. 
    data_ram DMEM(
        // .clk(clk),
        .write_enable(write), // Write = 1 at start of program -> Write = 0 once processor starts to Read-only
        .address(data_address), // Get from processor
        .data_in(data_save), // STS R18, ADDR
        .data_out(data_load) // Outputs code to instruction register (inst_reg)
    );

endmodule