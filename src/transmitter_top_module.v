`timescale 1ns / 1ns
module transmitter_top_module(clk, Baud_Rate_Holding_Register, Transmitter_Holding_Register, Transmitter_Status, TX);


parameter clock_frequency_register = 'd100_000_000;

input clk;
input [31:0] Baud_Rate_Holding_Register;
input [31:0] Transmitter_Holding_Register;
input [31:0] Transmitter_Status;
output TX;
wire [3:0] sampling_pulse;

reg [4:0] index = 'b0;
reg [10:0] recieved_bits = 'b0;

always @ (sampling_pulse) begin
$monitor("TX = %b, sampling_pulse = %b, index = %b, recieved_bits = %b, time = %t \n", TX, sampling_pulse, index, recieved_bits, $time);
if(sampling_pulse == 4'b1000) begin
if(index < 5'b11111 ) begin
recieved_bits[index] <= TX;
index <= index + 1;
end
else begin
        index = 'b0;
        $finish;
end
end
end


//transmitter instance
transmitter u1 (
	.clk(clk),
	.sampling_pulse(sampling_pulse),
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
	.sampling_pulse(sampling_pulse) 
);
endmodule
