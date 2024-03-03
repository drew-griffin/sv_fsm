//////////////////////////////////////////////////////////////
// tb_jerky_counter.sv - testbench for jerky counter
//
// Author: Drew Seidel (dseidel@pdx.edu)
// Date: 10/16/2022 
// Description:
// ------------
// This module is the test bench for the jerky counter 
 ////////////////////////////////////////////////////////////////

//Applies a clock signal to the jerky counter and lets it run
// And displays results. A reset is applied at a random time to 
//test this functionality as well

module tb_jerky_counter(); 


logic clock, reset; 
logic [7:0] count; 

//instantiating of jerky counter model 
jerky_counter JERKY_COUNTER_INST (.clock(clock), .reset(reset), .count(count)); 

// Generate clock 
always 
begin 
#10 clock = 1; 
#10 clock = 0; 
end 

initial
begin 
reset = 1; 
	$display("Welcome to Drew Seidel's Jerky Counter"); 
	for (int i = 0; i < 100; i = i + 1) begin
	   
	  #20		
	  $display("Jerky counter value = %b", count);
	
	  if (i == 73) begin 
	     reset = 0; 
	     $display("Testing reset functionality, applying reset\n\n"); 
	     #20	
	     reset = 1; 
	  end

	end 
	$display("Testing for Drew's Jerky Counter is complete"); 
	$stop; 
end 

endmodule


