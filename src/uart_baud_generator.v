`timescale 1ns / 1ns
module uart_baud_generator(clk, rst, Baud_Rate, tick, tick_spike);  //baud generator block, controlled from the sw level, the default value is 9600

parameter clock_frequency = 'd100_000_000;

input clk;
input rst;
input [16:0] Baud_Rate;
output[3:0] tick;   //for 16x higher than the baud rate for correct bit sampling
output [3:0] tick_spike;

//reg [3:0] tick_signal;
reg [13:0] count = 14'b0;
reg tick = 4'b0;
reg tick_spike = 4'b0;
reg [13:0] acc= 14'b0;       //accumulator * 16 = number of pulses per bit,  this value of number of pulses in 1 second is the baud rate required

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////the sampling spike/pulse logic///////////////////////////////////////////////////////////////////////////////////////////////////////////////
  /* always @ (posedge tick) begin
	   if(tick == 4'b1000) begin 
  tick_spike <= tick_spike + 4'b0001;
//  $monitor("time = %t", $time);
 // if($time == 416640)
 //if(tick_spike == 4'b0010) begin
 //$display("YES");
   //$display("time = %t, tick = %b \n", $time, tick);
   //$finish;
  // end
//$monitor("time = %t, tick_spike = %b, tick = %b \n", $time, tick_spike, tick, );
end
/////////////////////////////////////////////////////////////////////////////for///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////testing////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//if(tick_spike == 4'b1111) begin
	// $monitor("time = %t, tick_spike = %b, tick = %b \n", $time, tick_spike, tick, );
//	$display("TEST PASSED");
//			 $finish;
//	 end

end
*/
////////////////////////////////////////////////////////////////////////The Baud Rate Generator////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////tick counts until over flow and then returns to zero, pulses from zero to zero///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////again are the number of pulses per bit, above we use the "tick_spike" for//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////sampling in the middle of the bit duration, middle of tick at tick =8//////////////////////////////////////////////////////////////////////////////
always @ (Baud_Rate) begin
tick = 4'b0;
tick_spike = 4'b0;
end

always @ (posedge clk) begin
	if(tick_spike > 4'b1010) begin
              tick_spike = 4'b0;
      end

end

always @ (posedge clk or negedge rst) begin

if (!rst)
begin
tick = 4'b0;
count = 14'b0;
end

else 
begin
if(count == acc )
begin
tick <= tick + 4'b0001;  //until it reaches 4'b1111 and overflows to reach 4'b0000 again
 if(tick == 4'b0111) begin
    tick_spike <= tick_spike + 4'b0001;
end

count = 14'b000_000_000;
//if ($time == 416640)  
//$display("YES");
$monitor("time = %t, tick = %b, tick_spike = %b, Baud_Rate = %d \n", $time, tick, tick_spike, Baud_Rate);
end

else
begin
count <= count + 14'b000_000_001;
end //internal else
end //primary & external else

end //termination for the always block
//////////////////////////////////////////////////////////////////////acc * 16 = number of pulses per bit//////////////////////////////////////////////////////////////////////////////////////////////////
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
		'd115200: begin //the highest rate needs 18 bit register for presenting it
			acc = 'd53;
		end
		default: begin
			acc = 'd650;
		end

	endcase
end


endmodule
