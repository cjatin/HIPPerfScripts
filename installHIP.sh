#! /bin/sh
rm -rf HIP
git clone https://github.com/ROCm-Developer-Tools/HIP.git # Hard coded
CDIR=$PWD
cd HIP
git checkout master # branch
mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=$PWD/install
make -j$(nproc) install
cd $CDIR
