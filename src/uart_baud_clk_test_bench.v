`timescale 1ns / 1ps
module uart_baud_clk_tb();

reg clk; 
reg[16:0] Baud_Rate;
wire[3:0] tick;

reg[15:0] counter;

parameter period= 6.66;

//DUT_instantiation
uart_baud_generator uart_tb (
       	.clk(clk), 
	.tick(tick),
	.Baud_Rate(Baud_Rate)
);

initial clk = 0;

//clk_gen
always 
begin
#(period/2) clk = 1;
#(period/2) clk = 0;
end

always @(tick) begin
if(tick == 4'b1111)
	counter <= counter +1;
else
	counter <= 16'b0;
end

always @(counter) begin
	if (counter == 'd19200) begin
		$display("everything is going well");
	$finish;
end
end


//Baud_Rate Determining for the transmitting bits
initial 
begin
#(2*period)
Baud_Rate = 'd1200;
repeat (150_000_000) @(posedge clk);
    $display("Baud_Rate = 1200");
   

Baud_Rate = 'd2400;
repeat (150_000_000) @(posedge clk);
    $display("Baud_Rate = 2400");

Baud_Rate = 'd4800;
repeat (150_000_000) @(posedge clk);
    $display("Baud_Rate = 4800");

Baud_Rate = 'd9600;
repeat (150_000_000) @(posedge clk);
    $display("Baud_Rate = 9600");

Baud_Rate = 'd14400;
repeat (150_000_000) @(posedge clk);
    $display("Baud_Rate = 144400");

Baud_Rate = 'd38400;
repeat (150_000_000) @(posedge clk);
    $display("Baud_Rate = 38400");

Baud_Rate = 'd57600;
repeat (150_000_000) @(posedge clk);
    $display("Baud_Rate = 57600");

Baud_Rate = 'd115200;
repeat (150_000_000) @(posedge clk);
    $display("Baud_Rate = 115200");
     $display("Nicely Done, Test Succeeded");
    $finish;

end

initial 
begin
	repeat (12500_000_000) @(posedge clk);
        $display("Something went wrong, Test Failed");
$finish;
end

always @(Baud_Rate or tick) begin
$timeformat(-9,1,"ns", 7);
$display("time = %d, clock = %b,  Baud_Rate = %d, tick =  %b \n " , $time, clk, Baud_Rate, tick,);
end

endmodule
