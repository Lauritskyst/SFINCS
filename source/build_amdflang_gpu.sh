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

PATH=/root/aomp_23.0-0/bin:$PATH; export PATH

LD_LIBRARY_PATH=/root/aomp_23.0-0/lib:$LD_LIBRARY_PATH; export LD_LIBRARY_PATH

apt install -y libnetcdf-dev build-essential autoconf automake libtool pkg-config tzdata
export CONFIG_SHELL=/bin/bash

autoreconf -vif

./autogen.sh

./configure FCFLAGS="-O3 -fopenmp --offload-arch=gfx942 -fdo-concurrent-to-openmp=device" FC=amdflang --disable-shared --disable-openmp --prefix=/root/SFINCS/binaries

make clean

make

make install

echo "Build finished at $(date)"
