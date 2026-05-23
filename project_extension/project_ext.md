16-bit processor - designed to operate on 16-bit wide data. 
=> 16-bit wide registers, 16-bit wide bus, 16 bit wide RAM.
=> ALU performs 16bit addition, 16bit substration & 16bit logic. (Henry/Steven) - ADD, SUB, INC, DEC, LSL

For this project we will have these instructions
- LOAD Rx, 14
- MOV Rx, Ry
- ADD Rx, Ry
- SUB Rx, Ry
- INC Rx
- DEC Rx
- LSL Rx
- JMP k (Means jump to k instructions later => PC -> PC+k+1)
- CP Rx, Ry (Store in status reg N == 1 if Rx < Ry)
- BRSH k (Means branch to k instructions later if Rx >= Ry)
- BRLO k (Means branch to k instructions later if Rx < Ry)
- LDS Rx, Addr (Load addr from RAM into Rx)
- STS Addr, Rx (Store Rx value into RAM at address)

-----------> Total of 13 instructions => Need 4 bits for instruction.

We will have 16 general purpose registers (16 bit) with tri-state buffers = Register File. Each register has an enable and tri-state has out signal. 

-----------> 4 bits needed to tell us which register to use.

RAM - 256 different addresses => 8 bits for RAM address each holding 16bit values. (Steven/Henry)
-----------> 8 bits for RAM Address

-----------> Therefore we need to have at least max(4+4+4, 4+4+8) = 16 bits for the instruction -> 1st 4 bits for instruction, next 4 for first register Rx, next 4 for Ry OR next 8 for RAM Address OR next 8 for LOAD immediate value.

Program Counter (Montasir)
- Points to current instruction in program memory (256 addresses => 8 bits for address (each pointing to a 16 bit instruction)).
- Inputs = clk, rst, start
- Ouput = address (points to instruction)

Pass this instruction into the control unit. 
Control Unit (Pratik)
- Takes the instruction from the PC and then processes the correct stae. For each state -> Send the signals to the datapath module.
- Also needs an enable signal for the PC to increment called (inc_PC)

Datapath - Gets the correct signal and passes this to each registers (16in + 16out), A_reg (in), G_reg(in), PC(in),  => 40 signals.
(Pratik/Steven)

my_processor - 


