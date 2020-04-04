#!/usr/local/bin/tcc -run
#include <stdio.h>

main(int argc, char *argv[]) {
    FILE *br;
    int val;

    br = fopen("/sys/class/backlight/intel_backlight/brightness", "w+");
    fscanf(br, "%i", &val);
    
    size_t opt;
    for(opt = 1; opt < argc && argv[opt][0] == '-'; opt++) {
	    switch(argv[opt][1]) {
		case 'u':
			if((val <= 450) && (val >= 405)) {
				fprintf(br, "%i", 450);}
			else if(val <= 405) {
				fprintf(br, "%i", val += 45);}
			break;
		case 'd':
			fprintf(br, "%i", val -= 45);
			break;
		default : printf("Usage: bright [-u/-d]");}
    }
    fclose(br);
}
