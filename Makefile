
## export genlink_family=stm32f1
## export genlink_subfamily=stm32f103c8
## export genlink_cpu=cortex-m3
## export genlink_fpu=soft
## export genlink_cppflags=-DSTM32F1 -DSTM32F103C8
## export genlink_defs=-DSTM32F1 -DSTM32F103C8 -D_ROM=64K -D_RAM=20K -D_ROM_OFF=0x08000000 -D_RAM_OFF=0x20000000

all:blinky-build

libopencm3-build:
	$(MAKE) all -C libopencm3 -j 16

libopencm3-clean:
	$(MAKE) clean -C libopencm3 -j16
	
blinky-build:
	$(MAKE) all -C blinky -j 8
	
blinky-clean:
	$(MAKE) clean -C blinky -j 8

blinky-flash: blinky-build
	st-flash --reset write blinky/stm32-blinky.bin 0x8000000
