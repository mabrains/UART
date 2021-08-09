`timescale 1ns / 1ns
module transmitter_top_module_tb();

parameter period = 10,
          delay = 0;

reg clk;
reg [31:0] Baud_Rate_Holding_Register;
reg [31:0] Transmitter_Holding_Register;
reg [31:0] Transmitter_Status;
wire TX;

//reg [3:0] index = 'b0;
//reg [3:0] recieved_bits = 'b0;

initial begin
	clk = 1;
end

always #(period/2) clk <= ~clk;

initial begin
	Baud_Rate_Holding_Register = 'd9600;
	Transmitter_Holding_Register = 'b01_010_000;
	Transmitter_Status = 'b01_1_1000_1;     //  one or two stop bits, send parity bit or not, number of data bits, transmit or not
end

/*always @ (sampling_pulse) begin
$monitor("TX = %b, index = %b, recieved_bits = %b, time = %t \n", TX, index, recieved_bits, $time);
if(index < 'b1010 ) begin
recieved_bits[index] <= TX;
index <= index + 1;
end
else begin
	index = 'b0;
	$finish;
end
end
*/
// Transmitter top module instance
transmitter_top_module transmitter(
	.clk(clk), 
	.Baud_Rate_Holding_Register(Baud_Rate_Holding_Register), 
	.Transmitter_Holding_Register(Transmitter_Holding_Register), 
	.Transmitter_Status(Transmitter_Status), 
	.TX(TX)
);
 endmodule
