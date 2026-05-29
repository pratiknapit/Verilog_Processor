module de1_soc_top(
    input CLOCK_50,       // 50 MHz clock from DE1-SoC
    input [3:0] KEY,      // Push buttons (Active-Low)
    input [9:0] SW,       // Switches
    output [6:0] HEX0,    // 7-segment display 0
    output [6:0] HEX1,    // 7-segment display 1
    output [6:0] HEX2,    // 7-segment display 2
    output [6:0] HEX3     // 7-segment display 3
);

    // DE1-SoC KEYs are normally HIGH (1) and go LOW (0) when pressed.
    // We invert them here so your processor sees a normal Active-High signal.
    wire reset = ~KEY[0]; 
    wire start = ~KEY[1]; 
    
    // We will use Switches [3:0] to select which register (R0 - R15) you want to view
    wire [3:0] reg_sel = SW[3:0];
    
    // This wire catches the 16-bit value of the selected register from the processor
    wire [15:0] reg_value;

    // Instantiate your processor
    processor my_processor(
        .clk(CLOCK_50),
        .reset(reset),
        .write(1'b0),          // Hardwired to 0 (we are not writing instructions via switches)
        .start(start),
        .write_pmem_address(8'h00),
        .program_in(16'h0000),
        
        // --- NEW DEBUG PORTS ---
        .debug_sel(reg_sel),   
        .debug_out(reg_value)  
    );

    // Instantiate Hex Decoders to show the 16-bit register value on the board
    hex_decoder h0(.hex_digit(reg_value[3:0]),   .segments(HEX0));
    hex_decoder h1(.hex_digit(reg_value[7:4]),   .segments(HEX1));
    hex_decoder h2(.hex_digit(reg_value[11:8]),  .segments(HEX2));
    hex_decoder h3(.hex_digit(reg_value[15:12]), .segments(HEX3));

endmodule