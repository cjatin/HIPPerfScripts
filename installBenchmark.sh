#! /bin/sh
export HIP_PATH=$PWD/HIP/build/install
export PATH=$HIP_PATH/bin:$PATH
BENCH="https://github.com/jatinx/benchmark.git"
CDIR=$PWD
GTEST="https://github.com/google/googletest.git"
which hipcc
git clone "$BENCH"
git clone "$GTEST" benchmark/googletest
cd benchmark
git checkout amd
mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=$PWD/install -DBENCHMARK_ENABLE_GTEST_TESTS=OFF -DCMAKE_CXX_COMPILER=hipcc -DCMAKE_CXX_FLAGS="-DENABLEGPU=1" -DCMAKE_VERBOSE_MAKEFILE=True -DBENCHMARK_ENABLE_TESTING=OFF -DRUN_HAVE_STD_REGEX=0 -DCMAKE_BUILD_TYPE=Release
make -j$(nproc) install
