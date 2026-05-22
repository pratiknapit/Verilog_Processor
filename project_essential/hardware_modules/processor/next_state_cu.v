module next_state_cu(state, in, rst, n_state);
    input[3:0] state;
    input[1:0] in;
    input rst;
    output reg[3:0] n_state;

    wire[5:0] temp;
    assign temp = {state, in};

    always @(posedge rst) begin
        if (rst == 1'b1)
            n_state <= 4'b0000;
    end

    always @(temp) begin
        casez(temp)
            6'b000000 : begin n_state <= 4'b0001; end // go to LOAD
            6'b000001 : begin n_state <= 4'b0101; end // go to MOV
            6'b000010 : begin n_state <= 4'b0010; end // go to ADD1
            6'b000011 : begin n_state <= 4'b0110; end // RESTART -> SUB1
            6'b0001?? : begin n_state <= 4'b0000; end // LOAD -> RESTART
            6'b0010?? : begin n_state <= 4'b0011; end // go to ADD2
            6'b0011?? : begin n_state <= 4'b0100; end // go to ADD3
            6'b0100?? : begin n_state <= 4'b0000; end // go to RESTART
            6'b0101?? : begin n_state <= 4'b0000; end // MOV -> RESTART
            6'b0110?? : begin n_state <= 4'b0111; end // SUB1 -> SUB2
            6'b0111?? : begin n_state <= 4'b1000; end // SUB2 -> SUB3
            default : begin n_state <= 4'b0000; end // SUB3 -> RESTART
        endcase
    end


endmodule