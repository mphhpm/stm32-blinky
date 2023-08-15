export CYGWIN_DIR= C:/cygwin64/bin
export BUILD_DIR = bin/obj
##
## ensure no optimization when debugging
export OPT = -O0
##
## set verbosity as required
#export V= 99

all:blinky-build

libopencm3-build:
	$(CYGWIN_DIR)/bash -e ./compile.sh $(PWD)/libopencm3 all

libopencm3-clean:
	$(CYGWIN_DIR)/bash -e ./compile.sh $(PWD)/libopencm3 clean
	
blinky-build:
	$(CYGWIN_DIR)/bash -e ./compile.sh $(PWD)blinky all
	
blinky-clean:
	$(CYGWIN_DIR)/bash -e ./compile.sh $(PWD)blinky clean

blinky-flash: blinky-build
	st-flash --reset write blinky/stm32-blinky.bin 0x8000000
