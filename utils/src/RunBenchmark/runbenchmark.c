#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

/* #define DEBUG */

typedef enum { START,
    STOP } token_t;

double current_time()
{
    struct timeval tp;
    gettimeofday(&tp, NULL);
    return ((double)tp.tv_sec + (double)tp.tv_usec * 1.e-6);
}

double elapsedtime(token_t token)
{
    static int started = 0;
    static double start_time = 0;
    double elapsed_time = 0;

    if (token == START) {
        started = 1;
        start_time = current_time();
        return 0;
    } else if (token == STOP) {
        if (started != 1) {
            fprintf(stderr, "ERROR: Timer not started.\n");
            exit(1);
        }
        elapsed_time = current_time() - start_time;
        return elapsed_time;
    } else {
        fprintf(stderr, "ERROR: Unknown token.\n");
        exit(1);
    }
}

int main(int c, char* v[])
{
    FILE* fp1;
    pid_t pid;
    int status;
    char scorefile[100];
    char benchmarkfile[100];
    char datafile[100];
    char ref_machine[100];
    float ref_time;
    float elapsed_time;

    if (c != 3) {
        fprintf(stderr, "USAGE: %s <ref | test> <benchmark program>\n", v[0]);
        exit(1);
    }

    sprintf(scorefile, "./benchmarks/%s/data/score/%s.score", v[2], v[1]);

#ifdef DEBUG
    fprintf(stderr, "DEBUG: Opening file - %s\n", scorefile);
#endif

    fp1 = fopen(scorefile, "r");
    if (!fp1) {
        fprintf(stderr, "ERROR: Could not open the score file.\n");
        exit(1);
    }

    if(fgets(ref_machine, 99, fp1)){};
    if(fscanf(fp1, "%f", &ref_time)){};
    fclose(fp1);

    sprintf(benchmarkfile, "./benchmarks/%s/%s", v[2], v[2]);
    sprintf(datafile, "./benchmarks/%s/data/in/%s.in", v[2], v[1]);

    /* Lock file... */
    fp1 = fopen("lockfile.apa", "r");
    if (fp1) {
        fprintf(stderr, "ERROR:\tLockfile found. You can only have one instance of\n\tFreebench running in a directory.\n");
        exit(1);
    }
    fp1 = fopen("lockfile.apa", "w");
    fprintf(fp1, "This FreeBench directory is busy. If that is not the case, you can delete this file\n");
    fflush(fp1);
    fclose(fp1);

#ifdef DEBUG
    fprintf(stderr, "DEBUG: Running program - %s %s\n", benchmarkfile, datafile);
#endif

    pid = fork();
    if (pid == 0) {
        if (execl(benchmarkfile, benchmarkfile, datafile, NULL)) {
            fprintf(stderr, "ERROR: Could not launch benchmark - %s\n", v[2]);
        }
    } else {

#ifdef DEBUG
        fprintf(stderr, "DEBUG: Running %s in PID: %d\n", v[2], pid);
#endif

        elapsedtime(START);
        waitpid(pid, &status, 0);
        if (status != 0) {
            fprintf(stderr, "ERROR: Something went wrong during the run\n");
            exit(1);
        }
        elapsed_time = (float)elapsedtime(STOP);

        fprintf(stderr, "Elapsed time: %f seconds\n", elapsed_time);
        fprintf(stderr, "Score: %f times a %s", ref_time / elapsed_time, ref_machine);
    }

    remove("lockfile.apa");
    return 0;
}
