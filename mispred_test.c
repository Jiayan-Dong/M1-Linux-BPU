#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/stat.h>
#include <errno.h>

#include <sys/mman.h>

#include <linux/memfd.h>
#include <linux/mman.h>

#include <sched.h>

#include <string.h>

#include "perf.h"

#define ARR_SIZE 2000
#define RAND_SIZE 1000
int a[ARR_SIZE];

__attribute__((__noinline__)) void *get_pc() { return __builtin_return_address(0); }

void genRand()
{
    srand(time(NULL));
    for (int i = 0; i < ARR_SIZE; ++i)
        a[i] = rand() % 2;
}

int main()
{
    int cpu_number = 7;

    /* [2] Setaffinity */
    {
        cpu_set_t set;
        CPU_ZERO(&set);
        CPU_SET(cpu_number, &set);
        int r = sched_setaffinity(0, sizeof(set), &set);
        if (r == -1)
        {
            perror("sched_setaffinity([0])");
            exit(-1);
        }
    }

    /* Attempt to clear BTB */
    {
        int r = system("python3 -c 'import math'");
        (void)r;
    }

    struct perf perf;
    memset(&perf, 0, sizeof(struct perf));
    if (1)
    {
        perf_open(&perf);
    }
    uint64_t x = 0;
    uint64_t y = 0;
    uint64_t z = 0;
    int temp;
    int kk = 0;
    int j;
    void *loop_begin1;
    void *loop_begin2;
    int abc;

    loop_begin1 = get_pc();
    abc = 114; //
    uint64_t numbers[RAND_SIZE][4] = {{0}};
    j = 0;
    loop_begin2 = get_pc();
    abc = 514; //
    z = 0;
    genRand();
    x = 0;
    perf_start(&perf);

    z = 111;
    temp = a[j];
    if (temp)
        ++x;

    z = 222;

    if (x)
        ++y;

    perf_stop(&perf, &numbers[j][0]);

    ++j;
    if (j < RAND_SIZE)
    {
        abc = 514;
    }

    // double cy = 0;
    // double in = 0;
    double mi = 0;
    // double br = 0;
    for (j = 0; j < RAND_SIZE; j++)
    {
        // double cycles = numbers[j][0] * 1.0; // cycles has a base number around 70.0
        // double instructions = numbers[j][1] * 1.0; // instructions has a base number around 36.0
        double missed_branches = numbers[j][2] * 1.0; // missed_branches has a base number around 2.0
        // double branches = numbers[j][3] * 1.0; // branches has a base number around 6.0

        // cy += cycles;
        // in += instructions;
        mi += missed_branches;
        // br += branches;
    }
    printf("%5.3f\n", mi / RAND_SIZE);
    // printf("%5.3f  %5.3f  %5.3f  %5.3f\n", cy / RAND_SIZE, in / RAND_SIZE, mi / RAND_SIZE, br / RAND_SIZE);
    ++kk;
    if (kk < 20)
    {
        abc = 114;
    }

    return 0;
}