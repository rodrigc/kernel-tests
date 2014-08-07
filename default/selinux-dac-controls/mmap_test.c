#include <stdlib.h>
#include <stdio.h>
#include <errno.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <unistd.h>


int main(int argc, char *argv[])
{
	int rc;
	void *mem;
	/* Run as nobody, we don't want CAP_SYS_RAWIO */
	setuid(99);
	setgid(99);

	mem = mmap(0x0, 4096,
		   PROT_READ | PROT_WRITE,
		   MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
	if (mem == MAP_FAILED)
		return errno;
	printf("mem = %p\n", mem);
	munmap(mem, 4096);

	return 0;
}
