`timescale 1ns / 1ps
module uart_baud_generator(clk, rst, Baud_Rate, tick);  //baud generator block, controlled from the sw level, the default value is 9600

parameter clock_frequency = 'd100_000_000;

input clk;
input rst;
input [16:0] Baud_Rate;
output[3:0] tick;   //for 16x higher than the baud rate for correct bit sampling

reg [13:0] count = 14'b0;
reg tick = 4'b0;
reg [13:0] acc= 14'b0;       //accumulator * 16 = number of pulses per bit,  this value of number of pulses in 1 second is the baud rate required
reg state; //1 baud rate block is on else off

always @(posedge clk or negedge rst)
	if(!rst)
		state = 1'b0;
	else
                state = 1'b1;

always @ (posedge clk or Baud_Rate) begin

if (state)

if(count == acc )
begin
//$monitor("time = %d \n", $time,);
tick <= tick + 4'b0001;  //until it reaches 4'b1111 and overflows to reach 4'b0000 again
count = 14'b000_000_000;
end
else
//	$monitor("time = %d, tick = %b \n", $time, tick,);
count <= count + 14'b000_000_001;

end


always @(posedge clk or Baud_Rate) begin
	case (Baud_Rate)
		'd1200: begin
			acc = 'd5207;
		end
		'd2400: begin
			acc = 'd2603;
		end
		'd4800: begin
			acc = 'd1301;
		end
		'd9600: begin
			acc = 'd650;
		end
		'd14400: begin
			acc = 'd433;
		end
		'd19200: begin
			acc = 'd325;
		end
		'd28800: begin
			acc = 'd216;
		end
		'd38400: begin
			acc = 'd162;
		end
		'd57600: begin
			acc = 'd108;
		end
		'd115200: begin
			acc = 'd53;
		end
		default: begin
			acc = 'd650;
		end

	endcase
end


endmodule
