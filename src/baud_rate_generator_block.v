`timescale 1ns / 1ns
module uart_baud_generator2 (clk, rst, Baud_Rate_Holding_Register, clock_frequency_register, sampling_pulse, the_new_generated_clock);

parameter IDLE = 2'b01,
          Sampling_Pulse_Generation_Logic = 2'b10;

input clk, rst; 
input [31:0] Baud_Rate_Holding_Register;
input [31:0] clock_frequency_register;
output [3:0] sampling_pulse;
output the_new_generated_clock;
reg sampling_pulse = 4'b0;
reg the_new_generated_clock = 1'b0; // the baud clk

reg [3:0] sampling_pulse_internal_signal = 4'b0;
reg [1:0] current_state, next_state;
reg  [31:0] half_the_Baud_Rate_counter = 32'b0;  //for toggling the new clock when it reaches it's maximum value       
reg [13:0] number_of_pulses_per_bit = 14'b0;
reg [13:0] divisor = 14'b0;
reg [13:0] divisor_count = 14'b0;
reg [31:0] counter = 'b0;
wire [31:0] Baud_Rate_Holding_Register_internal_signal;
wire [31:0] clock_frequency_register_internal_signal;

// A continuous assignment dividing the baud rate by 2
// assign Baud_Rate_Holding_Register_internal_signal = Baud_Rate_Holding_Register;
 assign Baud_Rate_Holding_Register_internal_signal = {1'b0, Baud_Rate_Holding_Register[31:1]} - 1 ;       //divide baud rate by 2
 assign clock_frequency_register_internal_signal = {1'b0, clock_frequency_register[31:1]};

//controlling sequential block
always @ (posedge clk or negedge rst) begin
	if(!rst) begin
		current_state = IDLE; end
		else begin
	                current_state = Sampling_Pulse_Generation_Logic;
	       	end
end
//always @ (posedge clk) begin
//$monitor("Baud_Rate_Holding_Register = %d , Baud_Rate_Holding_Register_internal_signal = %d, clock_frequency_register = %d \n", Baud_Rate_Holding_Register, Baud_Rate_Holding_Register_internal_signal, clock_frequency_register);
//$finish;
//end
// FSM for organizing
always @ (posedge clk)  begin
	case (current_state)
		IDLE: begin
			sampling_pulse = 4'b0;
			the_new_generated_clock = 1'b0;
			if(!rst) begin
				next_state = IDLE; end
				else begin
					next_state = Sampling_Pulse_Generation_Logic; end
			end
		
		Sampling_Pulse_Generation_Logic: begin
			if(!rst) begin
				next_state = IDLE; end
				else begin
			      	// the new clock logic that generates the pulses per bit ,  that is used
                                // for calculating the divisor value then
				// generates the sampling pulse
				counter <= counter + 1;
                  if(half_the_Baud_Rate_counter == Baud_Rate_Holding_Register_internal_signal) begin
                          the_new_generated_clock <= ~the_new_generated_clock;
                   // $monitor("half_the_Baud_Rate_counter = %d", half_the_Baud_Rate_counter);
		    	  if(the_new_generated_clock == 1) begin
                                  if (counter < (clock_frequency_register_internal_signal - 1)) begin
                                          
					  number_of_pulses_per_bit <= number_of_pulses_per_bit + 1;
					  $monitor("number_of_pulses_per_bit = %d, counter = %d, clock_frequency_register = %d, clock_frequency_register_internal_signal = %d, sampling_pulse = %b \n", number_of_pulses_per_bit, counter, clock_frequency_register, clock_frequency_register_internal_signal, sampling_pulse);
				  end
                                          else begin
						  counter = 'd100_000_000;
				                      divisor  <=  {8'b0, number_of_pulses_per_bit[5:0]};
					  if(divisor_count == divisor) begin
                                                 	 sampling_pulse <= sampling_pulse + 1;
                 					 divisor_count = 'b0;
       						  end
                 			 else begin
                        			 divisor_count <= divisor_count + 1;
                			 end


					      end
                   end
	   end
                          else begin
                                  half_the_Baud_Rate_counter <= half_the_Baud_Rate_counter + 32'b1;
			 end
          end

		end
		default: begin
			next_state = IDLE; end
	endcase
end

//always @ (posedge clk) begin
//	if(divisor_count == divisor) begin
//		sampling_pulse <= sampling_pulse + 1;
//	        divisor_count = 'b0;	
//	end
//		else begin
//			divisor_count <= divisor_count + 1;
//		end
//
//	end

endmodule
