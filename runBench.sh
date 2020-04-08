#! /bin/sh
set -e
_emp=""
_got=$1
if [ $_got = $_emp ]
then
    echo "Give PR Name"
    exit
fi
echo "Running Benchmark"
git clone https://github.com/cjatin/HIPPerfTests.git
CDIR=$PWD
cd HIPPerfTests
HIPCCBIN=$CDIR/HIP/build/install/bin/hipcc
HIPDIR=$CDIR/HIP
$HIPCCBIN main.cc -isystem "$CDIR/benchmark/build/install/include" -L"$CDIR/benchmark/build/install/lib" -lbenchmark -lpthread -o mainpre -O3
cd $HIPDIR
PATCH="https://github.com/ROCm-Developer-Tools/HIP/pull/$1.patch"
wget $PATCH
git apply "$1.patch"
cd build
make -j$(nproc) install
cd $CDIR
cd HIPPerfTests
$HIPCCBIN main.cc -isystem "$CDIR/benchmark/build/install/include" -L"$CDIR/benchmark/build/install/lib" -lbenchmark -lpthread -o mainpost -O3
$CDIR/benchmark/tools/compare.py benchmarks ./mainpre ./mainpost
