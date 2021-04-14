module uart(UARTn_RXD, UARTn_CTS, clk, UARTn_RTS, UARTn_TXD);
input UARTn_RXD;
input clk;
input UARTn_CTS;
output UARTn_RTS;
output UARTn_TXD;

uart_rx rx_inst (.clk(clk), .UARTn_RXD(UARTn_RXD), .UARTn_RTS(UARTn_RTS));
uart_tx tx_inst (.clk(clk), .UARTn_CTS(UARTn_CTS), .UARTn_TXD(UARTn_TXD));
 

endmodule
