`timescale 1ns / 1ps

module datapath_TB;

    reg clk, rst;
    reg[13:0] datapath_signals;
    reg[3:0] immediate_data;
    wire[3:0] reg0_value, reg1_value, reg2_value, reg3_value; 

    //Initialisations
    initial clk = 0;
    initial rst = 0;

    datapath mydatapath(.clk(clk), .rst(rst), 
    .datapath_signals(datapath_signals), .immediate_data(immediate_data),
    .reg0_out(reg0_value), .reg1_out(reg1_value),
    .reg2_out(reg2_value), .reg3_out(reg3_value));
    

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
        datapath_signals = 13'b110000000001; // LDI R0, 5
        immediate_data = 4'b0101;
        @(posedge clk);
        datapath_signals = 13'b110000000010; // LDI R1, 4
        immediate_data = 4'b0100;

        #20 $finish;
    end

endmodule