module top_lecture1_example (
    input  wire a1, b1,
    input  wire a2, b2,
    input  wire a3, b3,
    output wire x,
    output wire y,
    output wire z
);

    // Internal wires between blocks
    wire c1_x, c1_y;
    wire c2_x, c2_y;
    wire c3_x, c3_y;

    // Instantiate comb blocks
    simple_comb_function comb1 (
        .a(a1),
        .b(b1),
        .x(c1_x),
        .y(c1_y)
    );

    simple_comb_function comb2 (
        .a(a2),
        .b(b2),
        .x(c2_x),
        .y(c2_y)
    );

    simple_comb_function2 comb3 (
        .a(a3),
        .b(b3),
        .x(c3_x),
        .y(c3_y)
    );

    // Final combinational block
    large_comb_function comb4 (
        .a(c1_x),
        .b(c1_y),
        .c(c2_x),
        .d(c2_y),
        .e(c3_x),
        .f(c3_y),
        .x(x),
        .y(y),
        .z(z)
    );

endmodule