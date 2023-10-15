# Kuchen Computer

Kuchen is an FPGA computer designed by Lone Dynamics Corporation.

![Kuchen FPGA Computer](https://github.com/machdyne/kuchen/blob/b099f1ab29b17824f0c5727d06bcca6faf649b49/kuchen.png)

This repo contains PCB layouts, schematics, pinouts, example gateware and documentation.

Find more information on the [Kuchen product page](https://machdyne.com/product/kuchen-computer/).

## Blinky 

Building the blinky example requires [Yosys](https://github.com/YosysHQ/yosys), [nextpnr-ice40](https://github.com/YosysHQ/nextpnr) and [IceStorm](https://github.com/YosysHQ/icestorm).

Assuming they are installed, you can simply type `make` to build the gateware, which will be written to output/blinky.bin. You can then use [ldprog](https://github.com/machdyne/ldprog) to write the gateware to the device.

## Zucker

[Zucker](https://github.com/machdyne/zucker) is a RISC-V SOC that supports Kuchen.

## USB Bootloader

Kuchen supports updating the flash MMOD over its USB-C port with the USB DFU (Device Firmware Upgrade) protocol. When Kuchen powers on (or restarts) the USB bootloader waits 5 seconds for a USB command and then continues the boot process, if it receives a command it will wait until the device is detached (with `dfu-util -e`) or rebooted (with `ldprog -r`).

In order to install the USB bootloader you will need to use the ISP header and [ldprog](https://github.com/machdyne/ldprog). Make sure you have first installed the software required to build the Blinky example above.

```
git clone https://github.com/machdyne/tinydfu-bootloader
cd tinydfu-bootloader/boards/kuchen
make
make prog
```

Now you can program the flash MMOD over USB:

```
ldprog -r
sudo dfu-util -a 0 -D zucker/output/soc.bin
sudo dfu-util -a 1 -D zucker/apps/lix/lix.bin
```

Exit the bootloader and continue booting:

```
sudo dfu-util -e -a 0
```

## ISP Header

The ISP header can be used to program the FPGA SRAM as well as the MMOD flash memory. 

```
7 5 3 1
8 6 4 2
```

| Pin | Signal |
| --- | ------ |
| 1 | CSPI\_SS |
| 2 | CSPI\_SCK |
| 3 | CSPI\_SI |
| 4 | CSPI\_SO |
| 5 | CRESET |
| 6 | CDONE |
| 7 | GND |
| 8 | PWR5V0 |

## License

The contents of this repo are released under the [Lone Dynamics Open License](LICENSE.md).

Note: You can use these designs for commercial purposes but we ask that instead of producing exact clones, that you either replace our trademarks and logos with your own or add your own next to ours.

