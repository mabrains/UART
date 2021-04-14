module uart_tx(clk, UARTn_CTS, UARTn_TXD);
   
  input  clk;           //assumed to be 5M HZ
  input UARTn_CTS;     
  output reg UARTn_TXD; //serial data transmit pin
  reg[7:0] THR=8'b00_10_10_10;        //Transimitter Holding Register
  wire[3:0] tick;
  wire parity_check_bit;
  
reg[2:0] transmitted_bit_index= 3'b0;
reg [2:0] next_state=3'b0;

parameter  IDLE      = 3'b000,
           start_bit = 3'b001,
           data_bits = 3'b010,
		   parity_bit= 3'b011,
           stop_bit  = 3'b100;

   //uart_baud_rate_instantiation
  uart_baud_generator u1_tx (.clk(clk), .tick(tick));
  
always @ (posedge clk)
begin
case(next_state)
IDLE:begin
UARTn_TXD <= 1'b1;
if(UARTn_CTS)
next_state<= start_bit;
else
next_state<= IDLE;
end 

start_bit: begin

  if(tick ==4'b1000)
    begin
    UARTn_TXD = 1'b0;
    next_state<= data_bits;
  end
  else
    next_state<= start_bit;
  end
  
  
    data_bits:begin
     
     if(tick==4'b1000)
        if(transmitted_bit_index <= 3'b111)
          begin
        UARTn_TXD = THR[transmitted_bit_index];
        transmitted_bit_index <= transmitted_bit_index +1;
        next_state <= data_bits;
      end
      
      else
        next_state <= parity_bit;
      else
        next_state <= data_bits;
    end
    
    parity_bit:begin
  
    if(tick==4'b1000)
      begin
      UARTn_TXD = parity_check_bit;
      next_state <= stop_bit;
    end
   else
  next_state <= parity_bit;
  end
 
 stop_bit:begin
   if(tick==4'b1000)
    begin
     UARTn_TXD = 1'b1;
     next_state <= IDLE;
   end
 else
   next_state <= stop_bit;
   end
 endcase
end
  assign parity_check_bit= ^THR;
  
  
  
endmodule
