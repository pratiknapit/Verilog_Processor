module labtest_q2_hardware  (a,b,c,d,x);
    input[3:0] a, b, d; // 4-bit wire inputs
	input c;
    output[3:0] x;

    wire[1:0] t1; //2 bit wire - signal for multiplex.
    wire[3:0] t2,t3; //you may use this, but do not have to
    reg[3:0] t5; //you may use this, but do not have to

    circuitA comb1(.a(a),.b(b),.c(c),.x(t1),.y(t2));
    circuitB comb2(.a(d),.b(a),.x(t3));

    // 4 to 1 multiplex - using t1 as a signal.
    always @(t1) begin
        case (t1)
            2'b00 : begin t5<=t2; end
            2'b01 : begin t5<=b; end
            2'b10 : begin t5<=t3; end
            default : begin t5<=d; end
        endcase
    end
    
    circuitC comb3(.a(t5),.b(d),.x(x));
endmodule