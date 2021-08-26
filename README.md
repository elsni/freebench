# FreeBench v1.03
This was taken from www.freebench.org which is down for years now.
Since I still like to compare computer benchmark results with old systems
I stick to this benchmark test. It should compile fine on modern linux.

## What is this?
Single Core Benchmark Suite for Modern Microprocessors and Computer Systems.

## QUICK START
Read the section HOW TO RUN below.

## INFO
This benchmark consists of a number of programs that stress many
parts of a computer system. The programs are split into two groups, 
Integer (4) and Floating point (3) programs. These programs are a
good mix of CPU intensive and memory intensive programs. The 
performance figure given is a quite representative approximation
of machine performance. Of course, as always, no benchmark can say 
everything about a machine. The best benchmarks are always the 
programs you are interested in.

## HOW TO RUN
* First, edit the file machine_config.cfg and enter all the relevant 
information you have about your machine. Look in the file for more 
information.

* Second, edit the makefile to specify the compilation switches you want for 
your compiler.
 
* Third, run gmake. You should get a list of the possible targets looking
like this.

You must specify one of the following:
 gmake ref - compiles and runs the benchmark
 gmake test - compiles and runs a test run
 gmake util - builds the utilities (done also by ref and test)
 gmake clean - remove the traces of the last compilation
 gmake distclean - same as clean but applies also for the utilities

If you receive an error message saying that the benchmark produced faulty 
results, it means that the results produced by your computer contains errors. 
It is probably the result of too aggressive compiler optimizations, too much 
overclocking, or it might be a bug in the benchmark. If you believe that 
your computer should generate correct results, see below how to report bugs.

Tapsa has provided some very useful scripts avaliable in the utils subdirectory.
These scripts are:

utils/calc.sh 
-- Calculates the geometric average of the results in a given file

utils/updatebest.sh 
-- This script compares the latest benchmark result with the best found so far. 
If any improvement is found the current binaries are copied to the bestof/ directory.
Used after 'gmake ref', and before new compiler options are to be tried.
If the bestof/ directory is empty or non-existent it is created and the
current binaries are copied there.

utils/bestof.sh 
-- This script runs a benchmark with the best found binaries so far.


Using these scripts, a typical run of the benchmark would look like this.

1. Edit Makefile with desired compiler options.
2. Run 'gmake ref'
3. Run 'utils/updatebest.sh'
4. Repeat 1 to 3 until desired performance is acheived.
5. Run 'utils/bestof.sh' to generate the final result with the best binaries 
found.
6. Post your new result to www.freebench.org. Look below how to do this.

## HOW TO REPORT RESULTS

When you have run the reference dataset benchmark, a file called 'result.html'
will be generated. It shows you in a nice graphical way how your machine 
scored. In the same web page there is a submit results button. 

### attention - deprecated
If you click it,
your results will be sent to FreeBench.org and included in a database of 
unofficial results. Once we have had a chance to look at your results to see 
that it is not duplicate of what has already been reported and that it looks 
feasible, we will upgrade it to an official result. The official results as 
well as the unofficial can be viewed on the FreeBench web page, 
www.freebench.org.

## SCORE

The results a normalized against a Sun Ultra10, with a 333MHz UltraSPARCIIi 
and 2MB L2 cache, which receives a score of 1.0. The compiler used was 
Sun Workshop 6 and the only compiler flag used was "-fast". On this machine 
each benchmark program takes approximately 5 to 10 minutes with the reference 
dataset.

## HINTS FOR BETTER PERFORMANCE

The timing of the benchmark includes both startup and the writing of control 
data files to disk. This means the hard disk performance plays a part (although
small) of the result. Try to put the benchmark on a local disk and not on a 
network disk to minimize the effect of hard disk performance.

## HOW TO REPORT BUGS

If you find any bugs or things that are not the way they should be, don't 
hesitate to to mail me at biff@ce.chalmers.se.


The benchmark includes the following programs.

### Integer programs:

#### Analyzer, author Peter Rundberg:
Language: C
Task:
This program is a tool for analyzing memory access traces for data dependences.

It has been used in my research at Chalmers University of Technology. 
The program started out as a quick and dirty hack to test some ideas. 
The program was later given more and more features but the fact that it 
was a dirty hack made it very slow and hard to work with. The program has been
discarded and replaced by a new tool, STT, written to be more scalable.
Stress points:
This program is integer only but is mainly limited by memory system 
performance. The memory accesses are very scattered, and while out-of-order
processors can hide some of the memory latency, they can not hide all of it.
Fast caches larger than 512kB seem to help to some extent but not entirely. The
key to good performance is a well balanced machine with good memory bandwidth, 
low memory latency and good latency hiding capabilities. Compilers able to 
insert prefetches should be able to hide some of the memory latency, and thus 
improve performance quite a bit.

#### FourInARow, author Peter Rundberg:
Language: C
Task:
This is a program that plays a game of "four in a row" against itself. Poorly
I might add. The program started out as a learning experience in game tree
programming. It uses a min-max method with alpha-beta pruning as a search
algorithm. The reason for it being poor is because of a lousy board value
function.
Stress points:
This program is integer only, but is not limited by the memory system. Some
arithmetics is done using 64 bit integers, so 64 bit machines should fare well.
The memory footprint is small and the execution time is spent in small 
recursive loops. Most of the execution fits in on-chip caches. Wide 
superscalar processors with OoO capabilities should see good performance in 
this program. Some compilers have difficulties generating good code for 
this program. Why, I do not know. Thus it is also a good compiler test.

#### Mason, author Tord Hansson:
Language: C
Task:
This program solves a puzzle. See the file SOLUTION.txt in the benchmark 
subdirectory for more information.
Stress points:
This program uses only integer arithmetics, and has a very small data set. This
is a pure clock frequency and ILP limited program. It seems to stress compilers
too, as some compilers generate bad code and many compiler optimizations makes
the program slower.

#### pCompress, author Peter Rundberg:
Language: C
Task:
A file compressor using a three stage approach. Burrows Wheeler blocksorting,
run length encoding and Arithmetic coding. The resulting compression is not 
that good though.
Stress points:
This program is quite memory intensive. The whole indata file is processed at 
once and is repeatedly scanned for compressible data. The program makes heavy 
use of the libc functions qsort, memcmp and memcpy. If your libc is slow, this
program will also be slow.


Floating point programs:

#### PiFFT, author Takuya Ooura:
Language: C
Task:
This program use a huge FFT to calculate many decimal places of PI (3.1415...).
Stress points:
Floating point hungry and very memory intensive are the characteristics of this
program.

#### DistRay, author Marcus Geelnard:
Language: C
Task:
This is a small ray tracer using random ray distribution to achieve anti-
aliasing and soft shadows. It features variable recursion depth for 
reflections.
Stress points:
This is a floating-point program, with small memory footprint. Most of the 
execution is spent in recursive loops, with many floating point multiplications
and additions. A good amount of ILP should be found, stressing the FPU 
resources heavily.

#### NeuralNet, author Fredrik Warg:
Language: C
Task:
This is a neural network doing character recognition. It tries to find a way 
of successfully storing (and thus being able to identify) a number of 
characters written out in ASCII graphics. 
Stress points:
This program has quite a large dataset and is somewhat memory intensive. Fast 
memory is key to good performance.



Special thanks to Tapsa for his help.

Peter Rundberg and Fredrik Warg,
Maintainers of FreeBench
