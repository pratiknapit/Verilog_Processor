module 1second_counter(CLK_50, HEX1, HEX2);

    input CLK_50;
    output[6:0] HEX1, HEX2;

    wire sec_1;
    wire[3:0] 4bit_Q;

    counter_26bit counter_26(.clk(CLK_50), .reset(KEY0), .sec_1(sec_1));
    counter_4bit counter4(.clk(sec_1), .reset(KEY0), .Q(4bit_Q));
    4bit_decoder_7seg display(.code(4bit_Q), .decoded_output1(HEX1), .decoded_output2(HEX2));

endmodule