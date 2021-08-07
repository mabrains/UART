UART From RTL to GDS-II
-----------------------
The Design's Feautures:
| Feauture               |         value                                     |
| -----------            | ------------                                      |
| Frequency              | Generic                                           |
| Baud Rate              | Generic - specified by the user                   |
| Sampling Rate          | 16x                                               |
|  Divisor Value         | Calculated Internally by The Logic                |
| Core Utilization Ratio | 20%                                               |
| Area                   | 83.315* 94.035 μm^2                               |
  
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

**_The Transmitter Top Module_**
--------------------------------

![Screen Shot 2021-08-08 at 12 12 57 AM](https://user-images.githubusercontent.com/36249257/128615093-28810777-810e-4a23-80e3-9d774e7c5fcb.png)

**_The Transmitter Finite State Machine_**
------------------------------------------

![Screen Shot 2021-08-08 at 12 22 14 AM](https://user-images.githubusercontent.com/36249257/128615191-caff9ad6-9396-46ee-b1ad-edd55469a4d3.png)

* The FSM implemented is configured for: 
  * 1 start bit
  * Flexibility for (5-9) data bit frame configuring from the user end
  * No or ‘1’ parity bit
  * And 1 or 2 stop bits

**_Baud Rate Generator 1_**
----------------------------

* Divisor = Clock Frequency/ (16 * Baud Rate)
* Baud Rates are standards that the serial communication techniques use for data transfer
* 16x is the oversampling rate, means a generated clock faster 16 times than the clock rate is used 
* The number of pulses per every edge for the new generated clock is called the divisor
* In UART, we transmit(sample) on the half of the new generated clock cycle 
* In the design, we use a ‘case statement’ for specifying different divisor values for a certain clock frequency
* Then we use this divisor in a 4-bit counter(up- counter), that reaches “1111” then overflows and returns back to “0000”
* This is equivalent to the bit duration
* When the counter reaches “1000”, in HDL it needs  to be “1001”, at this value we send our data
* So, the divisor is the number of bits per count in the counter
* You will find this in src/uart_baud_generator.v 

**_Baud Rate Generator 2_**
-----------------------------

* In this, we tried to make things more generic and flexible to be used with different clock frequencies
* Here, we calculate the divisor every time the user specify a certain baud rate to send on
* So, here the idea of the logic, is that we calculate the number of baud bits in the original clock
* For example, we can calculate how many baud bits(ex: 9600) in a 100 Mhz clock, this is done inside the logic and this gives us the number of pulses per bit
* Then by shifting this value 8 times to the right this is equivalent to dividing by 16, this means we get the divisor value 
* After getting the divisor value the idea is the same, we make a 4-bit up counter and count till we reach 1000, “1001” in HDL, and transmit/sample at this point
* You will find this in src/baud_rate_generator_block.v

## PnR flow using openlane:

> - For running openlane in the interactive mode:
flow.tcl -interactive
> - Some dependencies
package require openlane 0.9
> - This command makes a run directory with a time-stamp name under our design_directory
prep -design uart

![Screenshot from 2021-04-14 13-38-20](https://user-images.githubusercontent.com/36249257/114717009-eb82a500-9d34-11eb-827a-bc39186e6233.png)

For running synthesis:

![Screenshot from 2021-04-14 13-38-43](https://user-images.githubusercontent.com/36249257/114717685-93986e00-9d35-11eb-835d-8b3f4d1bb2f4.png)
![Screenshot from 2021-04-14 14-04-38](https://user-images.githubusercontent.com/36249257/114717753-a743d480-9d35-11eb-81d7-00858b67bf32.png)

> - This warning makes an error in the placement stage, the issue is that the core area is too small for the design.
So, by referring to configuration/README.md, FLoorplanning section environmental variables.
We change the 'FP_CORE_UTIL' from 50% default value to 47%, in the config.tcl file under the design directory.
Then ran the flow again
![Screenshot from 2021-04-14 14-05-22](https://user-images.githubusercontent.com/36249257/114717854-c5a9d000-9d35-11eb-80dd-d3c416215da6.png)

> - flow.tcl -interactive
> - package require openlane 0.9
> - prep -design uart -tag run_name -overwrite

![Screenshot from 2021-04-14 14-17-09](https://user-images.githubusercontent.com/36249257/114719702-a3b14d00-9d37-11eb-94b9-8d06ca9609c5.png)

> - run_synthesis

![Screenshot from 2021-04-14 14-18-21](https://user-images.githubusercontent.com/36249257/114719750-add34b80-9d37-11eb-8c9f-f1dcc102d361.png)

> - run_floorplan

![Screenshot from 2021-04-14 14-07-34](https://user-images.githubusercontent.com/36249257/114717814-b7f44a80-9d35-11eb-9728-c85f72a9e69c.png)


> - run_placement

![Screenshot from 2021-04-14 14-08-21](https://user-images.githubusercontent.com/36249257/114719511-749adb80-9d37-11eb-86c8-eca2cffa5599.png)

> - For viewing the layout after placement on magic, we need the technology file under the pdks directory, the lef file under runs/tmp directory & the def file under results/placement directory

![Screenshot from 2021-04-14 14-28-50](https://user-images.githubusercontent.com/36249257/114719904-d0fdfb00-9d37-11eb-80dd-de6474ad6b1d.png)


> - run_cts
![Screenshot from 2021-04-14 14-10-48](https://user-images.githubusercontent.com/36249257/114719591-88ded880-9d37-11eb-85a4-4b1443a4962f.png)

> - The layout after the cts stage:
![Screenshot from 2021-04-14 14-34-56](https://user-images.githubusercontent.com/36249257/114720635-79ac5a80-9d38-11eb-9be3-c9e1541da39d.png)


> - run_routing
![Screenshot from 2021-04-14 15-44-42](https://user-images.githubusercontent.com/36249257/114720526-600b1300-9d38-11eb-8641-cb47106449e4.png)

> - For generating the GDSII.
On magic: file>> write GDS

> - The GDSII on klayout.
klayout uart.gds
![Screenshot from 2021-04-14 14-42-52](https://user-images.githubusercontent.com/36249257/114721792-8ed5b900-9d39-11eb-850e-73f0d89960f9.png)

> - Core Area:

![Screenshot from 2021-04-14 20-40-57](https://user-images.githubusercontent.com/36249257/114762408-061f4300-9d62-11eb-8af6-6b18895c42dc.png)


## A Second Run Using the High Density Low Leakage Library(hdll):
> - flow.tcl -interactive
> - package require openlane 0.9
> - prep -design uart -tag second_run

![Screenshot from 2021-04-14 19-28-17](https://user-images.githubusercontent.com/36249257/114760110-4630f680-9d5f-11eb-82c8-5c25f7b67d55.png)

> - run_synthesis

![Screenshot from 2021-04-14 19-28-48](https://user-images.githubusercontent.com/36249257/114760213-5f39a780-9d5f-11eb-83fb-55d707a7dd6a.png)

> - run_floorplan

![Screenshot from 2021-04-14 19-37-30](https://user-images.githubusercontent.com/36249257/114760243-6660b580-9d5f-11eb-99c8-1a9e8f438fd8.png)

> - run_placement

![Screenshot from 2021-04-14 19-38-25](https://user-images.githubusercontent.com/36249257/114760373-85f7de00-9d5f-11eb-9fff-0957c2f3ab3e.png)

> - run_cts

![Screenshot from 2021-04-14 19-41-44](https://user-images.githubusercontent.com/36249257/114760417-9314cd00-9d5f-11eb-90a0-37b72f241fb4.png)

> - run_routing 

![Screenshot from 2021-04-14 19-50-12](https://user-images.githubusercontent.com/36249257/114760511-aaec5100-9d5f-11eb-93fa-94de76ae7202.png)

Core Area:

![Screenshot from 2021-04-14 20-39-16](https://user-images.githubusercontent.com/36249257/114762239-cfe1c380-9d61-11eb-9a6a-ca0c9560741f.png)


## Observations:
The slack value decreased
The area increased
