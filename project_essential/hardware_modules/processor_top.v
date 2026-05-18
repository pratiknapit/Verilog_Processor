module processor_top(clk, rst, instruction);
    input clk;
    input rst;
    input [15:0] instruction;

    wire[13:0] datapath_wires;
    wire[3:0] data_load;

    control_unit CU(.clk(clk), .rst(rst), .instruction(instruction), .datapath_signals(datapath_wires), .immediate_data(data_load)));
    datapath DP(.clk(clk), .rst(rst), .datapath_signals(datapath_wires), .immediate_data(data_load));
    
endmodule