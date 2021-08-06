`timescale 1ns / 1ns
module uart_baud_clk_tb();

reg clk;
reg rst; 
reg [16:0] Baud_Rate;
wire [3:0] tick;
wire [3:0] tick_spike;

reg [13:0] counter;

parameter period = 10;

//DUT_instantiation
uart_baud_generator uart_tb (
       	.clk(clk),
        .rst(rst),	
	.tick(tick),
	.tick_spike(tick_spike),
	.Baud_Rate(Baud_Rate)
);

initial begin
	clk = 0;
	rst = 1;
end

//clk_gen
always 
begin
#(period/2) clk = 0;
#(period/2) clk = 1;
end

always @(tick_spike) begin
	if (tick_spike == 4'b0011 && $time == 'd2083200) begin
                $display("%c[1;34m",27);               //replace 1 by 5 for the coolest format:)
		$display("PASSED FIRST TEST");

//		$finish;
end
	if (tick_spike == 4'b1011) begin
		$display("%c[1;34m",27);               //replace 1 by 5 for the coolest format:)
                $display("PASSED SECOND TEST");
 
            //    $finish;


	end

	if (tick_spike == 4'b1010) begin
                  $display("%c[1;34m",27);               //replace 1 by 5 for the coolest format:)
                  $display("PASSED THIRD TEST");
 
                  $finish;
 
 
          end


	end
//Baud_Rate stimulus
initial 
begin
Baud_Rate = 'd1200;
    $display("Baud_Rate = 1200");
    

#2083210 Baud_Rate = 'd2400;
    $display("Baud_Rate = 2400");

#6457930
Baud_Rate = 'd4800;
    $display("Baud_Rate = 4800");
/*
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
*/
/*
initial 
begin
	repeat (12500_000_000) @(posedge clk);
        $display("Something went wrong, Test Failed");
$finish;*/
end

//always @(Baud_Rate or tick) begin
//$timeformat(-9,1,"ns", 7);
//$display("time = %t, tick_spike = %b \n", $time, tick_spike, );
//$display("time = %d, clock = %b, rst = %b, tick_spike = %b, Baud_Rate = %d, tick =  %b \n " , $time, clk, rst, tick_spike, Baud_Rate, tick,);
//end

endmodule
