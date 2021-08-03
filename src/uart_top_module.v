module uart(clk, UART_STA_TX, UART_TXREG, UARTn_TXD, rst, Baud_Rate, tick);


input UARTn_RXD;
input clk;
input UARTn_CTS;

output UARTn_RTS;
output UARTn_TXD;

uart_rx rx_inst (.clk(clk), .UARTn_RXD(UARTn_RXD), .UARTn_RTS(UARTn_RTS));
uart_tx tx_inst (.clk(clk), .UARTn_CTS(UARTn_CTS), .UARTn_TXD(UARTn_TXD));
 
endmodule
