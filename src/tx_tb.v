`timescale 1ns / 1ns
module transmitter_top_module_tb();

parameter period = 10,
          delay = 0,
	  clock_frequency_register = 100_000_000;

reg clk;
reg [31:0] Baud_Rate_Holding_Register;
reg [31:0] Transmitter_Holding_Register;
reg [31:0] Transmitter_Status;
wire TX;

`ifdef USE_POWER_PINS
wire vccd1;        // User area 1 1.8V supply
wire vssd1;        // User area 1 digital ground
 `endif
 

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

/*always @ (posedge clk) begin
$monitor("TX = %b, time = %t \n", TX, $time);
if(TX == 0) begin
	$finish;
end
end
*/
// Transmitter top module instance
transmitter #(
	.clock_frequency_register(clock_frequency_register)
	) dut (
		`ifdef USE_POWER_PINS
        .vccd1(vccd1),        // User area 1 1.8V supply
        .vssd1(vssd1),        // User area 1 digital ground
 `endif
        .clk(clk), 
	.Baud_Rate_Holding_Register(Baud_Rate_Holding_Register), 
	.Transmitter_Holding_Register(Transmitter_Holding_Register), 
	.Transmitter_Status(Transmitter_Status), 
	.TX(TX)
 );
 
endmodule
