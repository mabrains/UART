`timescale 1ns / 1ns
module uart_baud_generator2(clk, rst, Baud_Rate_Holding_Register, clock_frequency_register, sampling_pulse);

parameter IDLE = 3'b001,
          Sampling_Pulse_Generation_Logic = 3'b010,
	  Divisor_Logic = 3'b100;

input clk, rst; 
input [31:0] Baud_Rate_Holding_Register;
input [31:0] clock_frequency_register;
output [3:0] sampling_pulse;
reg sampling_pulse = 4'b0;

reg [2:0] current_state, next_state;
reg  [31:0] the_Baud_Rate_counter = 32'b0;  //for toggling the new clock when it reaches it's maximum value       
reg [13:0] number_of_pulses_per_bit = 14'b0;
reg [13:0] divisor = 14'b0;
reg [13:0] divisor_count = 14'b0;
reg [31:0] counter = 'b0;


//controlling sequential block
always @ (posedge clk or negedge rst) begin
	if(!rst) begin
		current_state = IDLE; end
		else begin
	                current_state = Divisor_Logic;
				//Sampling_Pulse_Generation_Logic;
	       	end
end
/*always @ (posedge clk) begin
$monitor("Baud_Rate_Holding_Register = %d ,clock_frequency_register = %d \n", Baud_Rate_Holding_Register, clock_frequency_register);
$finish;
end*/
// FSM for organizing
always @ (posedge clk)  begin
	case (current_state)
		IDLE: begin
			sampling_pulse = 4'b0;
			counter = 'b0;
			if(!rst) begin
				next_state = IDLE;
			end
			else begin
				next_state = Sampling_Pulse_Generation_Logic;
			end
		end
		
		Sampling_Pulse_Generation_Logic: begin
                                  if (counter < (clock_frequency_register - 1)) begin
                                           counter <= counter + 1;
					   if(the_Baud_Rate_counter == Baud_Rate_Holding_Register) begin
					  number_of_pulses_per_bit <= number_of_pulses_per_bit + 1;
					  $monitor("number_of_pulses_per_bit = %d, counter = %d, clock_frequency_register = %d, sampling_pulse = %b \n", number_of_pulses_per_bit, counter, clock_frequency_register, sampling_pulse);
				  end
				  else begin
                         
						 the_Baud_Rate_counter <= the_Baud_Rate_counter + 32'b1;
					 end
				 end
						 else begin
							divisor = {8'b0 ,number_of_pulses_per_bit[13:8]};
							 next_state <= Divisor_Logic;
						 end
					 end
		Divisor_Logic: begin
				if(divisor_count == 'd651) begin
                                           sampling_pulse = sampling_pulse + 1;
                                           divisor_count = 'b1;
				//	$monitor("Baud_Rate_Holding_Register = %d ,clock_frequency_register = %d \n", Baud_Rate_Holding_Register, clock_frequency_register);
                                  //      $finish;
				 counter = 'b0;
                                end
                                else begin
                                               divisor_count <= divisor_count + 1;
					       counter = 'b0;
				       end
			       end


		default: begin
			next_state = IDLE; end
	endcase
end


endmodule
