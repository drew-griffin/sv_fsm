//////////////////////////////////////////////////////////////
// jerky_counter.sv - jerky counter 
//
// Author: Drew Seidel (dseidel@pdx.edu)
// Date: 10/16/2022 
// Description:
// ------------
// This module represents the jerky synchronous counter 
 ////////////////////////////////////////////////////////////////

//Jerky counter is created here 
//The testbench wil instantiate the device for testing and display

module jerky_counter (
input logic clock, reset, // clock and reset 
output logic [7:0] count  // counter output
); 

	
	int state = 0; 

	always_ff @(posedge clock, negedge reset) begin 

	if(!reset) begin 
	  state <= 0; 
	  count <= 8'b00000001;
	end 
	else begin
		if (state%2 == 0) 
	 		 count <= 8'b00000001;
		else 
			 count <= 8'b00000001 << ((state/2) + 1);

		if (state == 13)
			 state <= 0; 
		else 
		 	 state <= state + 1; 	
	
	end 
    end

endmodule: jerky_counter 