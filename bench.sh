#! /bin/bash -x
./installHIP.sh $1 &> op
./installBenchmark.sh &>> op
./runBench.sh &>> op
cd HIPPerfTests
../benchmark/tools/hipcompare.py benchmarks pre.json post.json
cd ..
./cleanup.sh
