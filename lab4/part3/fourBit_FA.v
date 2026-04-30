module fourBit_FA(a,b,cin,cout,s);
	//some inputs and outputs are 1-bit, some are 4-bit
	input[3:0] a, b;
	input cin;
	output reg cout;
	output[3:0] reg s;

	wire c1, c2, c3;

	FA fa1(.b(b[0]), .a(a[0]), .cin(cin), .cout(c1), .s(s[0]));
	FA fa2(.b(b[1]), .a(a[1]), .cin(c1), .cout(c2), .s(s[1]));
	FA fa3(.b(b[2]), .a(a[2]), .cin(c2), .cout(c3), .s(s[2]));
	FA fa4(.b(b[3]), .a(a[3]), .cin(c3), .cout(cout), .s(s[3]));


endmodule