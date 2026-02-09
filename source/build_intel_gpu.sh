#!/bin/bash

LOGFILE=build_$(date +%Y%m%d_%H%M%S).log
exec > >(tee "$LOGFILE") 2>&1

echo "Starting build at $(date)"
echo "Saving log to $LOGFILE"

find . -name \*.m4|xargs dos2unix && find . -name \*.ac|xargs dos2unix && find . -name \*.am|xargs dos2unix
find . -name \*.f90|xargs dos2unix
find . -name \*.F90|xargs dos2unix
find . -name \*.am|xargs dos2unix
find . -name \*.sh|xargs dos2unix


apt install -y libnetcdf-dev build-essential autoconf automake libtool pkg-config tzdata
export CONFIG_SHELL=/bin/bash
#export IFXCFG=$(pwd)/ifx.cfg
export IGC_EnableDPEmulation=1          # Enable float64 emulation during compilation
export OverrideDefaultFP64Settings=1    # Enable double precision emulation at runtime - do this before running

autoreconf -vif

./autogen.sh

./configure FCFLAGS="-fiopenmp -fopenmp-targets=spir64 -fopenmp-target-do-concurrent -O2 -fopenmp-do-concurrent-maptype-modifier=present" FC=ifx --disable-shared --prefix=/home/laurits-andreasen/sfincs/nvfortran_gpu_intel


make clean

make

make install

echo "Build finished at $(date)"
