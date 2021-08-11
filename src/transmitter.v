//`include "baud_rate_generator_block.v"
module transmitter
	#(parameter clock_frequency_register = 100_000_000) 
	(
	clk, Baud_Rate_Holding_Register, Transmitter_Holding_Register, Transmitter_Status, TX,
`ifdef USE_POWER_PINS
     vccd1,        // User area 1 1.8V supply
     vssd1        // User area 1 digital ground
 `endif
 );

`ifdef USE_POWER_PINS
    input vccd1;        // User area 1 1.8V supply
    input vssd1;        // User area 1 digital ground
 `endif
 
input clk;
input [31:0] Baud_Rate_Holding_Register;
input [31:0] Transmitter_Holding_Register;
input [31:0] Transmitter_Status;
output TX;
reg TX;

wire [3:0] sampling_pulse;

//baud rate generator instance
uart_baud_generator2 #(
	.clock_frequency_register(clock_frequency_register)
)	baud_block (
	`ifdef USE_POWER_PINS
    	.vccd1(vccd1),        // User area 1 1.8V supply
     	.vssd1(vssd1),        // User area 1 digital ground
 	`endif
	.clk(clk), 
	.rst(Transmitter_Status[0]), 
	.Baud_Rate_Holding_Register(Baud_Rate_Holding_Register), 
	.sampling_pulse(sampling_pulse)
);
//////////////////////////////////////////////////
parameter  IDLE      = 5'b00001,
           start_bit = 5'b00010,
           data_bits = 5'b00100,
           parity_bit= 5'b01000,
           stop_bit  = 5'b10000,
	   /////////data bits options
	   five_data_bits = 4'b0101, 
	   six_data_bits = 4'b0110,
	   seven_data_bits = 4'b0111, 
	   eight_data_bits = 4'b1000, 
	   nine_data_bits = 4'b1001,
	   /////////parity logic options
	   no_parity = 1'b0,
	   one_parity = 1'b1,
	   ////////stopping options
	   one_stop_bit = 2'b01,
	   two_stop_bits = 2'b10;
////////////////////////////////////////////
reg [3:0] index = 4'b0;
reg [1:0] temp = 2'b0;
reg [3:0] number_of_data_bits = 4'b0;

reg [4:0] next_state;
reg [4:0] current_state;

wire UART_STA_TX;
wire [3:0] data_bits_controlling_signals;
wire parity_contrlling_signals;
wire parity_value;

assign UART_STA_TX = Transmitter_Status[0]; 
assign data_bits_controlling_signals = Transmitter_Status[4:1]; 
assign parity_contrlling_signals = Transmitter_Status[5];
assign stop_controlling_signals = Transmitter_Status[7:6];

assign parity_value = (UART_STA_TX)?  ^(Transmitter_Holding_Register) : 0;

	always @ (posedge clk) begin

	if(!UART_STA_TX) begin
		TX <= 1'b1;
		current_state <= IDLE; end
		else begin //if not reseted and operated directly, output will be unknown until the divisor count
			current_state <= next_state; end
	end

	always @ (sampling_pulse) begin
		 case (current_state)
			 IDLE: begin
				 TX = 1'b1;
				 if(sampling_pulse == 4'b100) begin
				 if(!UART_STA_TX) begin
					 next_state = IDLE; end
					 else begin
						 next_state = start_bit; end
					 end
			 end

			 start_bit: begin
				 if(sampling_pulse == 4'b1000) begin
					 TX = 1'b0;
					 next_state = data_bits;
				 end
				 else begin
					 next_state = start_bit;
				 end
			 end 

			 data_bits: begin
				 if(sampling_pulse == 4'b1000) begin
					 if(data_bits_controlling_signals == five_data_bits) begin
						 if(index < five_data_bits) begin
						 TX = Transmitter_Holding_Register[index];
						 index = index + 1; 
						 next_state = data_bits;
					 end
						 else begin
							 next_state = parity_bit;
					 end
				 end
					 else if (data_bits_controlling_signals == six_data_bits) begin
						 if(index < six_data_bits) begin
							 TX = Transmitter_Holding_Register[index];
							 index = index + 1;
							 next_state = data_bits;
						 end
						 else begin
							 next_state = parity_bit;
						 end
					 end

					 else if (data_bits_controlling_signals == seven_data_bits) begin
						 if(index < seven_data_bits) begin
							 TX = Transmitter_Holding_Register[index];
                                                 	index = index + 1;
                                                 	next_state = data_bits;
					       	end
						else begin
							next_state = parity_bit;
						end
					end
					else if(data_bits_controlling_signals == eight_data_bits) begin
						if(index < 'b1000) begin
                                                         TX = Transmitter_Holding_Register[index];
                                                        index = index + 1;
                                                        next_state = data_bits;
                                                end
                                                else begin
                                                        next_state = parity_bit;
                                                end

					end
					else if(data_bits_controlling_signals == nine_data_bits) begin
						if(index < nine_data_bits) begin
                                                         TX = Transmitter_Holding_Register[index];
                                                        index = index + 1;
                                                        next_state = data_bits;
                                                end
                                                else begin
                                                        next_state = parity_bit;
                                                end
					end

					else begin
						next_state = IDLE;
					end
			 end

			 else begin
				 next_state = data_bits;
			 end
		 end

		 parity_bit: begin
			 if(sampling_pulse == 4'b1000) begin
				 if(parity_contrlling_signals == no_parity) begin
					 next_state = stop_bit;
				 end
				 else begin
					 TX = parity_value;
				 end
			 end
			 else begin
				 next_state = parity_bit;
			 end

		 end

		 stop_bit: begin
			 if(sampling_pulse == 4'b1000) begin
				 if(stop_controlling_signals == one_stop_bit) begin
					 TX = 1'b1;
					 next_state = IDLE; 
				 end
				 else if (stop_controlling_signals == two_stop_bits) begin
					 if(temp < 2'b10) begin
						 TX = 1'b1;
						 temp = temp + 1;
						 next_state = stop_bit; 
					 end
					 else begin
						 next_state = IDLE;
					 end
				 end
				 else begin 
					 next_state = IDLE;
				 end
			 end
			 else begin
				 next_state = stop_bit;
			 end
		 end
		 default: begin
			 next_state = IDLE;
		 end
	 endcase
 end

endmodule
