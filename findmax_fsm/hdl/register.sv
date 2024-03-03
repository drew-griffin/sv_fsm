//////////////////////////////////////////////////////////////
// register.sv - models a register in the datapath for the findMax DUT 
//
// Author: Drew Seidel (dseidel@pdx.edu) 
// Date: 10/18/2022
// Description:
// ------------
// Register simple holds the current maximum value for the input stream 
// And updates accordingly based on the enable signal 
////////////////////////////////////////////////////////////////

module register
#(
parameter WIDTH = 8 
)
(
input logic [WIDTH-1: 0] D,         //D input ot the register
input logic en,                     // enable. Assert high to load D into the register
input logic clk, rst,               //clock and reset. Assert rest high to clear the register 
output logic [WIDTH-1:0] Q          //Q output from the register 
);


//if enable is high the register will get the current value of D. 
//Enable is asserted by the FSM which updates the unable value upon comparision from the comparter 
//Otherwise, Q remains its current value as the current maximum value
    always_ff @(posedge clk or posedge rst) 
    begin 
        if (rst)
            Q <= 0; 
        else if (en)
            Q <= D; 
        else 
            Q <= Q; 
    end

endmodule: register