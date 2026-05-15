module processor_top(clk, reset, instruction);
    input clk;
    input reset;
    input [15:0] instruction;

    wire R0_en;
    wire bus;

    control_unit cu(.clk(), .instruction(instruction), .RO_en(R0_en), .R0_tri(R0_tri), .aluop(), .done(done))


    register reg0(.clk(clk), .reset(reset), .D(bus), R_en(R_en), .Q(tri_state_R0_in));
    register reg1(.clk(clk), .reset(reset), .D(bus), R_en(R_en), .Q(tri_state_R0_in));
    register reg2(.clk(clk), .reset(reset), .D(bus), R_en(R_en), .Q(tri_state_R0_in));

    tri_state_buffer tsbR0(tri_state_R0_in, .bus(bus))



    register A(.clk(clk), .reset(reset), .D(bus), R_en(A_in), .Q(A_out))

    ALU ALU(.alu_op(alu_op), .A(A_out), .B(bus), .result(G_in)); 

    register G(.clk(clk), .reset(reset), .D(bus), R_en(A_in), .Q(A_out))
    tri_state_buffer tsbG(tri_state_R0_in, .bus(bus))




endmodule