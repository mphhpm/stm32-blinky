#!/bin/bash
# $1 Working directory
# $2 Target
##
## attempt to use the libopencm3 build system under windows/cygwin/eclipse
##
echo $0 $1 $2
echo "PWD: $PWD"
export PATH=/bin:${PATH}
cd $1 && /bin/make -j 16 $2
