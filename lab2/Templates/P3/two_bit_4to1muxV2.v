module two_bit_4to1muxV2 (s,u,v,w,x,m);
 
	input[1:0] s;
	input[1:0] u,v,w,x;
	output reg[1:0] m;
	
	reg[1:0] t1, t2;
	
	//complete always blocks (look at one_bit_4to1muxV2.v for hints. Should look the same)
	always @(u[0],v[0],s[0]) begin
		if (s[0] == 0)
			t1[0] = u[0];
		else
			t1[0] = v[0];
	end
 

	always @(w[0],x[0],s[0]) begin
		if (s[0] == 0)
			t2[0] = w[0];
		else
			t2[0] = x[0];
	end

	always @(t1[0],t2[0],s[1]) begin
		if (s[1] == 0)
			m[0] = t1[0];
		else
			m[0] = t2[0];
	end

	
endmodule
