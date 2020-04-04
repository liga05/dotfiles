#!/usr/local/bin/tcc -run
#include <stdio.h>
#include <string.h>

main() {
   FILE *st, *ca;
   char status[12];
   int capacity;

   st = fopen("/sys/class/power_supply/BAT0/status", "r");
   ca = fopen("/sys/class/power_supply/BAT0/capacity", "r");
   fscanf(st, "%s", &status);
   fscanf(ca, "%i", &capacity);

   if(strcmp(status, "Discharging") == 0) {
	   if(capacity >= 91) { printf("   %i%\n", capacity);}
	   else if(capacity >= 66) { printf("   %i%\n", capacity);}
	   else if(capacity >= 46) { printf("   %i%\n", capacity);}
	   else if(capacity >= 21) { printf("   %i%\n", capacity);}
	   else { printf("   %i%\n", capacity);}
   }
   else if(strcmp(status, "Charging") == 0) {
	   printf("   %i%\n", capacity);}
   else { printf("   %i%\n", capacity);}

   fclose(ca);
   fclose(st);
}
