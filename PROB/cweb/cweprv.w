@i ../include/include.w

@ Just to probe another file.

@(cweprv.h@>=
#include <stdio.h>
#include <stdlib.h>
#include "eprv.h"

@ The main program\dots
@c
#include "cweprv.h"

int
main(int argc, char **argv)
{
	dummy();	/* library function */
	fprintf(stderr, "In cweprv\n");
	exit(EXIT_SUCCESS);
}

