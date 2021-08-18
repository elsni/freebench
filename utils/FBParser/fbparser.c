#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>

#define MAXLINE 1000
#define NUM_INTMARKS 4
#define NUM_FLOATMARKS 3
#define NUM_BENCHMARKS (NUM_INTMARKS+NUM_FLOATMARKS)
#define BARLENGTH 500

#define NUM_TOKENS 33
char *pattern[NUM_TOKENS]={"PAR_ANALYZER","PAR_ANALYZER_WIDTH",
			   "PAR_FOURINAROW","PAR_FOURINAROW_WIDTH",
			   "PAR_MASON","PAR_MASON_WIDTH",
			   "PAR_PCOMPRESS2","PAR_PCOMPRESS2_WIDTH",
			   "PAR_PIFFT","PAR_PIFFT_WIDTH",
			   "PAR_DISTRAY","PAR_DISTRAY_WIDTH",
			   "PAR_NEURAL","PAR_NEURAL_WIDTH",
			   "PAR_GMEAN_INT","PAR_GMEAN_INT_WIDTH",
			   "PAR_GMEAN_FLOAT","PAR_GMEAN_FLOAT_WIDTH",
			   "PAR_GMEAN_ALL","PAR_GMEAN_ALL_WIDTH",
			   "PAR_NAME","PAR_MAIL",
			   "PAR_SYSTEM","PAR_OS",
			   "PAR_COMPUTER","PAR_COMPILER",
			   "PAR_FLAGS_ANALYZER","PAR_FLAGS_FOURINAROW",
			   "PAR_FLAGS_MASON","PAR_FLAGS_PCOMPRESS2",
			   "PAR_FLAGS_PIFFT","PAR_FLAGS_DISTRAY",
			   "PAR_FLAGS_NEURAL"};
char data[NUM_TOKENS][MAXLINE+1];
#define FLAG_OFFSET 26

#define NAME 20
#define MAIL 21
#define SYSTEM 22
#define OS 23
#define COMPUTER 24
#define COMPILER 25


