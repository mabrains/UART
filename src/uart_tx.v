module uart_tx(clk, tick, UART_STA_TX, UART_TxREG, UART_TXD);
   
  input  clk;           //assumed to be 100M HZ
  input UART_STA_TX;      //if 1 transmit else don't, controlled internally from the mgmt area
  output reg UART_TXD; //serial data transmit pin
  input [7:0] UART_TxREG;   //=8'b00_10_10_10;        //Transimitter Holding Register
  input [3:0] tick;
  wire parity_check_bit;
  
reg[2:0] transmitted_bit_index= 3'b0;
reg [4:0] next_state;

parameter  IDLE      = 5'b00001,
           start_bit = 5'b00010,
           data_bits = 5'b00100,
           parity_bit= 5'b01000,
           stop_bit  = 5'b10000;

   //uart_baud_rate_instantiation
//  uart_baud_generator u1_tx (.clk(clk), .tick(tick));
 
always @ (posedge clk)
begin

if(UART_STA_TX)
next_state<= start_bit;
else
next_state<= IDLE;
end

always @ (posedge clk)
begin
case(next_state)

IDLE:begin
UART_TXD = 1'b1;
if(UART_STA_TX)
next_state <= start_bit;
else
next_state <= IDLE;
end 

start_bit: begin
 if(tick == 4'b1000)
    begin
    UART_TXD = 1'b0;
    next_state <= data_bits;
  end
  else
    next_state <= start_bit;
  end
  
  
data_bits:begin
  if(tick == 4'b1000)
        if(transmitted_bit_index <= 3'b111)
          begin
        UART_TXD = UART_TxREG[transmitted_bit_index];
        transmitted_bit_index <= transmitted_bit_index +1;
        next_state <= data_bits;
      end
      
      else
        next_state <= parity_bit;
      else
        next_state <= data_bits;
    end
    
parity_bit:begin
  if(tick == 4'b1000)
      begin
      UART_TXD = parity_check_bit;
      next_state <= stop_bit;
    end
   else
  next_state <= parity_bit;
  end
 
stop_bit:begin
   if(tick == 4'b1000)
    begin
     UART_TXD = 1'b1;
     next_state <= IDLE;
   end
 else
   next_state <= stop_bit;
   end

   default: begin
	next_state <= IDLE;
end

 endcase
end
  assign parity_check_bit = ^ UART_TxREG;
  
  
  
endmodule
