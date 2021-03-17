`timescale 1ns/1ns
module uart_rx_tb();


reg clk; 
reg UARTn_RXD;

wire UARTn_RTS;

parameter period= 6,
         // delay = 104166;
          delay= 30;

//DUT_instantiation
uart_rx u1 ( .clk(clk) , .UARTn_RXD(UARTn_RXD), .UARTn_RTS(UARTn_RTS) );


//clk_gen
always 
begin
#(period/2) clk = 1;
#(period/2) clk = 0;
end


//stimilus_gen
initial
begin
#(delay) UARTn_RXD =1;
#(delay) UARTn_RXD =1;
#(delay) UARTn_RXD =0;
#(delay) UARTn_RXD =0;
#(delay) UARTn_RXD =1;
#(delay) UARTn_RXD =0;
#(delay) UARTn_RXD =1;
#(delay) UARTn_RXD =1;
#(delay) UARTn_RXD =0;
#(delay) UARTn_RXD =0;
#(delay) UARTn_RXD =1;
#(delay) UARTn_RXD =1;

end



initial

begin
$time_format(-9,3,"ns");
$display("        ", "     Time clk UARTn_RXD UARTn_RTS");
$monitor("%t %b %b %b " , $realtime, clk, UARTn_RXD, UARTn_RTS);
end

endmodule


