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

MANPATH=$MANPATH:/opt/nvidia/hpc_sdk/Linux_x86_64/25.11/compilers/man; export MANPATH
PATH=/opt/nvidia/hpc_sdk/Linux_x86_64/25.11/compilers/bin:$PATH; export PATH


apt install -y libnetcdf-dev build-essential autoconf automake libtool pkg-config tzdata
export CONFIG_SHELL=/bin/bash

autoreconf -vif

./autogen.sh

./configure FCFLAGS="-mp=gpu -Minfo=mp -stdpar=gpu -gpu=nomanaged -fast -O3 -gpu=ccall -DSIZEOF_PTRDIFF_T=999" FC=nvfortran --disable-shared --disable-openmp --prefix=/home/laurits-andreasen/sfincs/nvfortran_gpu_omp

make clean

make

make install

echo "Build finished at $(date)"
