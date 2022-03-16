# Global Makefile for the FreeBench benchmark suite...

##############################################################################
# 
# Simple configuration
#
##############################################################################

# We require the gnu-make utility
MAKE = make

# Compiler and linker to use
CC = gcc
LD = $(CC)

# Compiler flags used for all benchmarks
COMMON = -O3

# Linker flags used for all benchmarks
LFLAGS =

# Flags for profile generation and use in feedback compilation (optional)
PROF_GEN =
PROF_USE =

##############################################################################
#
# Advanced configuration, customization of each benchmark separately
# Values defaults to the ones in the simple configuration
#
##############################################################################

# Compiler to use for each part
CC1 = $(CC)
CC2 = $(CC)
CC3 = $(CC)
CC4 = $(CC)
CC5 = $(CC)
CC6 = $(CC)
CC7 = $(CC)

# Compiler options for each part
FLAGS1 = $(COMMON)
FLAGS2 = $(COMMON)
FLAGS3 = $(COMMON)
FLAGS4 = $(COMMON)
FLAGS5 = $(COMMON)
FLAGS6 = $(COMMON)
FLAGS7 = $(COMMON)

# Profiling information gathering flag for each part (useful if using different compilers per part)
PROF_GEN1 = $(PROF_GEN)
PROF_GEN2 = $(PROF_GEN)
PROF_GEN3 = $(PROF_GEN)
PROF_GEN4 = $(PROF_GEN)
PROF_GEN5 = $(PROF_GEN)
PROF_GEN6 = $(PROF_GEN)
PROF_GEN7 = $(PROF_GEN)

# Compilation flags for using profiling information
PROF_USE1 = $(PROF_USE)
PROF_USE2 = $(PROF_USE)
PROF_USE3 = $(PROF_USE)
PROF_USE4 = $(PROF_USE)
PROF_USE5 = $(PROF_USE)
PROF_USE6 = $(PROF_USE)
PROF_USE7 = $(PROF_USE)

# Linker to use for each part
LD1 = $(CC1)
LD2 = $(CC2)
LD3 = $(CC3)
LD4 = $(CC4)
LD5 = $(CC5)
LD6 = $(CC6)
LD7 = $(CC7)

# Linker flags to use for each part
LFLAGS1 = $(FLAGS1) $(LFLAGS)
LFLAGS2 = $(FLAGS2) $(LFLAGS)
LFLAGS3 = $(FLAGS3) $(LFLAGS)
LFLAGS4 = $(FLAGS4) $(LFLAGS)
LFLAGS5 = $(FLAGS5) $(LFLAGS)
LFLAGS6 = $(FLAGS6) $(LFLAGS)
LFLAGS7 = $(FLAGS7) $(LFLAGS)

# Linker flags used when profiling (necessary on AIX etc)
LPROF_GEN1 = $(PROF_GEN1)
LPROF_GEN2 = $(PROF_GEN2)
LPROF_GEN3 = $(PROF_GEN3)
LPROF_GEN4 = $(PROF_GEN4)
LPROF_GEN5 = $(PROF_GEN5)
LPROF_GEN6 = $(PROF_GEN6)
LPROF_GEN7 = $(PROF_GEN7)

LPROF_USE1 = $(PROF_USE1)
LPROF_USE2 = $(PROF_USE2)
LPROF_USE3 = $(PROF_USE3)
LPROF_USE4 = $(PROF_USE4)
LPROF_USE5 = $(PROF_USE5)
LPROF_USE6 = $(PROF_USE6)
LPROF_USE7 = $(PROF_USE7)

##############################################################################
#
# Make rules
# You should not need to edit anything below this...
#
##############################################################################

BENCHDIR = ./benchmarks
UTILDIR = ./utils
RUNSCRIPT = $(UTILDIR)/run.sh
PARSER = $(UTILDIR)/fbparser
RUNBENCH = $(UTILDIR)/runbenchmark

BENCH1 =analyzer
BENCH2 =fourinarow
BENCH3 =mason
BENCH4 =pcompress2
BENCH5 =pifft
BENCH6 =distray
BENCH7 =neural

BENCHMARK1 = $(BENCHDIR)/$(BENCH1)
BENCHMARK2 = $(BENCHDIR)/$(BENCH2)
BENCHMARK3 = $(BENCHDIR)/$(BENCH3)
BENCHMARK4 = $(BENCHDIR)/$(BENCH4)
BENCHMARK5 = $(BENCHDIR)/$(BENCH5)
BENCHMARK6 = $(BENCHDIR)/$(BENCH6)
BENCHMARK7 = $(BENCHDIR)/$(BENCH7)

