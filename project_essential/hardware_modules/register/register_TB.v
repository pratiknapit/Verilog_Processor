`timescale 1ns / 1ps // So #50 = 50ns

module register_TB;
    reg clk;
    reg rst;
    reg [7:0] D;
    wire [7:0] Q;

    register register(
        .clk(clk),
        .rst(rst),
        .D(D),
        .Q(Q)
    );

    //clock generation
    initial begin
        clk = 1'b0;
        rst = 1'b1;
    end

    always begin
        #5
        clk = ~clk;
    end

    always @(clk) begin
        #10
        rst = 0;

        #10
        D = 8'b00001111;

        #10
        rst = 1;
    end 

    // Dump VCD for GTKWave
    initial begin
        $dumpfile("project_registers_TB.vcd");
        $dumpvars(0, register_TB);
        #1000 
        $finish;
	end



endmodule