//////////////////////////////////////////////////////////////
// fsm.sv - fsm SV code for implementation of findMax DUT
//
// Author: Drew Seidel (dseidel@pdx.edu)
// Date: 10/18/2022
// Description:
// ------------
// FSM takes in inputs clock and rst 
// As well as start signals and in_GTR_MAX signals 
// And outputs signals done and ldMax
// Mealy FSM
////////////////////////////////////////////////////////////////


module fsm (
    input logic clk, rst,           // clock and reset. Assert rst high to reset the FSM
    input logic start,              // start signal - begin looking for the max value
    input logic in_GTR_Max,         // asserted by datapath if input data > the stored max value
    output logic ldMax,             // asserted by FSM to load a new value into the register
    output logic done               // asserted by FSM to indicate the no more number will be compared until start is received

);

    enum logic {RESET = 1'b0,
                CHECK = 1'b1} STATE, NEXT_STATE; 
 
    //next state logic 
    always_comb
    begin 
        case(STATE)
        RESET: begin 
            if(!start)
                NEXT_STATE = RESET; 
            else    
                NEXT_STATE = CHECK; 
        end 
        CHECK: begin 
            if(!start)
                NEXT_STATE = RESET; 
            else    
                NEXT_STATE = CHECK; 
        end 
        endcase
    end

    //FOR 2 BLOCK STATE MACHINE UNCOMMENT LINE 52 and 53, comment 54-70.  SAME FUNCTION PERFORMED
    //assign ldMax = (STATE == RESET) ? start : (in_GTR_Max == 1) ? 1 : 0;
    //assign done = (STATE == RESET) ? 0 : start; 

   //ouput logic 
    always_comb
    begin 
        case(STATE)
            RESET: begin 
                ldMax = start; 
                done = 0;
            end 
            CHECK: begin 
                ldMax = (in_GTR_Max == 1) ? 1 : 0; 
                done = ~start; 
            end
            default: begin 
                ldMax = 1'bz; 
                done = 1'bz; 
            end 
        endcase
    end

    //sequential block
    always_ff @(posedge clk or posedge rst)
    begin 
        if(rst)
            STATE <= RESET;  
        else
            STATE <= NEXT_STATE;  
    end 


endmodule: fsm 