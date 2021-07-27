module uart_baud_generator(clk, tick);

parameter clock_frequency = 9'd150_000_000,
	  Baud_Rate_1 = 'd1200,
	  Baud_Rate_2 = 'd2400,
	  Baud_Rate_3 = 'd4800,
	  Baud_Rate_4 = 'd9600,
	  Baud_Rate_5 = 'd14400,
	  Baud_Rate_6 = 'd38400,
	  Baud_Rate_7 = 'd57600,
	  Baud_Rate_8 = 'd115200;

input clk;
output[3:0] tick;
reg tick;
reg [16:0] acc= 17'b0;
reg [16:0] Baud_Rate;
reg [16:0] count = 17'b0;
/*parameter  clock_frequency= 'd150_000_000,
           Baud_Rate= 'd9600,
           over_sampling_mode= 5'b10000,
           divisor= clock_frequency/(Baud_Rate* over_sampling_mode);
*/

always @(posedge clk) begin
	case (Baud_Rate)
		Baud_Rate_1: begin
			acc = 'd125008;
		end
		Baud_Rate_2: begin
			acc = 'd62496;
		end
		Baud_Rate_3: begin
			acc = 'd31248;
		end
		Baud_Rate_4: begin
			acc = 'd15632;
		end
		Baud_Rate_5: begin
			acc = 'd10416;
		end
		Baud_Rate_6: begin
			acc = 'd3904;
		end
		Baud_Rate_7: begin
			acc = 'd2608;
		end
		Baud_Rate_8: begin
			acc = 'd1296;
		end
		default: begin
			acc = 'd15632;
		end

	end



always @ (posedge clk) begin

if(count == acc )
begin
tick <= tick+ 4'b0001;  //until it reaches 4'b1111 and overflows to reach 4'b0000 again
count <= 17'b000_000_000;
end
else
count = count +17'b000_000_001;

end




endmodule
