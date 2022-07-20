mispred_test: perf.c perf.h mispred_test.c
	gcc -g -flto -O0 perf.c mispred_test.c -o mispred_test
clean:
	rm -r -f mispred_test