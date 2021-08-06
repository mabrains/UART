`timescale 1ns / 1ns
module uart_baud_generator_tb ();


parameter period = 10,
	  delay = 0;

reg clk, rst;
reg [31:0] Baud_Rate_Holding_Register;
reg [31:0] clock_frequency_register;
wire [3:0] sampling_pulse;
wire the_new_generated_clock;

uart_baud_generator2 u1 (
	.clk(clk), 
	.rst(rst),
       	.Baud_Rate_Holding_Register(Baud_Rate_Holding_Register),
       	.clock_frequency_register(clock_frequency_register), 
	.sampling_pulse(sampling_pulse), 
	.the_new_generated_clock(the_new_generated_clock)
	);


	initial clk = 0;

	always #(period/2) clk <= ~clk;

	initial begin
		rst = 1'b1;
		Baud_Rate_Holding_Register = 32'd9600;
		clock_frequency_register = 32'd100_000_000;
	end


	always @ (posedge clk) begin
//		$monitor("time = %t, clk = %b, rst = %b, Baud_Rate_Holding_Register = %d, clock_frequency_register = %d, sampling_pulse = %b, the_new_generated_clock = %b \n", $time, clk, rst, Baud_Rate_Holding_Register, clock_frequency_register, sampling_pulse, the_new_generated_clock);
		if (sampling_pulse == 4'b1000) begin
			$finish; end
	end
	endmodule
