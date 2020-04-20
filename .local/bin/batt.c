#!/usr/local/bin/tcc -run
#include <stdio.h>
extern int system(const char *__command) __wur;

main() {
   FILE *st, *ca;
   int cap, sts;

   st = fopen("/sys/class/power_supply/BAT0/status", "r");
   ca = fopen("/sys/class/power_supply/BAT0/capacity", "r");
   sts = fgetc(st);
   fscanf(ca, "%d", &cap);

   if(sts == 0x44) {
	   if(cap >= 91) { printf("   %d%\n", cap);}
	   else if(cap >= 66) { printf("   %d%\n", cap);}
	   else if(cap >= 46) { printf("   %d%\n", cap);}
	   else if(cap >= 21) { printf("   %d%\n", cap);}
	   else if(cap >= 19) { printf("   %d%\n", cap);
	   			system("prompt batt");}
	   else { printf("   %d%\n", cap);
	   	  system("prompt sleep");}
   }
   else if(sts == 0x43) {
	   printf("   %d%\n", cap);}
   else { printf("   %d%\n", cap);}

   fclose(ca);
   fclose(st);
}
