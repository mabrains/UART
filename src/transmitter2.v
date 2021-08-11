`include "baud_rate_generator_block.v"
module transmitter
        #(parameter clock_frequency_register = 100_000_000)
        (
        clk, Baud_Rate_Holding_Register, Transmitter_Holding_Register, Transmitter_Status, TX,
`ifdef USE_POWER_PINS
     vccd1,        // User area 1 1.8V supply
     vssd1        // User area 1 digital ground
 `endif
 );

 parameter  IDLE      = 5'b00001,
           start_bit = 5'b00010,
           data_bits = 5'b00100,
           parity_bit= 5'b01000,
           stop_bit  = 5'b10000;

   `ifdef USE_POWER_PINS
    input vccd1;        // User area 1 1.8V supply
    input vssd1;        // User area 1 digital ground
 `endif

input clk;
input [31:0] Baud_Rate_Holding_Register;
input [15:0] Transmitter_Holding_Register;
input [15:0] Transmitter_Status;
output TX;
reg TX;

reg [4:0] next_state;
reg [4:0] current_state;

wire d0, d1, d2, d3, d4, d5, d6, d7, d8;
reg [3:0] count_five, count_six, count_seven, count_eight, count_nine, count_stop_bits = 4'b0;
wire parity_value;
wire [3:0] sampling_pulse;

assign {d0, d1, d2, d3, d4, d5, d6, d7, d8} = Transmitter_Holding_Register[8:0];
assign parity_value = (Transmitter_Status[0])?  ^Transmitter_Holding_Register : 1'b0;

 always @ (posedge clk) begin
        if(!Transmitter_Status[0]) begin
                TX <= 1'b1;
                current_state <= IDLE; end
                else begin //if not reseted and operated directly, output will be unknown until the divisor count
                        current_state <= next_state; end
        end

 always @ (sampling_pulse) begin
                 case (current_state)
                         IDLE: begin
                                 TX <= 1'b1;
                                 if(sampling_pulse == 4'b100) begin
                                 if(!Transmitter_Status[0]) begin
                                         next_state <= IDLE; end
                                         else begin
                                                 next_state <= start_bit; end
                                         end
					 else begin
						 next_state <= IDLE;
					 end

                         end

                         start_bit: begin
                                 if(sampling_pulse == 4'b1000) begin
                                         TX <= 1'b0;
                                         next_state <= data_bits; end
                                 else begin
                                         next_state <= start_bit; end
                         end

			 data_bits: begin
				 if(sampling_pulse == 4'b1000) begin
					 if(Transmitter_Status[4:1] == 4'b0101) begin
                                	d1 <= d0;
                                	d2 <= d1;
                                	d3 <= d2;
                                	d4 <= d3;
                                	TX <= d4; //d4 is the LSB
                                	if(count_five > 3) begin
                                        	count_five <= 0;
                                        	next_state <= parity_bit; end
                                	else begin
                                        count_five <= count_five + 1;
                                        next_state <= data_bits; end
					end
	
        	                	else if(Transmitter_Status[4:1] == 4'b0110) begin
                                	d1 <= d0;
                                	d2 <= d1;
                                	d3 <= d2;
                                	d4 <= d3;
                                	d5 <= d4;
                                	TX <= d5; //d5 is the LSB
                                	if(count_six > 4) begin
                                        	count_six <= 0;
                                        	next_state <= parity_bit; end
                                 	else begin
                                        	count_six <= count_six + 1;
                                         	next_state <= data_bits; end
                        		end
					else if(Transmitter_Status[4:1] == 4'b0111) begin
                                	d1 <= d0;
                                	d2 <= d1;
                                	d3 <= d2;
                                	d4 <= d3;
                               		d5 <= d4;
                                	d6 <= d5;
                                	TX <= d6; //d6 is the LSB
                                	if(count_seven > 5) begin
                                          	count_seven <= 0;
                                          	next_state <= parity_bit; end
                                  	else begin
                                          	count_seven <= count_seven + 1;
                                          	next_state <= data_bits; end
                        		end

                        		else if (Transmitter_Status[4:1] == 4'b1000) begin
                                	d1 <= d0;
                                	d2 <= d1;
                                	d3 <= d2;
                                	d4 <= d3;
                                	d5 <= d4;
                                	d6 <= d5;
                                	d7 <= d6;
                                	TX <= d7; //d7 is the LSB
                                	if(count_eight > 6) begin
                                          	count_eight <= 0;
                                          	next_state <= parity_bit; end
                                  	else begin
                                          	count_eight <= count_eight + 1;
                                         	next_state <= data_bits; end
					end

					else if (Transmitter_Status[4:1] == 4'b1001) begin
        	                        d1 <= d0;
	                                d2 <= d1;
                	                d3 <= d2;
                        	        d4 <= d3;
                               		d5 <= d4;
                                 	d6 <= d5;
                            	        d7 <= d6;
                               	        d8 <= d7;
                              	   	TX <= d8; //d8 is the LSB
                                 	if(count_nine > 7) begin
                                          	count_nine <= 0;
                                          	next_state <= parity_bit; end
                                  	else begin
                                         	count_nine <= count_nine + 1;
                                          	next_state <= data_bits; end
					end
                        		
					else begin
                                		next_state <= IDLE;
                        		end
				end
				else begin
					next_state <= IDLE; end
				end
				
				parity_bit: begin
                         		if(sampling_pulse == 4'b1000) begin
                                 		if(Transmitter_Status[5] == 1'b0) begin
                                         		next_state = stop_bit; end
                                 		else begin
                                         		TX = parity_value; end
						end
                         		else begin
                                 			next_state = parity_bit; end 
					end

					stop_bit: begin
						if(sampling_pulse == 4'b1000) begin
							if(Transmitter_Status[7:6] == 2'b01) begin
								TX <= 1'b1;
								next_state <= IDLE;
							end
							else if(Transmitter_Status[7:6] == 2'b10) begin
								TX <= 1'b1;
								if(count_stop_bits >= 1) begin
                                        				count_stop_bits <= 'b0;
                                       			 		next_state <= IDLE; end
									else begin
										count_stop_bits <= count_stop_bits + 1'b1;
										next_state <= stop_bit; end
								end
							else begin
								next_state <= IDLE;
							end
						end
							else begin
								next_state <= stop_bit;
							end
						end
					endcase
				end

 //baud rate generator instance
uart_baud_generator2 #(
        .clock_frequency_register(clock_frequency_register)
)       baud_block (
        `ifdef USE_POWER_PINS
        .vccd1(vccd1),        // User area 1 1.8V supply
        .vssd1(vssd1),        // User area 1 digital ground
        `endif
        .clk(clk),
        .rst(Transmitter_Status[0]),
        .Baud_Rate_Holding_Register(Baud_Rate_Holding_Register),
        .sampling_pulse(sampling_pulse)
);

endmodule
