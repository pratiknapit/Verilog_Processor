module program_counter(
        input clk, reset, start,
        input inc_PC, jump_en, read_bus_en,
        input brsh,
        input [15:0] bus,
        output reg [7:0] address
    );

    reg N_flag;
    wire [15:0] bus_value = bus;
    wire branch_taken = (brsh & ~N_flag);

    always @(posedge clk or posedge reset) begin
        if (reset || start) begin
            address <= 8'h00;
            N_flag <= 1'b0;
        end
        else begin
            if (read_bus_en)
                N_flag <= bus_value[15];
            else if (jump_en)
                address <= address + bus_value[7:0];
            else if (branch_taken)
                address <= address + bus_value[7:0];
            else if (inc_PC)
                address <= address + 1'b1;
        end
    end

endmodule