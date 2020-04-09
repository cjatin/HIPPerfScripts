#! /bin/bash
rm -rf HIP
git clone https://github.com/ROCm-Developer-Tools/HIP.git # Hard coded
CDIR=$PWD
cd HIP
git checkout master # branch
mkdir build
mkdir patchbuild
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=$PWD/install
make -j$(nproc) install
cd ..
PATCH="https://github.com/ROCm-Developer-Tools/HIP/pull/$1.patch"
wget $PATCH
git apply "$1.patch"
cd patchbuild
cmake .. -DCMAKE_INSTALL_PREFIX=$PWD/install
make -j$(nproc) install
cd $CDIR
