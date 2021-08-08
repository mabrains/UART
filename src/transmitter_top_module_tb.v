`timescale 1ns / 1ns
module transmitter_top_module_tb();

parameter period = 10,
          delay = 0;

reg clk;
reg [31:0] Baud_Rate_Holding_Register;
reg [31:0] Transmitter_Holding_Register;
reg [31:0] Transmitter_Status;
wire TX;

initial begin
	clk = 1;
end

always #(period/2) clk <= ~clk;

initial begin
	Baud_Rate_Holding_Register = 'd9600;
	Transmitter_Holding_Register = 'b10101;
	Transmitter_Status = 'b01_1_1000_1;     //  one or two stop bits, send parity bit or not, number of data bits, transmit or not
end

always @ (posedge clk) begin
$monitor("TX = %b, time = %t \n", TX, $time);
//if(recieved_bits == ) begin

//	$finish;
//end
end

// Transmitter top module instance
transmitter_top_module transmitter(
	.clk(clk), 
	.Baud_Rate_Holding_Register(Baud_Rate_Holding_Register), 
	.Transmitter_Holding_Register(Transmitter_Holding_Register), 
	.Transmitter_Status(Transmitter_Status), 
	.TX(TX)
);
 endmodule
