module program_ram(
        input clk, reset, write_enable, // 1 = Write, 0 = Read.
        input[7:0] write_address, // Initial addresses to load in.
        input[7:0] read_address, // PC address for next instruction.
        input [15:0] data_in, // instruction to store
        output reg [15:0] data_out // instruction to read
    );

    reg [15:0] ram[0:255];

    integer i;

    //Read and Write block
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i = 0; i < 256; i = i + 1) begin
                ram[i] <= 16'b0;
            end
            data_out <= 16'b0;
        end 
        else begin
            if (write_enable) begin
                ram[write_address] <= data_in; 
            end
            else begin
                data_out <= ram[read_address];    
            end     
        end
    end
    

endmodule