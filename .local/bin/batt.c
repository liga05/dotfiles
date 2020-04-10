#!/usr/local/bin/tcc -run
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

main() {
   FILE *st, *ca;
   char sta[12];
   int cap, stat;

   st = fopen("/sys/class/power_supply/BAT0/status", "r");
   ca = fopen("/sys/class/power_supply/BAT0/capacity", "r");
   fscanf(st, "%s", &sta);
   fscanf(ca, "%i", &cap);
   stat = strcmp(sta, "Discharging");

   if(stat == 0) {
	   if(cap >= 91) { printf("   %i%\n", cap);}
	   else if(cap >= 66) { printf("   %i%\n", cap);}
	   else if(cap >= 46) { printf("   %i%\n", cap);}
	   else if(cap >= 21) { printf("   %i%\n", cap);}
	   else if(cap >= 19) { printf("   %i%\n", cap);
	   			     system("prompt \"battery low! suspend computer?\" \"sudo zzz\"");}
	   else { printf("   %i%\n", cap);
	   	  system("sudo zzz >/dev/null");}
   }
   else if(stat < 0) {
	   printf("   %i%\n", cap);}
   else { printf("   %i%\n", cap);}

   fclose(ca);
   fclose(st);
}
