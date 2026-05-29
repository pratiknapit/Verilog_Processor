module out_signal_CU (
    input [7:0] state,
    input [15:0] code,

    output reg [3:0] r_en,
    output reg [3:0] tri_controller_out,
    output reg r_we, 
    output reg r_re, 

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
        // Defaults
        r_en = 4'b0000;
        tri_controller_out = 4'b0000;
        r_we = 0;
        r_re = 0;
        A_en = 0;
        G_en = 0;
        G_out = 0;
        status_reg_en = 0;
        status_reg_out = 0;
        ALU_mux = 3'b000;
        inc_PC = 0;
        PC_jump_en = 0;
        PC_read_bus_en = 0;
        brsh = 0;
        DMEM_out = 0;
        DMEM_in = 0;
        DMEM_addr = 8'h00;
        extern_data = 8'h00;
        extern_en = 0;

        case(state)
            8'h01 : begin
                r_we = 1; r_en = code[11:8];
                extern_data = code[7:0];
                extern_en = 1; inc_PC = 1;
            end 
            8'h02 : begin
                r_we = 1; r_en = code[11:8];
                r_re = 1; tri_controller_out = code[7:4];
                inc_PC = 1;
            end 
            8'h03 : begin
                r_re = 1; tri_controller_out = code[11:8];
                A_en = 1;
            end 
            8'h04 : begin
                r_re = 1; tri_controller_out = code[7:4];
                G_en = 1; ALU_mux = 3'b000;
            end 
            8'h05 : begin
                r_we = 1; r_en = code[11:8];
                G_out = 1; inc_PC = 1;
            end 
            8'h06 : begin
                r_re = 1; tri_controller_out = code[11:8];
                A_en = 1;
            end 
            8'h07 : begin
                r_re = 1; tri_controller_out = code[7:4];
                G_en = 1; ALU_mux = 3'b001;
            end 
            8'h08 : begin
                r_we = 1; r_en = code[11:8];
                G_out = 1; inc_PC = 1;
            end 
            8'h09 : begin
                r_re = 1; tri_controller_out = code[11:8];
                A_en = 1; ALU_mux = 3'b010; G_en = 1;
            end 
            8'h0A : begin
                r_we = 1; r_en = code[11:8];
                G_out = 1; inc_PC = 1;
            end 
            8'h0B : begin
                r_re = 1; tri_controller_out = code[11:8];
                A_en = 1; ALU_mux = 3'b011; G_en = 1;
            end 
            8'h0C : begin
                r_we = 1; r_en = code[11:8];
                G_out = 1; inc_PC = 1;
            end 
            8'h0D : begin
                r_re = 1; tri_controller_out = code[11:8];
                A_en = 1; ALU_mux = 3'b100; G_en = 1;
            end 
            8'h0E : begin
                r_we = 1; r_en = code[11:8];
                G_out = 1; inc_PC = 1;
            end 
            8'h0F : begin
                r_re = 1; tri_controller_out = code[11:8];
                A_en = 1; ALU_mux = 3'b101; G_en = 1;
            end 
            8'h10 : begin
                r_we = 1; r_en = code[11:8];
                G_out = 1; inc_PC = 1;
            end 
            8'h11 : begin
                extern_data = code[7:0];
                extern_en = 1; PC_jump_en = 1;
            end 
            8'h12 : begin
                r_re = 1; tri_controller_out = code[11:8];
                A_en = 1;
            end 
            8'h13 : begin
                r_re = 1; tri_controller_out = code[7:4];
                G_en = 1; ALU_mux = 3'b001;
            end 
            8'h14 : begin
                status_reg_en = 1; G_out = 1; inc_PC = 1;
            end 
            8'h15 : begin
                status_reg_out = 1; PC_read_bus_en = 1;
            end 
            8'h16 : begin
                brsh = 1; extern_data = code[7:0];
                extern_en = 1; inc_PC = 1;
            end 
            
            // --- FIXED MEMORY STATES ---
            8'h17 : begin
                DMEM_addr = code[7:0]; // Setup address
            end 
            8'h18 : begin
                DMEM_out = 1;          // Put data on bus
                DMEM_addr = code[7:0]; // Maintain address
                r_we = 1;              // Latch bus into register
                r_en = code[11:8];
                inc_PC = 1;
            end 
            8'h19 : begin
                DMEM_addr = code[7:0]; // Setup address
            end 
            8'h1A : begin
                DMEM_in = 1;           // Send write strobe
                DMEM_addr = code[7:0]; // Maintain address
                r_re = 1;              // Register puts data on bus
                tri_controller_out = code[11:8];
                inc_PC = 1;
            end 
        endcase
    end
endmodule