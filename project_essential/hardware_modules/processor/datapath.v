module datapath(clk, rst, datapath_signals, immediate_data, done);
    input clk, rst;
    input[3:0] immediate_data;
    input[13:0] datapath_signals;
    output done;

    
    wire extern, AddSub, G_out, G_en, A_en, R3_out, R2_out, R1_out, R0_out, R3_en, R2_en, R1_en, R0_en;
    assign {done, extern, AddSub, G_out, G_en, A_en, R3_out, R2_out, R1_out, R0_out, R3_en, R2_en, R1_en, R0_en} = datapath_signals;

    wire[3:0] four_bit_bus, R0_Q, R1_Q, R2_Q, R3_Q, ALU_arg1, ALU_result, G_Q;

    four_bit_tri_buf extern_data(.en(extern), .in(immediate_data), .out(four_bit_bus));

    four_bit_register_en R0(.clk(clk), .rst(rst), .en(R0_en), .D(four_bit_bus), .Q(R0_Q));
    four_bit_tri_buf R0_tri(.en(R0_out), .in(R0_Q), .out(four_bit_bus));

    four_bit_register_en R1(.clk(clk), .rst(rst), .en(R1_en), .D(four_bit_bus), .Q(R1_Q));
    four_bit_tri_buf R1_tri(.en(R1_out), .in(R1_Q), .out(four_bit_bus));

    four_bit_register_en R2(.clk(clk), .rst(rst), .en(R2_en), .D(four_bit_bus), .Q(R2_Q));
    four_bit_tri_buf R2_tri(.en(R2_out), .in(R2_Q), .out(four_bit_bus));

    four_bit_register_en R3(.clk(clk), .rst(rst), .en(R3_en), .D(four_bit_bus), .Q(R3_Q));
    four_bit_tri_buf R3_tri(.en(R3_out), .in(R3_Q), .out(four_bit_bus));

    four_bit_register_en A(.clk(clk), .rst(rst), .en(A_en), .D(four_bit_bus), .Q(ALU_arg1));
    ALU adder(.A(ALU_arg1), .B(four_bit_bus), .addSub(AddSub), .result(ALU_result));

    four_bit_register_en G(.clk(clk), .rst(rst), .en(G_en), .D(ALU_result), .Q(G_Q));
    four_bit_tri_buf G_tri(.en(G_out), .in(G_Q), .out(four_bit_bus));


endmodule