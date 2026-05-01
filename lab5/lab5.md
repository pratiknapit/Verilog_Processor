Part 1 - Creating a timer.
Need to use T flip flops for counters (use generate in Verilog). 

Use 50-MHz clock signal provided by the DE2 board. 

1st counter - count to 50*10^6 clock cycles given the clock signal to determine 1-second intervals. This requires at least a 26 bit counter (so 26 T flip flops).

2nd counter - count from 0 to 9 (4 bit counter) using the 1 second clock as the clock signal (from the 1st counter). (need 4 T flip flops). 

This counter counts based on an enable signal. 

module T_ff();
Generate 26 of these with generate fn to count up to 50*10^6 -> send signal as clock signal to the 1 second binary counter. 

Generate 4 T flip flops to count from 0 to 9 and then reset to 0. 


Part 2 - 