int main(int argc, char **argv)
{
  FILE *config, *mall;
  int count=0, err, i, ref=0;
  float elapsed_time[NUM_BENCHMARKS];
  float score[NUM_BENCHMARKS];
  char tmp_line[MAXLINE+1];char copy_line[MAXLINE+1];
  char *line;

  float gmean_i=1.0f, gmean_f=1.0f, gmean=1.0f; /* Mean values for int, float, and all benchmarks. */

  if (argc!=2) {
    fprintf (stderr, "ERROR: You must specify if this is a 'test' or a 'ref' run\n"); exit(1);
  }
    
  if (!strcmp(argv[1],"ref")) /* This is a reference run */
    ref=1;

  if (ref!=1) {
    /* line = fgets(tmp_line, MAXLINE, stdin);
       while (line!=NULL) {
       printf("%s", tmp_line);
       line = fgets(tmp_line, MAXLINE, stdin);
       } */
    return 0; /* Do not produce a result file if it is a testrun */
  }
  
  line = fgets(tmp_line, MAXLINE, stdin);
  while (line!=NULL) {
    if (tmp_line[0]=='-') {
      fprintf(stderr,"ALERT: The benchmark output comtains errors. A result file will not be generated.\n");
      exit(1);
    }
    if (strstr(tmp_line, "Compiler")!=NULL) {
      /* New benchmark result */
      while(*line!=':') line++; line++; while(*line==' ') line++;
      strncpy(data[count+FLAG_OFFSET], strtok(line,"\n"), MAXLINE);
      line = fgets(tmp_line, MAXLINE, stdin);
      if (line!=NULL) err = sscanf(tmp_line, "Elapsed time: %f seconds", &elapsed_time[count]);
      if (line==NULL || err==EOF) { fprintf (stderr, "ERROR: Unable to parse result file, elapsed time not found for benchmark %d.\n", count); exit(1); }
      line = fgets(tmp_line, MAXLINE, stdin);
      if (line!=NULL) err = sscanf(tmp_line, "Score: %f times a Sun Ultra 10", &score[count]);
      if (line==NULL || err==EOF) { fprintf (stderr, "ERROR: Unable to parse result file, elapsed time not found for benchmark %d.\n", count); exit(1); }
      /* printf("%s: Time: %f, Score: %f\n",ref?"REF":"TEST", elapsed_time[count], score[count]); */
      count++;
    }
    line = fgets(tmp_line, MAXLINE, stdin);
  }

  if (count==NUM_BENCHMARKS) { /* Check to make sure we found all benchmark scores */

    /* Calculate geometric means */
    for (i=0; i<NUM_INTMARKS; i++) {
      gmean_i *= score[i];
      gmean *= score[i];
    }
    for (; i<NUM_BENCHMARKS; i++) {
      gmean_f *= score[i];
      gmean *= score[i];
    }
    gmean_i = (float)exp(log(gmean_i)/(double)NUM_INTMARKS);
    gmean_f = (float)exp(log(gmean_f)/(double)NUM_FLOATMARKS);
    gmean = (float)exp(log(gmean)/(double)NUM_BENCHMARKS);

    for (i=0; i<NUM_BENCHMARKS;) { /* Fill in data[][] */
      sprintf(data[2*i],"%3.3f",score[i]); /* Value */
      sprintf(data[2*i+1],"%d",(int)(score[i]*BARLENGTH/10)); /* Bar length */
      i++;
    }
    
    sprintf(data[2*i],"%3.3f",gmean_i); /* Value - gmean_int */
    sprintf(data[2*i+1],"%d",(int)(gmean_i*BARLENGTH/10)); /* Bar length - gmean_int */
    i++;
    sprintf(data[2*i],"%3.3f",gmean_f); /* Value - gmean_float */
    sprintf(data[2*i+1],"%d",(int)(gmean_f*BARLENGTH/10)); /* Bar length - gmean_float */
    i++;
    sprintf(data[2*i],"%3.3f",gmean); /* Value - gmean_all */
    sprintf(data[2*i+1],"%d",(int)(gmean*BARLENGTH/10)); /* Bar length - gmean_all */
    i++;

    config=fopen("machine_config.cfg","r");
    if (config==NULL) {
      fprintf(stderr,"ERROR: Unable to open configuration file 'machine_config.cfg'.\n");
      exit(1);
    }
    
    line = fgets(tmp_line, MAXLINE, config);
    while (line!=NULL) {
      if (strstr(tmp_line, "NAME")!=NULL) {
	while(*line!='=') line++; line++; while(*line==' ') line++;
	strncpy(data[NAME], strtok(line,"\n"), MAXLINE);
      }
      if (strstr(tmp_line, "MAIL")!=NULL) {
	while(*line!='=') line++; line++; while(*line==' ') line++;
	strncpy(data[MAIL], strtok(line,"\n"), MAXLINE);
      }
      if (strstr(tmp_line, "COMPUTER")!=NULL) {
	while(*line!='=') line++; line++; while(*line==' ') line++;
	strncpy(data[COMPUTER], strtok(line,"\n"), MAXLINE);
      }
      if (strstr(tmp_line, "SYSTEM")!=NULL) {
	while(*line!='=') line++; line++; while(*line==' ') line++;
	strncpy(data[SYSTEM], strtok(line,"\n"), MAXLINE);
      }
      if (strstr(tmp_line, "OS")!=NULL) {
	while(*line!='=') line++; line++; while(*line==' ') line++;
	strncpy(data[OS], strtok(line,"\n"), MAXLINE);
      }
      if (strstr(tmp_line, "COMPILER")!=NULL) {
	while(*line!='=') line++; line++; while(*line==' ') line++;
	strncpy(data[COMPILER], strtok(line,"\n"), MAXLINE);
      }
      line = fgets(tmp_line, MAXLINE, config);
    }
    fclose(config);

    /* Parse template file and substitute all PAR_* for real data. */
      
    mall=fopen("./utils/FBParser/fbtemplate.html","r");
    if (mall==NULL) {
      fprintf(stderr,"ERROR: Unable to open configuration file './utils/FBParser/fbtemplate.html'.\n");
      exit(1);
    }
    
    line = fgets(tmp_line, MAXLINE, mall); strncpy(copy_line, tmp_line, MAXLINE);
    while (line!=NULL) {
      strtok(tmp_line," ");
      strtok(tmp_line,"\n");
      for (i=0;i<NUM_TOKENS;i++) {
	if (!strcmp(tmp_line, pattern[i])) {
	  printf("%s\n", data[i]);
	  goto next;
	} 
      }
      printf("%s", copy_line);
    next:
      line = fgets(tmp_line, MAXLINE, mall); strncpy(copy_line, tmp_line, MAXLINE);
    }
    fclose(mall);

  }
  else
    fprintf (stderr, "ERROR: Unable to parse result file, found %d out of %d benchmark results!\n", count, NUM_BENCHMARKS);

  return 0;
}




