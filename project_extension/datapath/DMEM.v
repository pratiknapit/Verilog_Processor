module DMEM(
    input wire clk,
    input wire we, 
    input wire re,                 // write enable
    input wire [7:0] address,      // 256 addresses
    input wire [15:0] d_in,         // data input
    output reg [15:0] d_out         // data output
);

    // 256 x 8-bit RAM
    reg [7:0] memory [0:255];

    // synchronous write
    always @(posedge clk) begin
        if (we)
            memory[address] <= d_in;
        else if (re)
            d_out = memory[address];
    end

endmodule