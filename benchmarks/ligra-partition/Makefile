#define the long 64--bit for large scale graph
INTT = -DLONG 
#INTE = -DEDGELONG

#MACHINE:M
# M=jacob
# HOME = /home/jsun
#cilkview tool using the envirment
#LID= /var/shared/cilktools-4225/include/cilktools
#LID= -I$(HOME)/../../usr/include -I$(HOME)/../../usr/lib64 -L$(HOME)/../../usr/lib64

#compilers
#PCC = icpc
#PCFLAGS = -O3 -DCILKP $(INTT) $(INTE)
#ifdef CILK

#else ifdef MKLROOT
#PCC = icpc
#PCFLAGS = -O3 -DCILKP $(INTT) $(INTE)

#else ifdef OPENMP
#PCC = g++
#PCFLAGS = -fopenmp -O3 -DOPENMP $(INTT) $(INTE)
#endif

#here is the clang for cilk
#else

#ifeq ($USER,"jsun")
# SWANCCDIR=/home/jsun/swanModel/$(M)/llvm-clang/bin
#SWANRTDIR=${HOME}/swanModel/$(M)/cilk-swan
SWANCCDIR=/users/40150688/meng_project/llvm-clang/bin
SWANRTDIR=/users/40150688/meng_project/cilk-swan
#else
#SWANCCDIR=$(HOME)/work/research/llvm/bin
#SWANRTDIR=$(HOME)/work/research/llvm
#endif

CXX = $(SWANCCDIR)/clang++
#PCFLAGS = -fcilkplus -lcilkrts -O3 -DCILK $(INTT) $(INTE) -I $(SWANRTDIR)/include -L $(SWANRTDIR)/lib -ldl
CXXFLAGS = -fcilkplus -lcilkrts -O3 -mavx2 -DCILK $(INTT) $(INTE) -I $(SWANRTDIR)/include -L $(SWANRTDIR)/lib

#PCFLAGS += -I./cilkpub_v105/include
COMMON=papi_code.h utils.h IO.h parallel.h gettime.h quickSort.h parseCommandLine.h mm.h partitioner.h graph-numa.h ligra-numa.h

ALL= BFS BC Components PageRank PageRankDelta BellmanFord SPMV BP PageRank PageRankBit PageRankConverage BPUpdate

PR_Update=PageRankUpdate PageRankUpdate_Floats PageRankUpdate_F2D PageRankManSeg
#csc and coo mix, csc for less partition, coo for more partition, inner threshold is GA.m/2
#HILBERT=0, COO will use COO_CSR. For VEBO graph , COO_CSR is faster choice.
LIBS_I_NEED= -DEDGES_HILBERT=1

all: $(ALL)

pr: $(PR_Update)

#other option
CLIDOPT += -std=c++11
#CACHE collection, if PAPI_CACHE=1 collect and print the values
#CACHEOPT += -lpapi -DPAPI_CACHE=0
# not use atomic for forward and coo 
SEQOPT += -DPART96=0
# NUMA special allocation
NUMAOPT += -DNUMA=1 -lnuma
#REUSE measurement, inital use reuse should not numa allocation
REUSEOPT += -DREUSE_DIST=0
#When using clang:
# OPT += -Wall -Wno-cilk-loop-control-var-modification

% : %.C $(COMMON)
    $(CXX) $(CXXFLAGS) $(CFLAGS) $(NUMAOPT) $(CLIDOPT) $(SEQOPT) $(OPT) $(CACHEOPT) -o $@ $< $(LIBS_I_NEED)

.PHONY : clean

clean :
    rm -f *.o $(ALL)
