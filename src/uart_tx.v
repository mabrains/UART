module uart_tx(clk, rst, Baud_Rate, UART_STA_TX, UART_TxREG, UART_TXD);
   
  input  clk;           //assumed to be 100M HZ
  input rst;
  input UART_STA_TX;      //if 1 transmit else don't, controlled internally from the mgmt area
  output reg UART_TXD; //serial data transmit pin
  input [7:0] UART_TxREG;   //=8'b00_10_10_10;        //Transimitter Holding Register
  input [16:0] Baud_Rate;
  
  wire [3:0] tick_spike;
  wire [3:0] tick;
  wire parity_check_bit;
  
reg [3:0] transmitted_bit_index = 4'b0;
reg [4:0] next_state;
reg [4:0] current_state;

parameter  IDLE      = 5'b00001,
           start_bit = 5'b00010,
           data_bits = 5'b00100,
           parity_bit= 5'b01000,
           stop_bit  = 5'b10000;

   //uart_baud_rate_instantiation
   uart_baud_generator u1_tx (.clk(clk), .rst(rst), .Baud_Rate(Baud_Rate), .tick(tick), .tick_spike(tick_spike));

always @ (posedge clk) begin

	$monitor("UART_TXD = %b, current_state = %b \n", UART_TXD, current_state, );
end

always @ (posedge clk)
begin

if(UART_STA_TX)
current_state <= next_state;
else
current_state <= IDLE;
end

always @ (posedge tick)
begin
case(current_state)

IDLE:begin
UART_TXD = 1'b1;
if(UART_STA_TX)
next_state <= start_bit;
else
next_state <= IDLE;
end 

start_bit: begin
if(tick_spike == 4'b0001) 
    begin
	   // $display("For Testing");
	   // $finish;
    UART_TXD = 1'b0;
    next_state <= data_bits;
  end
  else
    next_state <= start_bit;
  end
  
  
data_bits: begin
	if(tick_spike <= 4'b1001)
        if(transmitted_bit_index < 4'b1000)
          begin
        UART_TXD = UART_TxREG[transmitted_bit_index];

        transmitted_bit_index <= transmitted_bit_index + 1;
        $monitor("UART_TXD = %b, current_state = %b \n", UART_TXD, current_state, );

       	next_state <= data_bits;
      end
      
      else 
      begin
	      transmitted_bit_index = 4'b0;
        next_state <= parity_bit;
end
      else
        next_state <= parity_bit;
    end
    
parity_bit: begin
	$finish;
	if(tick_spike == 4'b1010)
      begin
      UART_TXD = parity_check_bit;
      next_state <= stop_bit;
      end
      else
      next_state <= parity_bit;
      end
 
stop_bit:begin
	 if(tick_spike == 4'b1011)
       	// if(tick == 4'b1000)
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
  assign parity_check_bit = ^UART_TxREG;
  
  
endmodule
