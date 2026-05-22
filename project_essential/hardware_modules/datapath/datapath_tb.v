`timescale 1ns / 1ps

module datapath_TB;

    reg clk, rst;
    reg[13:0] datapath_signals;
    reg[3:0] immediate_data;

    //Initialisations
    initial clk = 0;
    initial rst = 0;

    datapath mydatapath(.clk(clk), .rst(rst), 
    .datapath_signals(datapath_signals), .immediate_data(immediate_data));
    

    always #5 clk = ~clk; // Full clock period = 10ns = 100MHz

    // Dump VCD for GTKWave
    initial begin
        $dumpfile("datapath_TB.vcd");
        $dumpvars(0, datapath_TB);
	end


    integer i;

    initial begin 
        rst = 1;
        #10
        rst = 0;

        // for (i = 15; i >= 0; i = i - 1) begin
        @(posedge clk); // wait for pos clock edge
        datapath_signals = 14'b11000000000001; // LDI R0, 5
        immediate_data = 4'b0101;
        @(posedge clk);
        datapath_signals = 14'b11000000000010; // LDI R1, 4
        immediate_data = 4'b0100;
        @(posedge clk);
        datapath_signals = 14'b00000100010000; // ADD1
        @(posedge clk);
        datapath_signals = 14'b00001000100000; // ADD2
        @(posedge clk);
        datapath_signals = 14'b10010000000001; // ADD3

        #20 $finish;
    end

endmodule