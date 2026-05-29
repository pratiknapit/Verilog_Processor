module tri_state_buffer(en, in, out);
    input en;
    input[15:0] in;
    output reg[15:0] out;
    always @ (en or in) begin
        if (en)
            out <= in;
        else
            out <= 4'bz;
    end
endmodule