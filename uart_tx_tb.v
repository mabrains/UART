`timescale 1ns/1ns
module uart_tx_tb();


reg clk; 
reg UARTn_CTS;

wire UARTn_TXD; //the serial_out transmitting pin

parameter period= 6.66,
          delay = 104166;
       // delay= 30;

//DUT_instantiation
uart_tx u1_tx ( .clk(clk) , .UARTn_CTS(UARTn_CTS), .UARTn_TXD(UARTn_TXD) );


//clk_gen
always 
begin
#(period/2) clk = 1;
#(period/2) clk = 0;
end


//stimilus_gen
initial
begin
#(delay) UARTn_CTS =1;

end



initial

begin
$time_format(-9,3,"ns");
$display("        ", "     Time clk UART_CTS UARTn_TXD");
$monitor("%t %b %b %b " , $realtime, clk, UARTn_CTS, UARTn_TXD);
end

endmodule
