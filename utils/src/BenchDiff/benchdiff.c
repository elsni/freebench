#include <stdio.h>
#include <stdlib.h>
#include <strings.h>

void tryfile2(int c, char *v[]);

void error()
{
  fprintf(stdout,"--- WARNING ---\nThe output and the control file differ.\n");
  fprintf(stdout,"Your binary is producing faulty results.\n");
  fprintf(stdout,"This means that the benchmark score given is most likely wrong.\n");
  fprintf(stdout,"--- END WARNING ---\n");
  fprintf(stderr,"--- WARNING ---\nThe output and the control file differ.\n");
  fprintf(stderr,"Your binary is producing faulty results.\n");
  fprintf(stderr,"This means that the benchmark score given is most likely wrong.\n");
  fprintf(stderr,"--- END WARNING ---\n");
  exit(1);
}

void tryfile2(int c, char *v[])
{
  FILE *fp1,*fp2;
  char newname[100];
  
  strcpy(newname, v[2]);
  strcat(newname,"2");

  fp1=fopen(v[1],"r");
  fp2=fopen(newname,"r");
  
  if (!fp1 || !fp2) {
    error();
  }
  
  while (!feof(fp1) && !feof(fp2)) {
    if (fgetc(fp1)!=fgetc(fp2)) {
      error();
    }  
  }
  if ((!feof(fp1) && feof(fp2)) || (feof(fp1) && !feof(fp2))) {
    error();
  }
}

int main (int c, char *v[])
{
  FILE *fp1,*fp2;

  if (c!=3) {
    fprintf(stdout,"USAGE: %s file1 file2\n",v[0]);
    exit(1);
  }
    
  fp1=fopen(v[1],"r");
  fp2=fopen(v[2],"r");
  if (!fp1 || !fp2) {
    fprintf(stdout,"ERROR: Could not open one of the in files.\n");
    exit(1);
  }
  
  while (!feof(fp1) && !feof(fp2)) {
    if (fgetc(fp1)!=fgetc(fp2)) {
      fclose(fp1);
      fclose(fp2);
      tryfile2(c,v);
    }  
  }
  if ((!feof(fp1) && feof(fp2)) || (feof(fp1) && !feof(fp2))) {
    fclose(fp1);
    fclose(fp2);
    tryfile2(c,v);
  }
  return 0;
}
