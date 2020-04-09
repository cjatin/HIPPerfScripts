#! /bin/bash
set -e
echo "Running Benchmark"
git clone https://github.com/cjatin/HIPPerfTests.git
CDIR=$PWD
cd HIPPerfTests
HIPCCBIN=$CDIR/HIP/build/install/bin/hipcc
HIPDIR=$CDIR/HIP
export HIP_PATH=$HIPDIR/build/install
$HIPCCBIN main.cc -isystem "$CDIR/benchmark/build/install/include" -L"$CDIR/benchmark/build/install/lib" -lbenchmark -lpthread -o mainpre -O3
cd $CDIR
cd HIPPerfTests
HIPCCBIN=$CDIR/HIP/patchbuild/install/bin/hipcc
export HIP_PATH=$HIPDIR/patchbuild/install
$HIPCCBIN main.cc -isystem "$CDIR/benchmark/build/install/include" -L"$CDIR/benchmark/build/install/lib" -lbenchmark -lpthread -o mainpost -O3
./mainpre --benchmark_format=json > pre.json
./mainpost --benchmark_format=json > post.json
