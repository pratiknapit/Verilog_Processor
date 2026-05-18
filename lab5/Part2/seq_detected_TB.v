`timescale 1ns/1ps

module seq_detector_TB;

    reg clk, rst, in;
    wire detected;
    seq_detector my_detector(.clk(clk), .rst(rst), .in(in), .detected(detected));

    // Clock generation 
    initial clk = 0;
    initial in = 0;
    initial rst = 0;

    always #5 clk = ~clk; // Full clock period = 10ns = 100MHz

        // Dump VCD for GTKWave
    initial begin
        $dumpfile("seq_detector_TB.vcd");
        $dumpvars(0, seq_detector_TB);
	end


    // Input sequence
    reg [15:0] pattern = 16'b0101000010111110;
    integer i;

    initial begin 
        rst = 1;
        #10
        rst = 0;

        for (i = 15; i >= 0; i = i - 1) begin
            @(posedge clk); // wait for pos clock edge
            in = pattern[i];
        end

        #20 $finish;
    end


endmodule