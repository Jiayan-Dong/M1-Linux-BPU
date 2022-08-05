mispred_test.s: mispred_test.c
	gcc -S mispred_test.c

_mispred_test: perf.c perf.h mispred_test.c
	gcc -no-pie -g -flto -O0 perf.c mispred_test.c -o _mispred_test -pthread

mispred_test: perf.c perf.h mispred_test.s
	gcc -no-pie -g -flto -O3 perf.c mispred_test.s -o mispred_test -pthread
clean:
	rm -r -f mispred_test

mispred_test.dump: mispred_test
	objdump -D mispred_test > mispred_test.dump