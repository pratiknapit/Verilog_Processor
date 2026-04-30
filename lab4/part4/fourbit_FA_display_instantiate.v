module fourBit_FA_display(SW, HEX1, HEX2);
    input[8:0] SW
    output [6:0] HEX1, HEX2;

    fourBit_FA_display display(.a(SW[3:0]), .b(SW[7:4]), .cin(SW[8]), .d1(HEX1), .d2(HEX2));
endmodule