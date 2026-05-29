`timescale 1ns / 1ps

module processor_TB;

    reg clk, reset, write;
    reg [7:0] address;
    reg [15:0] instruction;
    reg start_PC;

    wire [7:0] write_addr;

    processor my_processor(
        .clk(clk),
        .reset(reset),
        .write(write),
        .start(start_PC),
        .write_pmem_address(address),
        .program_in(instruction)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    integer i;

    initial begin
        reset = 1;
        write = 1;
        start_PC = 0;
        address = 8'h00;
        instruction = 16'h0000;

        #20 reset = 0;

        // -----------------------------
        // Load instructions into PMEM
        // -----------------------------
        #10;
        write = 1;

        for (i = 0; i < 4; i = i + 1) begin
            @(posedge clk);
            address = i[7:0];
        end

        // stop writing
        @(posedge clk);
        write = 0;

        // -----------------------------
        // start processor execution
        // -----------------------------
        @(posedge clk);
        start_PC = 1;

        @(posedge clk);
        start_PC = 0;

        // let CPU run
        #5000;

        $finish;
    end

    always @(address) begin
        case (address)
            8'h00: instruction = {4'h0, 4'h1, 4'h0, 4'h1};
            8'h01: instruction = {4'h0, 4'h2, 4'h0, 4'h2};
            8'h02: instruction = {4'h0, 4'h3, 4'h0, 4'h8};
            8'h03: instruction = {4'h0, 4'h4, 4'h1, 4'h0};
            default: instruction = 16'h0000;
        endcase
    end

    initial begin
        $dumpfile("processor_TB.vcd");
        $dumpvars(0, processor_TB);
    end

endmodule