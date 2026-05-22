module four_bit_tri_buf(en, in, out);
    input en;
    input[3:0] in;
    output reg[3:0] out;
    always @ (en or in) begin
        if (en)
            out <= in;
        else
            out <= 4'bz;
    end
endmodule
