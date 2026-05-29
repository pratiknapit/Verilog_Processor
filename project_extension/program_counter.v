module program_counter(
        input clk, reset, start;
        input inc_PC, jump_en, read_bus_en;
        input brsh
        input [15:0] bus;
        output reg [7:0] address;
    );

    wire Z_flag, N_flag;

    wire branch_taken = (brsh & ~N_flag);
        // (brlo & N)   |
        // (brsh & ~N_flag)
        // (breq & Z)   |
        // (brne & ~Z);

    always @(posedge clk or posedge reset) begin
        if (reset || start)
            address <= 8'h00;
            Z_flag = 0;
            N_flag = 0;
        else if (read_bus_en) 
            Z_flag = bus_value[0];
            N_flag = bus_value[1];
        else if (jump_en)
            address <= address + bus_value;
        else if (branch_taken)
            address <= address + bus_value;
        else if (inc_PC)
            address <= address + 1'b1;
        else 
            Z_flag = 0;
            N_flag = 0;
    end

endmodule