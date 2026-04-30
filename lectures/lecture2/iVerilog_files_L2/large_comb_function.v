module large_comb_function (
    input  wire a,
    input  wire b,
    input  wire c,
    input  wire d,
    input  wire e,
    input  wire f,
    output wire x,
    output wire y,
    output wire z
);
    assign x = a & c & e;
    assign y = b | d | f;
    assign z = a ^ b ^ c ^ d ^ e ^ f;
endmodule