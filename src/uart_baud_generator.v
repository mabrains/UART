module uart_baud_generator(clk, rst, Baud_Rate, tick);

parameter clock_frequency = 'd150_000_000;

input clk, rst;
input [16:0] Baud_Rate;
output[3:0] tick;   //for 16x higher than the baud rate for correct bit sampling

reg [16:0] count = 17'b0;
reg tick = 4'b0;
reg [16:0] acc= 17'b0;       //accumulator * 16 = number of pulses per bit,  this value of number of pulses in 1 second is the baud rate required

/*always @(posedge clk or negedge rst)
	if(!rst)
		tick <= 4'b0;
	else
*/

always @ (posedge clk) begin

if(count == acc )
begin
tick <= tick+ 4'b0001;  //until it reaches 4'b1111 and overflows to reach 4'b0000 again
count = 17'b000_000_000;
end
else
count <= count +17'b000_000_001;

end


always @(posedge clk) begin
	case (Baud_Rate)
		'd1200: begin
			acc = 'd7813;
		end
		'd2400: begin
			acc = 'd3906;
		end
		'd4800: begin
			acc = 'd1953;
		end
		'd9600: begin
			acc = 'd977;
		end
		'd14400: begin
			acc = 'd10416;
		end
		'd38400: begin
			acc = 'd244;
		end
		'd57600: begin
			acc = 'd163;
		end
		'd115200: begin
			acc = 'd81;
		end
		default: begin
			acc = 'd977;
		end

	endcase
end


endmodule
