module out_signal_CU.v (
    input[7:0] state;
    input[15:0] code;
    output reg[3:0] r_en;
    output reg[3:0] tri_controller_out;
    output A_en, G_en, G_out, status_reg_en, status_reg_out;
    output[2:0] ALU_mux; 
    output inc_PC, PC_jump_en, PC_read_bus_en, brsh;
    output DMEM_out, DMEM_in;
    output[7:0] DMEM_addr;
    output[7:0] extern_data;
    output extern_en; 
    );

    // Set all signals to 0 first.

    always @(state) begin
        case(state)
            8'h01 : begin r_en <= code[11:8]; extern <= code[7:0] ; extern_en = 1;  PC_inc <= 1; end // load
            8'h02 : begin r_en <= code[11:8]; tri_controller_out <= [7:4] ; PC_inc <= 1; end // move
            8'h03 : begin tri_controller_out <= code[11:8]; A_en <= 1; end // add1
            8'h04 : begin tri_controller_out <= code[7:4]; G_en <= 1; ALU_mux <= 3'b000; end // add2
            8'h05 : begin r_en <= code[11:8]; G_out <= 1, PC_inc <= 1; end // add3
            8'h06 : begin tri_controller_out <= code[11:8]; A_en <= 1; end // sub1
            8'h07 : begin tri_controller_out <= code[7:4]; G_en <= 1; ALU_mux <= 3'b001; end //sub2
            8'h08 : begin r_en <= code[11:8]; G_out <= 1, PC_inc <= 1; end // sub3
            8'h09 : begin tri_controller_out <= code[11:8]; A_en <= 1; ALU_mux <= 3'b010; G_en <= 1;end //inc1
            8'h0A : begin r_en <= code[11:8]; G_out <= 1, PC_inc <= 1; end // inc2
            8'h0B : begin tri_controller_out <= code[11:8]; A_en <= 1; ALU_mux <= 3'b011; G_en <= 1;end //dec1
            8'h0C : begin r_en <= code[11:8]; G_out <= 1, PC_inc <= 1; end // dec2
            8'h0D : begin tri_controller_out <= code[11:8]; A_en <= 1; ALU_mux <= 3'b100; G_en <= 1;end //lsl1
            8'h0E : begin r_en <= code[11:8]; G_out <= 1, PC_inc <= 1; end // lsl2
            8'h0F : begin tri_controller_out <= code[11:8]; A_en <= 1; ALU_mux <= 3'b101; G_en <= 1;end //lsr1
            8'h10 : begin r_en <= code[11:8]; G_out <= 1, PC_inc <= 1; end // lsr2
            8'h11 : begin extern <= code[7:0] ; extern_en = 1; PC_jump_en <= 1; end // jump 0000 k
            8'h12 : begin tri_controller_out <= code[11:8]; A_en <= 1; end // cp1
            8'h13 : begin tri_controller_out <= code[7:4]; G_en <= 1; ALU_mux <= 3'b001; end //cp2
            8'h14 : begin status_reg_en <= 1; G_out <= 1, PC_inc <= 1; end // cp3
            8'h15 : begin status_reg_out <= 1; PC_read_bus_en <= 1; end // brsh1 0000 k
            8'h16 : begin brsh <= 1 ; extern <= code[7:0]; extern_en = 1; end // brsh2
            8'h17 : begin DMEM_out <= 1; DMEM_addr <= code[7:0]; end // lds r1, 8bitaddress
            8'h18 : begin r_en <= code[11:8]; PC_inc <= 1; end // lds2 r1, 8bitaddress
            8'h19 : begin DMEM_in <= 1; DMEM_addr <= code[7:0]; end // lds r1, 8bitaddress
            8'h1A : begin tri_controller_out <= code[11:8]; PC_inc <= 1; end // lds2 r1, 8bitaddress
        endcase

    end

endmodule