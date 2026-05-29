module program_counter(
    clk, reset, start, read_bus_en,
    inc_PC, jump_en,
    brlo, breq, brne, brsh,
    Z_flag, C_flag,
    bus,
    address
);

    input clk, reset, start;
    input inc_PC, jump_en;
    input brlo, breq, brne, brsh;
    input Z_flag, N_flag;
    input [15:0] bus;

    output reg [7:0] address;

    wire [7:0] bus_value = bus[7:0];

    wire branch_taken =
        (brlo & N)   |
        (brsh & ~N)  |
        (breq & Z)   |
        (brne & ~Z);

    always @(posedge clk or posedge reset) begin
        if (reset || start)
            address <= 8'h00;
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