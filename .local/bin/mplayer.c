#!/usr/local/bin/tcc -run
#include <stdio.h>
#include <stdlib.h>

main() {
	char cmds[100];
	char cmd[] = "mpv --no-vid --display-tags=no";
	int play;
	
	printf("\t1.Indonesian\n\t2.Not_ID\n\t3.Play all\n\t4.Quit\n");
	printf("Please Choose Playlist : ");
	scanf("%i", &play);
	switch(play) {
		case 1: sprintf(cmds, "%s ~/Music/Indonesian", cmd);
			break;
		case 2: sprintf(cmds, "%s ~/Music/Not_ID", cmd);
			break;
		case 3: sprintf(cmds, "%s ~/Music", cmd);
			break;
		case 4: return 0;
		default:printf("no match found\n"); 
			return 1;
	 }
	system(cmds);
}
