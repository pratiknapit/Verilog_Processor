module decoder_7seg_instantiate(SW, HEX1, HEX2);

	input[3:0] SW; // 4-bit input
	output [6:0]  HEX1;
	output [6:0] HEX2;

	decoder_7seg part1(.code(SW), .decoded_output1(HEX1), .decoded_output2(HEX2));
	

endmodule
