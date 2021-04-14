module uart_baud_generator(clk, tick);

input clk;
output[3:0] tick;
reg tick;
reg [9:0] acc= 10'b0;

/*parameter  clock_frequency= 'd150_000_000,
           Baud_Rate= 'd9600,
           over_sampling_mode= 5'b10000,
           divisor= clock_frequency/(Baud_Rate* over_sampling_mode);
*/


always @ (posedge clk)
begin

if(acc ==10'b1111_010_001 )
begin
tick <= tick+ 4'b0001;  //until it reaches 4'b1111 and overflows to reach 4'b0000 again
acc[9:0] <= 10'b000_000_000;
end
else
acc = acc +9'b000_000_001;

end




endmodule