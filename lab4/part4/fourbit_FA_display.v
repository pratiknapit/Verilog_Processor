module fourBit_FA_display(a, b, cin, d1, d2);
    input[3:0] a, b;
    input cin;
    output [6:0] d1, d2;

    wire[3:0] s;

    fourBit_FA fourbit_adder(.a(a), .b(b), .cin(cin), .cout(), .s(s));
    decoder_7seg fourbit_display(.code(s), .decoded_output1(d1), .decoded_output2(d2));

endmodule