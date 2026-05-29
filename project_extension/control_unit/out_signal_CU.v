module out_signal_CU (
    input [7:0] state,
    input [15:0] code,

    output reg [3:0] r_en,
    output reg [3:0] tri_controller_out,

    output reg A_en,
    output reg G_en,
    output reg G_out,
    output reg status_reg_en,
    output reg status_reg_out,

    output reg [2:0] ALU_mux,

    output reg inc_PC,
    output reg PC_jump_en,
    output reg PC_read_bus_en,
    output reg brsh,

    output reg DMEM_out,
    output reg DMEM_in,

    output reg [7:0] DMEM_addr,
    output reg [7:0] extern_data,

    output reg extern_en
);

    always @(*) begin

        case(state)

            8'h01 : begin
                r_en <= code[11:8];
                extern_data <= code[7:0];
                extern_en <= 1;
                inc_PC <= 1;
            end // load

            8'h02 : begin
                r_en <= code[11:8];
                tri_controller_out <= code[7:4];
                inc_PC <= 1;
            end // move

            8'h03 : begin
                tri_controller_out <= code[11:8];
                A_en <= 1;
            end // add1

            8'h04 : begin
                tri_controller_out <= code[7:4];
                G_en <= 1;
                ALU_mux <= 3'b000;
            end // add2

            8'h05 : begin
                r_en <= code[11:8];
                G_out <= 1;
                inc_PC <= 1;
            end // add3

            8'h06 : begin
                tri_controller_out <= code[11:8];
                A_en <= 1;
            end // sub1

            8'h07 : begin
                tri_controller_out <= code[7:4];
                G_en <= 1;
                ALU_mux <= 3'b001;
            end // sub2

            8'h08 : begin
                r_en <= code[11:8];
                G_out <= 1;
                inc_PC <= 1;
            end // sub3

            8'h09 : begin
                tri_controller_out <= code[11:8];
                A_en <= 1;
                ALU_mux <= 3'b010;
                G_en <= 1;
            end // inc1

            8'h0A : begin
                r_en <= code[11:8];
                G_out <= 1;
                inc_PC <= 1;
            end // inc2

            8'h0B : begin
                tri_controller_out <= code[11:8];
                A_en <= 1;
                ALU_mux <= 3'b011;
                G_en <= 1;
            end // dec1

            8'h0C : begin
                r_en <= code[11:8];
                G_out <= 1;
                inc_PC <= 1;
            end // dec2

            8'h0D : begin
                tri_controller_out <= code[11:8];
                A_en <= 1;
                ALU_mux <= 3'b100;
                G_en <= 1;
            end // lsl1

            8'h0E : begin
                r_en <= code[11:8];
                G_out <= 1;
                inc_PC <= 1;
            end // lsl2

            8'h0F : begin
                tri_controller_out <= code[11:8];
                A_en <= 1;
                ALU_mux <= 3'b101;
                G_en <= 1;
            end // lsr1

            8'h10 : begin
                r_en <= code[11:8];
                G_out <= 1;
                inc_PC <= 1;
            end // lsr2

            8'h11 : begin
                extern_data <= code[7:0];
                extern_en <= 1;
                PC_jump_en <= 1;
            end // jump

            8'h12 : begin
                tri_controller_out <= code[11:8];
                A_en <= 1;
            end // cp1

            8'h13 : begin
                tri_controller_out <= code[7:4];
                G_en <= 1;
                ALU_mux <= 3'b001;
            end // cp2

            8'h14 : begin
                status_reg_en <= 1;
                G_out <= 1;
                inc_PC <= 1;
            end // cp3

            8'h15 : begin
                status_reg_out <= 1;
                PC_read_bus_en <= 1;
            end // brsh1

            8'h16 : begin
                brsh <= 1;
                extern_data <= code[7:0];
                extern_en <= 1;
            end // brsh2

            8'h17 : begin
                DMEM_out <= 1;
                DMEM_addr <= code[7:0];
            end // lds1

            8'h18 : begin
                r_en <= code[11:8];
                inc_PC <= 1;
            end // lds2

            8'h19 : begin
                DMEM_in <= 1;
                DMEM_addr <= code[7:0];
            end // sts1

            8'h1A : begin
                tri_controller_out <= code[11:8];
                inc_PC <= 1;
            end // sts2

        endcase

    end

endmodule