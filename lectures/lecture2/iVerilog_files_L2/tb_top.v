// iverilog -o lecture_example.vvp large_comb_function.v simple_comb_function.v simple_comb_function2.v tb_top.v top_lecture1_example.v
// vvp tb_top.vcd


`timescale 1ns/1ps // 1 unit of time step = 1ns (#5 = wait for 5ns) & 1ps = precision to update gates every picosecond

module tb_top;

    // DUT inputs - assigned within an always block (reg)
    reg a1, b1;
    reg a2, b2;
    reg a3, b3;

    // DUT outputs
    wire x, y, z;

    // Instantiate the Device Under Test (DUT)
    // Instantaites a block of hardware 
    top_lecture1_example dut (
        .a1(a1), .b1(b1),
        .a2(a2), .b2(b2),
        .a3(a3), .b3(b3),
        .x(x), .y(y), .z(z)
    );

    // only for simulation can we create an integer and use initial
    integer i;
    initial begin
        $display(" a1 b1 | a2 b2 | a3 b3 || x y z");
        $display("----------------------------------");
	
        for (i = 0; i < 64; i = i + 1) begin
//            {a1, b1, a2, b2, a3, b3} = i[5:0];
			case (i)
				0 : begin {a1, b1, a2, b2, a3, b3} = 6'b000101; end 
				1 : begin {a1, b1, a2, b2, a3, b3} = 6'b000111; end 
				2 : begin {a1, b1, a2, b2, a3, b3} = 6'b010100; end 
				default 	 : begin {a1, b1, a2, b2, a3, b3} = i[5:0];end // assigned binary value of i e.g. i = 3 = 000011 & i = 65 = 111111
			endcase
            #5;  // allow signals to propagate

            $display("  %0b  %0b |  %0b  %0b |  %0b  %0b || %0b %0b %0b",
                     a1, b1, a2, b2, a3, b3, x, y, z);
        end

        $display("----------------------------------");
        $display("Simulation complete.");
        $finish;
    end

	initial begin

        $dumpfile("tb_top.vcd");

        $dumpvars(0, tb_top);

        #1000 

        $finish;

	end

endmodule