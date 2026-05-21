module four_bit_tri_buf(en, in, out);
    input en;
    input[3:0] in;
    output reg[3:0] out;
    always @ (en or in) begin
        if (en)
            out <= in;
        else
            out <= 1'b0;
    end
endmodule
