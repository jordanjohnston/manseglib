#!/bin/bash
# setup environment
module load compilers/gcc-4.9.0

export LD_LIBRARY_PATH="/home/jsun/swanModel/jacob/cilk-swan/lib/"  # req. lib
export CILK_NWORKERS=48                                             # no. cpu threads
#export LD_PRELOAD="./bin/interposer_cilk.so"                       # req. for cilk

# note: large graphs should take about ~15 minutes to run
# any longer than that and something has went wrong

PR="PageRankUpdate PageRankUpdate_Floats PageRankManSeg PageRankManSeg_f PageRankUpdate_F2D"

date
make ${PR} -j 48


# use -rounds 10 and -c (no. cores * 16) [trying 48*16 rather than 96*16 for partitioning]
echo ""
for alg in $PR
	do
		echo "start ${alg} twitter_xl"
		date
		LD_PRELOAD="./bin/interposer_cilk.so" ./${alg} -c 768 -v edge -rounds 10 /var/shared/projects/asap/graphs/adj/realworld/recent/twitter_undir_xl > pr_out/twitter_undir_xl_${alg}.txt 2>&1
		date
		echo "finish ${alg} twitter_xl"
		echo ""

		echo "start ${alg} friendster"
		date
		LD_PRELOAD="./bin/interposer_cilk.so" ./${alg} -c 768 -v edge -rounds 10 -b /var/shared/projects/asap/graphs/adj/Galois/friendster_dir_b > pr_out/frienster_dir_b_${alg}.txt 2>&1
		date
		echo "finish ${alg} friendster"
		echo ""

		echo "start ${alg} LiveJournal"
		date
		LD_PRELOAD="./bin/interposer_cilk.so" ./${alg} -c 768 -v edge -rounds 10 -b /var/shared/projects/asap/graphs/adj/Galois/LiveJournal_dir_b > pr_out/LiveJournal_dir_b_${alg}.txt 2>&1
		date
		echo "finish ${alg} LiveJournal"
		echo ""

		echo "start ${alg} orkut"
		date
		LD_PRELOAD="./bin/interposer_cilk.so" ./${alg} -c 768 -v edge -rounds 10 -b /var/shared/projects/asap/graphs/adj/Galois/orkut_undir_b > pr_out/orkut_undir_b_${alg}.txt 2>&1
		date                 
		echo "finish ${alg} orkut"
		echo ""

		echo "start ${alg} USAroad"
		date
		LD_PRELOAD="./bin/interposer_cilk.so" ./${alg} -c 768 -v edge -rounds 10 /var/shared/projects/asap/graphs/adj/realworld/recent/USAroad_undir > pr_out/USAroad_undir_${alg}.txt 2>&1
		date
		echo "finish ${alg} USAroad"
		echo ""

		echo "start ${alg} power 100M"
		date
		LD_PRELOAD="./bin/interposer_cilk.so" ./${alg} -c 768 -v edge -rounds 10 -b /var/shared/projects/asap/graphs/adj/Galois/power_dir_100M_b > pr_out/power_dir_100M_b_${alg}.txt 2>&1
		date
		echo "finish ${alg} power 100M"
		echo ""

		echo "start ${alg} uk union undir"
		date
		LD_PRELOAD="./bin/interposer_cilk.so" ./${alg} -c 768 -v edge -rounds 10 -b /var/shared/projects/asap/graphs/adj/Galois/uk_union_undir_b > pr_out/uk_union_undir_b_${alg}.txt 2>&1
		date
		echo "finish ${alg} uk union undir"
		echo ""

		echo "start ${alg} RMAT27"
		date
		LD_PRELOAD="./bin/interposer_cilk.so" ./${alg} -c 768 -v edge -rounds 10 -b /var/shared/projects/asap/graphs/adj/realworld/recent/RMAT27_dir_b2 > pr_out/RMAT27_dir_b2_${alg}.txt 2>&1
		date
		echo "finish ${alg} RMAT27"
		echo ""
	done
