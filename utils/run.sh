#!/bin/sh

echo "*** Running Analyzer ***"
./utils/runbenchmark $1 analyzer > analyzer.out
./utils/benchdiff analyzer.out benchmarks/analyzer/data/out/$1.out

echo ""
echo "*** Running FourInARow ***"
./utils/runbenchmark $1 fourinarow > fourinarow.out
./utils/benchdiff fourinarow.out benchmarks/fourinarow/data/out/$1.out

echo ""
echo "*** Running Mason ***"
./utils/runbenchmark $1 mason > mason.out
./utils/benchdiff mason.out benchmarks/mason/data/out/$1.out

echo ""
echo "*** Running pCompress2 ***"
./utils/runbenchmark $1 pcompress2 > pcompress2.out
./utils/benchdiff pcompress2.out benchmarks/pcompress2/data/out/$1.out

echo ""
echo "*** Running PiFFT ***"
./utils/runbenchmark $1 pifft > pifft.out
./utils/benchdiff pifft.out benchmarks/pifft/data/out/$1.out

echo ""
echo "*** Running DistRay ***"
./utils/runbenchmark $1 distray > distray.out
./utils/benchdiff distray.out benchmarks/distray/data/out/$1.out

echo ""
echo "*** Running Neural ***"
./utils/runbenchmark $1 neural > neural.out
./utils/benchdiff neural.out benchmarks/neural/data/out/$1.out

rm -f *.out
