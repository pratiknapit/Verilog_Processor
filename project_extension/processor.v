module my_processor (clk, reset, write, start, program_in);

    input reset, clk, start, write;
    input [15:0] program_in; // instruction.

    wire [15:0] r_en, tri_state_out;
    wire [15:0] bus;

    wire inc_PC, branch; 
    wire [5:0]  program_address, data_address;
    wire [22:0] code, ir_reg, code_out;

    // Controller Instance - next_state, state_register, output_signals. - Pratik.
    my_controller control(
        .clk(clk),
        .rst(reset),
        .code(code_out),
        .r_en_OH(r_en_OH),
        .tri_controller_OH(tri_controller_OH),
        .inc_PC(inc_PC), // -> ADD -> ADD1, ADD2, ADD3 -> inc_PC => PC = PC + 1;
        .branch(branch) // BRANCH k, -> go to k lines away -> PC = PC + k + 1;
    );

    // Datapath Instance - Steven.
    my_Datapath datapath(
        .clk(clk),
        .reset(reset),
        .code(code),
        .tri_controller_OH(tri_controller_OH),
        .r_en_OH(r_en_OH),
        .bus(bus)
    );

    // Program Counter Instance - Montasir.
    my_PC inst_PC(
        .rst(reset),
        .start(start),
        .clk(clk),
        .write(write),
        .inc_PC(inc_PC),
        .branch(branch),
        .bus(bus),
        .address(address)
    );


    // Program Memory / Flash Memory Instance (instruction = 32bit wide)
    ram inst_PMEM(
        .clk(clk),
        .write_enable(write),
        .address(address),
        .data_in(program_in),
        .data_out(code)
    );

    // Instruction Register Instance
    my_inst_reg inst_reg(
        .d_in(code),
        .clk(clk),
        .en(1'b1),
        .rst(reset),
        .q_out(code_out)
    );


    // Data Memory / RAM Memory Instance (data = 16bit wide)
    ram inst_DMEM(
        .clk(clk),
        .write_enable(write),
        .address(address),
        .data_in(program_in),
        .data_out(code)
    );

endmodule