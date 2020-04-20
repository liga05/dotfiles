#!/usr/local/bin/tcc -run
#include <stdio.h>
extern int chdir(const char *__path) __THROW __nonnull((1)) __wur;
extern int execvp(const char *__file, char *const __argv[]) __THROW __nonnull((1, 2));

main() {
	char *cmd = "mpv";
	char *argv[5];
	argv[0] = cmd;
	argv[1] = "--no-vid";
	argv[2] = "--display-tags=no";
	int play;

	chdir("/home/agil");
	puts("\t1.Indonesian\n\t2.Not_ID\n\t3.Play all\n\t4.Quit");
	printf(" Please Choose Playlist : ");
	scanf("%d", &play);
	switch(play) {
		case 1: argv[3] = "Music/Indonesian";
			break;
		case 2: argv[3] = "Music/Not_ID";
			break;
		case 3: argv[3] = "Music";
			break;
		case 4: return 0;
		default:puts("no match found"); 
			return 1;
	 }
	argv[4] = NULL;
	execvp(cmd, argv);
}
