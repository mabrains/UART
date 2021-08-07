`timescale 1ns / 1ns
module transmitter_top_module(clk, Baud_Rate_Holding_Register, Transmitter_Holding_Register, Transmitter_Status, TX);


parameter clock_frequency_register = 'd100_000_000;

input clk;
input [31:0] Baud_Rate_Holding_Register;
input [31:0] Transmitter_Holding_Register;
input [31:0] Transmitter_Status;
output TX;
wire [3:0] sampling_pulse;
wire the_new_generated_clock;


//transmitter instance
transmitter u1 (
	.sampling_pulse(sampling_pulse),
       	.the_new_generated_clock(the_new_generated_clock), 
	.Transmitter_Holding_Register(Transmitter_Holding_Register), 
	.Transmitter_Status(Transmitter_Status), 
	.TX(TX)
);


//baud rate generator instance
uart_baud_generator2 u2(
	.clk(clk), 
	.rst(Transmitter_Status[0]), 
	.Baud_Rate_Holding_Register(Baud_Rate_Holding_Register), 
	.clock_frequency_register(clock_frequency_register), 
	.sampling_pulse(sampling_pulse), 
	.the_new_generated_clock(the_new_generated_clock)
);
endmodule