# The benchmark utilities
UTIL1 = $(UTILDIR)/src/BenchDiff
UTIL2 = $(UTILDIR)/src/RunBenchmark
UTIL3 = $(UTILDIR)/src/FBParser

default:
	@echo "You must specify one of the following:"
	@echo " make ref - compiles and runs the benchmark"
	@echo " make test - compiles and runs a test run"
	@echo " make util - builds the utilities (done also by ref and test)"
	@echo " make clean - remove the traces of the last compilation"
	@echo " make distclean - same as clean but applies also for the utilities"

test: util build strip
	$(RUNSCRIPT) test 2> resultfile.txt
	$(PARSER) test < resultfile.txt
	@echo ""
	@echo "Test run of FreeBench done..."
	@echo "To get a result file you need to run the benchmark with the reference"
	@echo "dataset. Build 'ref' target to do so."

ref: util build strip
	$(RUNSCRIPT) ref 2> resultfile.txt
	$(PARSER) ref < resultfile.txt > result.html
	@echo ""
	@echo "Reference run of FreeBench done..."
	@echo "If all went well you should now have a file called 'result.html'"
	@echo "in the current directory. View it with your favorite web browser."

prof_ref: ref

prof_test: test

##############################################################################

prof1:
	$(MAKE) CC=$(CC1) FLAGS="$(FLAGS1) $(PROF_GEN1)" LD=$(LD1) LFLAGS="$(LFLAGS1) $(LPROF_GEN1)" -C $(BENCHMARK1) all
	$(RUNBENCH) test $(BENCH1) > /dev/null
	$(MAKE) CC=$(CC1) FLAGS="$(FLAGS1) $(PROF_USE1)" LD=$(LD1) LFLAGS="$(LFLAGS1) $(LPROF_USE1)" -C $(BENCHMARK1) clean all

prof2:
	$(MAKE) CC=$(CC2) FLAGS="$(FLAGS2) $(PROF_GEN2)" LD=$(LD2) LFLAGS="$(LFLAGS2) $(LPROF_GEN2)" -C $(BENCHMARK2) all
	$(RUNBENCH) test $(BENCH2) > /dev/null
	$(MAKE) CC=$(CC2) FLAGS="$(FLAGS2) $(PROF_USE2)" LD=$(LD2) LFLAGS="$(LFLAGS2) $(LPROF_USE2)" -C $(BENCHMARK2) clean all

prof3:
	$(MAKE) CC=$(CC3) FLAGS="$(FLAGS3) $(PROF_GEN3)" LD=$(LD3) LFLAGS="$(LFLAGS3) $(LPROF_GEN3)" -C $(BENCHMARK3) all
	$(RUNBENCH) test $(BENCH3) > /dev/null
	$(MAKE) CC=$(CC3) FLAGS="$(FLAGS3) $(PROF_USE3)" LD=$(LD3) LFLAGS="$(LFLAGS3) $(LPROF_USE3)" -C $(BENCHMARK3) clean all

prof4:
	$(MAKE) CC=$(CC4) FLAGS="$(FLAGS4) $(PROF_GEN4)" LD=$(LD4) LFLAGS="$(LFLAGS4) $(LPROF_GEN4)" -C $(BENCHMARK4) all
	$(RUNBENCH) test $(BENCH4) > /dev/null
	$(MAKE) CC=$(CC4) FLAGS="$(FLAGS4) $(PROF_USE4)" LD=$(LD4) LFLAGS="$(LFLAGS4) $(LPROF_USE4)" -C $(BENCHMARK4) clean all

prof5:
	$(MAKE) CC=$(CC5) FLAGS="$(FLAGS5) $(PROF_GEN5)" LD=$(LD5) LFLAGS="$(LFLAGS5) $(LPROF_GEN5)" -C $(BENCHMARK5) all
	$(RUNBENCH) test $(BENCH5) > /dev/null
	$(MAKE) CC=$(CC5) FLAGS="$(FLAGS5) $(PROF_USE5)" LD=$(LD5) LFLAGS="$(LFLAGS5) $(LPROF_USE5)" -C $(BENCHMARK5) clean all

prof6:
	$(MAKE) CC=$(CC6) FLAGS="$(FLAGS6) $(PROF_GEN6)" LD=$(LD6) LFLAGS="$(LFLAGS6) $(LPROF_GEN6)" -C $(BENCHMARK6) all
	$(RUNBENCH) test $(BENCH6) > /dev/null
	$(MAKE) CC=$(CC6) FLAGS="$(FLAGS6) $(PROF_USE6)" LD=$(LD6) LFLAGS="$(LFLAGS6) $(LPROF_USE6)" -C $(BENCHMARK6) clean all

