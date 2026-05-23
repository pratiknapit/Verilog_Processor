module my_processor (clk, reset, write, start, program_in);

    input reset, clk, start, write;
    input [22:0] program_in;

    wire [19:0] r_en_OH, tri_controller_OH;
    wire [15:0] bus;
    wire inc_PC, branch;
    wire [5:0]  address;
    wire [22:0] code, ir_reg;

    // Controller Instance
    my_controller control(
        .clk(clk),
        .rst(reset),
        .code(code),
        .r_en_OH(r_en_OH),
        .tri_controller_OH(tri_controller_OH),
        .inc_PC(inc_PC),
        .branch(branch)
    );

    // Datapath Instance
    my_Datapath datapath(
        .clk(clk),
        .reset(reset),
        .code(code),
        .tri_controller_OH(tri_controller_OH),
        .r_en_OH(r_en_OH),
        .bus(bus)
    );

    // Program Counter Instance
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

    // Instruction Register Instance
    my_inst_reg inst_reg(
        .d_in(code),
        .clk(clk),
        .en(1'b1),
        .rst(reset),
        .q_out(ir_reg)
    );

    // RAM / Flash Memory Instance
    ram inst_FM(
        .clk(clk),
        .write_enable(write),
        .address(address),
        .data_in(program_in),
        .data_out(code)
    );

endmodule