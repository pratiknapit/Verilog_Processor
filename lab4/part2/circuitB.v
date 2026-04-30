module circuitB (z, d1);
    input z;
	output reg[6:0] d1; 
	
	always @(z)
	begin
	  if (z == 1'b1)
		d1 = 0x1111001; // print 1
	  else
		d1 = 0x1000000; // print 0
	end
endmodule;