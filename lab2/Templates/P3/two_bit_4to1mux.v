module two_bit_4to1mux (s,u,v,w,x,m);
 
	input[1:0] s;
	input[1:0] u, v, w, x;
	output[1:0] m;
	
	one_bit_4to1mux mux1(.s(s), .u(u[0]), .v(v[0]), .w(w[0]), .x(x[0]), .m(m[0])); //complete instantiation
	//complete other instantiations

	one_bit_4to1mux mux2(.s(s), .u(u[1]), .v(v[1]), .w(w[1]), .x(x[1]), .m(m[1]));



endmodule
