`timescale 1ns / 1ps

module processor_top_TB;

    reg clk, rst;
    reg [7:0] instruction;
    wire done;

    // localparam LDI = 2'b00;
    // localparam MOVE = 2'b01;

    processor_top my_processor(
        .clk(clk),
        .rst(rst),
        .instruction(instruction),
        .done(done)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("processor_top_TB.vcd");
        $dumpvars(0, processor_top_TB);
    end

    initial begin
        rst = 1;
        #10
        rst = 0;

        // Give first instruction
        @(posedge clk)
        instruction = 8'b00000101; // LDI R0, 5
        
        @(negedge done)
        instruction = 8'b00010100; // LDI R1, 4
        
        @(negedge done)
        instruction = 8'b11000100; // SUB R0, R1 => R0 = 1

        @(negedge done)
        instruction = 8'b01100000; // MOV R2, R0 => R2 = 1

        @(negedge done)
        instruction = 8'b10100100; // ADD R2, R1 => R2 = 5

        @(negedge done)
        instruction = 8'b00110111; // LDI R3, 7 

        @(negedge done)
        instruction = 8'b10111000; // ADD R3, R2 => R3 = 7+5 = 12 = C


        #50 $finish;
    end

endmodule