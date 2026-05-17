module control_unit(state_reg(in) instruction, signals, state_reg(out))

    state_register state_reg(state_reg_out);

    signals signals(state_reg_out, control_unit_signals);




    input instruction[9:0];

    instruction = 10 0001 0010 

    opcode = instruction[9:8] = 10

    case:
        //ADD
        if opcode = 10: 
            Rx = instruction[7:4] = 0001

            Ry = instruction[3:0] = 0010
            
            state_reg_out = add
            



    if add2
    r2 tri = 1

            
            

        // LOAD
        if opcode = 00 
            Rx = instruction[7:4] = 0001
            Value = 0010





    endcase



    register stateregister();

    truth table:


endmodule