mispred_test: perf.c perf.h mispred_test.c
	gcc -no-pie -g -flto -O0 perf.c mispred_test.c -o _mispred_test -pthread
clean:
	rm -r -f mispred_test