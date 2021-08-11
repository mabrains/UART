`timescale 1ns / 1ns
module uart_baud_generator2 #(parameter clock_frequency_register = 'd100_000_000)
(clk, rst, Baud_Rate_Holding_Register, sampling_pulse, 
`ifdef USE_POWER_PINS
     vccd1,        // User area 1 1.8V supply
     vssd1        // User area 1 digital ground
 `endif
);

parameter IDLE = 3'b001,
          Sampling_Pulse_Generation_Logic = 3'b010,
	  Divisor_Logic = 3'b100;

`ifdef USE_POWER_PINS
    input vccd1;        // User area 1 1.8V supply
    input vssd1;        // User area 1 digital ground
 `endif

input clk, rst; 
input [31:0] Baud_Rate_Holding_Register;
output [3:0] sampling_pulse;
reg sampling_pulse = 4'b0;

reg [2:0] current_state, next_state;

reg  [31:0] the_Baud_Rate_counter = 32'b11;  //for toggling the new clock when it reaches it's maximum value       
reg [13:0] number_of_pulses_per_bit = 14'b0;
reg [13:0] divisor = 14'b0;
reg [13:0] divisor_count = 14'b0;
reg [31:0] counter = 'b0;


//controlling sequential block
always @ (posedge clk or negedge rst) begin
	if(!rst) begin
		current_state <= IDLE; end
		else begin
	                current_state <= next_state;
	       	end
end

// FSM for organizing
always @ (posedge clk)  begin

	case (current_state)
		IDLE: begin
			sampling_pulse <= 4'b0;
			if(!rst) begin
				counter <= 'b0;
				next_state <= IDLE;
			end
			else begin
				next_state <= Sampling_Pulse_Generation_Logic;
			end
		end
		
		Sampling_Pulse_Generation_Logic: begin
                                  if (counter < (clock_frequency_register - 1)) begin
                                           counter <= counter + 1;
					  // $monitor("time = %t, counter = %d \n", $time, counter);
					   if(the_Baud_Rate_counter == Baud_Rate_Holding_Register) begin
						   $monitor("time = %t, the_Baud_Rate_counter = %d, Baud_Rate_Holding_Register = %d, counter = %d \n", $time, the_Baud_Rate_counter, Baud_Rate_Holding_Register, counter);
					//	 $display("the_Baud_Rate_counter = %d, time = %t \n", the_Baud_Rate_counter, $time);
                                          //      $finish;

						   the_Baud_Rate_counter <= 'b11;
						   number_of_pulses_per_bit <= number_of_pulses_per_bit + 1;
					  next_state <= Sampling_Pulse_Generation_Logic;
				  end
				  else begin
                         
						 the_Baud_Rate_counter <= the_Baud_Rate_counter + 32'b1;
						 next_state <= Sampling_Pulse_Generation_Logic;
					 end
				 end
						 else begin
//							 $monitor("next_state = %b, current_state = %b, Baud_Rate_Holding_Register = %d, the_Baud_Rate_counter = %d, time = %t, counter = %d \n", next_state, current_state, Baud_Rate_Holding_Register, the_Baud_Rate_counter, $time, counter);
                  //      $finish;
							divisor <= {4'b0 ,number_of_pulses_per_bit[13:4]};
							 next_state <= Divisor_Logic;
						 end
					 end
		Divisor_Logic: begin
				if(divisor_count == divisor) begin
                                           sampling_pulse <= sampling_pulse + 1;
                                           divisor_count <= 'b1;
					   counter <= 'b0;
					  // $monitor("next_state = %b, current_state = %b, divisor = %d, sampling_pulse = %b,  Baud_Rate_Holding_Register = %d, the_Baud_Rate_counter = %d, time = %t, counter = %d \n", next_state, current_state, divisor, sampling_pulse, Baud_Rate_Holding_Register, the_Baud_Rate_counter, $time, counter);
					  // if(sampling_pulse == 'b1000) begin
                  		          // $finish;
				  // end

                                end
                                else begin
                                               divisor_count <= divisor_count + 1;
					       counter <= 'b0;
				       end
			       end


		default: begin
			next_state <= IDLE; end
	endcase
end


endmodule
