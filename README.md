UART From RTL to GDS-II
-----------------------
The Design's Feautures:
| Feauture               |         value       |
| -----------            | ------------        |
| Frequency              | 150 MHZ             |
| Baud Rate              | 9600                |
| Sampling Rate          | 16x                 |
|  Divisor Value         | 977                 |
  
**_Description_** 
  --------------
* A universal Asynchronous Receiver-Transmitter(UART) is a computer hardware device for asynchronous serial communication in which the data format and transmission speeds are configurable.
* Configurable Speeds mean that it can be adjusted to several standard rates for transmitting and recieving, which is slow relative to the original clock.
* This is done via hardware design and implementation.
* The code here is specific for baud rate 9600 bits/sec only.
* In the top design you'll find instances from the transmitter and the reciever submodules.
* In both transmitter and reciever we instansiate the baud-rate generator that generates clock 16x times faster than the      original clock, to sample the recieved bits, and transmit the data needed, relative to this new generated clock.
* The new generated clock is 16x faster than the baud rate, which means that each bit will contai 16 cycles or oulses from this new generated clock.
* Since the UART system is an asynchronous system, we make several things to transmit and recover the data correctly not in the wrong time.
* First thing is that we send a start bit to declare the begining of the communication which we check it every clock cycle of the original clock.

* The line is normally high until we send the start bit which is equal to 0.
* When we detect this 0 at the active edge of the original clock, we check it again at the middle of the bit duration again but relative to the new generated clock to know for sure that this is the declaration of the communication line.
* After declaring the beginig of communication, data bits are sent followed by parity bit as a check followed by an end bit that declares the end of communication.



