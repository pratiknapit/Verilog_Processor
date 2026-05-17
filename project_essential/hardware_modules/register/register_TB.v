`timescale 1ns / 1ps // So #50 = 50ns

module register_TB;
    reg clk, rst, D;
    wire Q;

    register register(
        .clk(clk),
        .rst(rst),
        .D(D),
        .Q(Q)
    );

    initial clk = 1'b0;
    initial rst = 1'b1;
    initial D = 1'b0;

    //clock generation
    always #5 clk = ~clk;

    // Dump VCD for GTKWave
    initial begin
        $dumpfile("register_TB.vcd");
        $dumpvars(0, register_TB);
	end

    reg[7:0] D_sequence_input = 8'b00001111;
    integer i;
    initial begin
        #10
        rst = 0;

        for (i = 7; i >= 0; i = i - 1) begin
            @(posedge clk); // wait for pos clock edge
            D = D_sequence_input[i];
        end

        #20 $finish;
    end 



endmodule