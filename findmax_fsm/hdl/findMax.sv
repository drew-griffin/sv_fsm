//////////////////////////////////////////////////////////////
// findMax.sv - findMax instantiates all design modules and combines them together accordingly
//
// Author: Drew Seidel (dseidel@pdx.edu)
// Date: 10/18/2022 
// Description:
// ------------
// Module connects the register, FSM, and comparator pieces together and instantiates them 
////////////////////////////////////////////////////////////////


module findMax
(
    input clk, rst,                 // clock and reset signals. rst is asserted high 
                                    // to clear register and reset FSM
    input logic start,              // start signal asserted to start detecting a max 
                                    // value from a stream of input values                   
    input logic [7:0] inputA,       // holds the input data that is streamed to
                                    // the findMax FSM-D
    output logic [7:0] maxValue,    // holds the current maximum value for the sequence 
                                    // being checked
    output done                     // asserted high for one cycle when the checking
                                    // sequence is complete

);

logic enable_register; 
logic AgtB; 

//FSM starts upon start from tb, asserts done when start goes low, asserts enable_register if AgtB from the comparter is high 
//which tells the register to load the current value, replacing the old value, as the current value is the new max
fsm FSM (.clk(clk), .rst(rst), .start(start), .done(done), .ldMax(enable_register), .in_GTR_Max(AgtB)); 

//en (is fed from enable register) which is fed from the FSM. inputA is from the tb. Q is the maxValue
//and will be updated in the FSM
register REG_INST (.clk(clk), .rst(rst), .en(enable_register), .D(inputA), .Q(maxValue)); 

//Compartor takes in inputA and the current max value, and asserts AgtB which is fed to the FSM 
//if the new value is greater than the currently stored max. DUT will updated accordingly
//AltB and AeqB are not fed anywhere or used in this design
comparator COMPARTAOR_INST (.A(inputA), .B(maxValue), .AgtB(AgtB), .AltB(), .AeqB()); 



endmodule: findMax