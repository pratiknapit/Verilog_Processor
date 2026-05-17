module output_signal(state, detected);

    input [3:0] state;
    output reg detected;

    always @(state) begin
        case (state)
            4'b0100: begin detected = 1'b1; end
            4'b1000: begin detected = 1'b1; end
            default: begin detected = 1'b0; end
        endcase
    end

endmodule