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

        #10
        instruction = 8'b00001001; // LDI R0, 9
        #20
        instruction = 8'b01001000; // MOV R0, R2
        #20
        instruction = 8'b10110000; // ADD R1, R2
        #40

        #10 $finish;
    end

endmodule