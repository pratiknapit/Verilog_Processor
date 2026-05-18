`timescale 1ns / 1ps

module control_unit_TB;

    reg clk, rst;
    reg[7:0] instruction;
    control_unit my_CU(.clk(clk), .rst(rst), .instruction(instruction));

    //Initialisations
    initial clk = 0;
    initial rst = 0;
    

    always #5 clk = ~clk; // Full clock period = 10ns = 100MHz

    // Dump VCD for GTKWave
    initial begin
        $dumpfile("control_unit_TB.vcd");
        $dumpvars(0, control_unit_TB);
	end


    integer i;

    initial begin 
        rst = 1;
        #10
        rst = 0;

        // for (i = 15; i >= 0; i = i - 1) begin
        @(posedge clk); // wait for pos clock edge
        instruction = 8'b00001001; // LDI R0, 9
        // end

        #20 $finish;
    end

endmodule