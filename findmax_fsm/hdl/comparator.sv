//////////////////////////////////////////////////////////////
// comparator.sv - performs the comparision of the newest input and the stored max 
//
// Author: Drew Seidel  (dseidel@pdx.edu)
// Date: 10/18/2022 
// Description:
// ------------
// Module is resbonsible for reading in the current input and comparing to the known max 
////////////////////////////////////////////////////////////////


module comparator
#(
parameter WIDTH = 8 
)
(
input logic [WIDTH-1:0] A, B, // A and B unsigned numbers to compare
output logic AltB,            // asserted high if A < B
output logic AeqB,            // asserted high if A = B
output logic AgtB             // asserted high if A > B
); 

assign AltB = A < B ? 1'b1 : 1'b0; 
assign AeqB = A == B ? 1'b1 : 1'b0; 
assign AgtB = A > B ? 1'b1 : 1'b0; 


endmodule: comparator



