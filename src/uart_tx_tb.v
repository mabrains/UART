`timescale 1ns/1ns
module uart_tx_tb();

reg clk; 
reg rst;
reg [16:0] Baud_Rate;
reg UART_STA_TX;
reg [7:0] UART_TxREG;
wire UART_TXD;

wire [3:0] tick;
reg [10:0] index = 11'b0;
reg [10:0] recieved_bits = 11'b0;

parameter period = 10,
          delay= 20;

//TX_instance
uart_tx u1_tx ( 
	.clk(clk) ,
        .rst(rst),	
	.UART_STA_TX(UART_STA_TX), 
	.UART_TxREG(UART_TxREG), 
	.UART_TXD(UART_TXD),
        .Baud_Rate(Baud_Rate)	
);

initial begin
	clk = 1;
end

//clk_gen
always 
begin
#(period/2) clk = 1;
#(period/2) clk = 0;
end

//////test 1 /////
always @ (UART_TXD) begin
if(UART_TXD == 0)
	$finish;
end

//stimilus_gen
initial
begin
	rst = 1;
	Baud_Rate = 'd1200;
        UART_STA_TX = 1;
        UART_TxREG = 8'b10_10_10_10;
end
/*

always @ (UART_TXD) begin
if(index < 1100)
	recieved_bits[index] = UART_TXD;
	index <= index + 1;
end

always @ (recieved_bits) begin
if(recieved_bits == 10_01_01_01_01_0)
	$finish;
end
*/
/*
initial
begin
$timeformat(-9,2,"ns",7);
$monitor("t = %5d, clk = %b, Baud_Rate = %d, tick = %b, UART_STA_TX = %b, UART_TxREG = %b, UART_TXD = %b, recieved_bits = %b \n" , $time, clk, Baud_Rate, tick, UART_STA_TX, UART_TxREG, UART_TXD, recieved_bits, );
end
*/
endmodule
