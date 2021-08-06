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

**_The Baud Rate Generator Logic_**
* This logic is generic and can work with different clock rate-values and, different baud rates specified by the user.
* This Logic counts the number of baud pulses within the original clock. 
* This value is the total number of pulses per bit.
* This value will be shifted 8 times to the right (/16) for getting the divisor value.
* The divisor value is used for generating the pulse used for sampling in the right time for transmission. . 

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