prof7:
	$(MAKE) CC=$(CC7) FLAGS="$(FLAGS7) $(PROF_GEN7)" LD=$(LD7) LFLAGS="$(LFLAGS7) $(LPROF_GEN7)" -C $(BENCHMARK7) all
	$(RUNBENCH) test $(BENCH7) > /dev/null
	$(MAKE) CC=$(CC7) FLAGS="$(FLAGS7) $(PROF_USE7)" LD=$(LD7) LFLAGS="$(LFLAGS7) $(LPROF_USE7)" -C $(BENCHMARK7) clean all

##############################################################################

compile1:
	$(MAKE) CC=$(CC1) FLAGS="$(FLAGS1)" LD=$(LD1) LFLAGS="$(LFLAGS1)" -C $(BENCHMARK1) all

compile2:
	$(MAKE) CC=$(CC2) FLAGS="$(FLAGS2)" LD=$(LD2) LFLAGS="$(LFLAGS2)" -C $(BENCHMARK2) all

compile3:
	$(MAKE) CC=$(CC3) FLAGS="$(FLAGS3)" LD=$(LD3) LFLAGS="$(LFLAGS3)" -C $(BENCHMARK3) all

compile4:
	$(MAKE) CC=$(CC4) FLAGS="$(FLAGS4)" LD=$(LD4) LFLAGS="$(LFLAGS4)" -C $(BENCHMARK4) all

compile5:
	$(MAKE) CC=$(CC5) FLAGS="$(FLAGS5)" LD=$(LD5) LFLAGS="$(LFLAGS5)" -C $(BENCHMARK5) all

compile6:
	$(MAKE) CC=$(CC6) FLAGS="$(FLAGS6)" LD=$(LD6) LFLAGS="$(LFLAGS6)" -C $(BENCHMARK6) all

compile7:
	$(MAKE) CC=$(CC7) FLAGS="$(FLAGS7)" LD=$(LD7) LFLAGS="$(LFLAGS7)" -C $(BENCHMARK7) all

##############################################################################

build:
        ifeq ($(strip $(PROF_GEN1)),)
		$(MAKE) compile1
        else
		$(MAKE) prof1
        endif

        ifeq ($(strip $(PROF_GEN2)),)
		$(MAKE) compile2
        else
		$(MAKE) prof2
        endif

        ifeq ($(strip $(PROF_GEN3)),)
		$(MAKE) compile3
        else
		$(MAKE) prof3
        endif
        ifeq ($(strip $(PROF_GEN4)),)
		$(MAKE) compile4
        else
		$(MAKE) prof4
        endif
        ifeq ($(strip $(PROF_GEN5)),)
		$(MAKE) compile5
        else
		$(MAKE) prof5
        endif
        ifeq ($(strip $(PROF_GEN6)),)
		$(MAKE) compile6
        else
		$(MAKE) prof6
        endif
        ifeq ($(strip $(PROF_GEN7)),)
		$(MAKE) compile7
        else
		$(MAKE) prof7
        endif

##############################################################################

strip:
	strip $(BENCHMARK1)/$(BENCH1)
	strip $(BENCHMARK2)/$(BENCH2)
	strip $(BENCHMARK3)/$(BENCH3)
	strip $(BENCHMARK4)/$(BENCH4)
	strip $(BENCHMARK5)/$(BENCH5)
	strip $(BENCHMARK6)/$(BENCH6)
	strip $(BENCHMARK7)/$(BENCH7)


##############################################################################

util:
	$(MAKE) CC=$(CC) FLAGS="$(COMMON) $(DEBUG)" -C $(UTIL1)
	$(MAKE) CC=$(CC) FLAGS="$(COMMON) $(DEBUG)" -C $(UTIL2)
	$(MAKE) CC=$(CC) FLAGS="$(COMMON) $(DEBUG)" -C $(UTIL3)

utilclean:
	$(MAKE) -C $(UTIL1) clean
	$(MAKE) -C $(UTIL2) clean
	$(MAKE) -C $(UTIL3) clean
	rm -rf $(UTILDIR)/benchdiff $(UTILDIR)/runbenchmark $(UTILDIR)/fbparser

clean:  
	$(MAKE) -C $(BENCHMARK1) clean
	$(MAKE) -C $(BENCHMARK2) clean
	$(MAKE) -C $(BENCHMARK3) clean
	$(MAKE) -C $(BENCHMARK4) clean
	$(MAKE) -C $(BENCHMARK5) clean
	$(MAKE) -C $(BENCHMARK6) clean
	$(MAKE) -C $(BENCHMARK7) clean	
	rm -rf lockfile.apa resultfile.txt *~ core

distclean: clean utilclean

