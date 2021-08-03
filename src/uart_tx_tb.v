`timescale 1ns/1ns
module uart_tx_tb();

reg clk; 
reg UART_STA_TX;
reg [7:0] UART_TxREG;

wire UART_TXD; //the serial_out transmitting pin

parameter period = 10,
          delay= 30;

//DUT_instantiation
uart_tx u1_tx ( 
	.clk(clk) , 
	.UART_STA_TX(UART_STA_TX), 
	.UART_TxREG(UART_TxREG), 
	.UART_TXD(UART_TXD) 
);


//clk_gen
always 
begin
#(period/2) clk = 1;
#(period/2) clk = 0;
end


//stimilus_gen
initial
begin
#(delay) UART_STA_TX = 1;
UART_TxREG = 8'b10_10_10_10;
end



initial
begin
$timeformat(-9,2,"ns",7);
$monitor("t=%5d rst=%b act=%b updown=%b count=%d overflow=%b \n" , $time, rst, act, updown, count, overflow, );
//$display("        ", "     Time clk UART_CTS UARTn_TXD");
$monitor("%t=%5d clk=%b UARTn_CTS=%b UART_TxREG=%b UARTn_TXD=%b " , $time, clk, UARTn_CTS, UARTn_TXD);
end

endmodule
