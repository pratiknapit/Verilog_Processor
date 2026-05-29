`timescale 1ns / 1ps

module processor_TB;

    reg clk, rst, write;
    reg [7:0] address;
    reg [15:0] instruction; // 16 long array of instructions each holding 15 bit value
    wire start_PC;

    processor my_processor(.clk(clk), .reset(reset), .write(write), .start(start_PC)
    .write_pmem_address(address), .program_in(instruction));

    initial clk = 0;
    always #5 clk = ~clk;

    initial reset = 1;

    initial begin 
        reset = 0;
		address = 8'h00;
	end
	
	always @(posedge clk) begin
        if (address == 8'h0A) begin
            address = address;
            write = 0;
            start_PC = 1;
        end else begin
		address = address + 8'h01;
        end
	end
	
	always @(address) begin
		case (address)
		    8'h00 : begin instruction <= {4'h0, 4'h0, 4'h0, 4'h0}; end
            8'h01 : begin instruction <= {4'h0, 4'h0, 4'h0, 4'h0}; end
            8'h02 : begin instruction <= {4'h0, 4'h0, 4'h0, 4'h0}; end
            8'h03 : begin instruction <= {4'h0, 4'h0, 4'h0, 4'h0}; end
		    default : begin instruction <= {4'h0, 4'h0, 4'h0, 4'h0};end
	    endcase
	end



endmodule