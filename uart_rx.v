module uart_rx(clk, UARTn_RXD, UARTn_RTS);
//rx_pin
//io declaration
input clk;             //assumed to be 5M HZ
input UARTn_RXD;          //for recieving serial data 
output UARTn_RTS;   //Request to send handshaking signal control if 1 the transmitter transmit , else the transmitter don't transmit anything

reg [7:0] RBR;  //Reciever_Buffer_Register
 
//signals declaration
wire[3:0] tick;             //16x_baud_rate_genarator
wire parity_check_bit;
reg flag;

//registers_for_the_two_FFs_for_eleminating_metastability
reg data_in_recieved;  //first reg for eleminating metastability
reg data_in;           //second reg for eleminating metastability

reg[2:0] recieved_bit_index;
reg [2:0] next_state=3'b0;

parameter  IDLE=      3'b000,
           start_bit= 3'b001,
           data_bits= 3'b010,
		   parity_bit= 3'b011,
           stop_bit=  3'b100;

//for eleminating metastability problems 
always @(posedge clk)
begin
data_in_recieved <= UARTn_RXD;
data_in <=data_in_recieved;
end

//Baud_clock_Module_Instantiation
uart_baud_generator u1 (.clk(clk), .tick(tick));

always @ (posedge clk)
begin
case(next_state)
IDLE:begin
RBR <= 8'b0;
if(!data_in)
next_state<= start_bit;
else
next_state<= IDLE;
end

start_bit:begin
if(tick == 4'b1000)
if(!data_in)
begin
next_state<=data_bits;
end
else
next_state<=IDLE;
else
begin
next_state<=start_bit;
end
end

data_bits:begin
if(tick == 4'b1000)
if(recieved_bit_index < 4'b1000)
begin
RBR[recieved_bit_index]<=data_in;
recieved_bit_index<= recieved_bit_index+1;
next_state<=data_bits;
end
else
begin
recieved_bit_index<=4'b0;
next_state<=parity_bit;
end
else
begin
next_state<=data_bits;
end
end

parity_bit:begin
if(tick == 4'b1000)
begin
if(data_in==parity_check_bit)
begin
flag=1'b1;
next_state<=stop_bit;
end
else
begin
flag=1'b0;
next_state<=stop_bit;
end
end
else
begin
next_state<=parity_bit;
end
end


stop_bit: begin
if(tick == 4'b1000)
next_state<=IDLE;
else
begin
next_state<=stop_bit;
end
end
endcase
end

assign parity_check_bit= ^RBR;

endmodule