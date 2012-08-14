#include <stdio.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/time.h>

unsigned long do_time(unsigned long usecs)
{
        struct timeval after, before;
        int secs, usec;
        gettimeofday(&before, NULL);
        usleep(usecs);
        gettimeofday(&after, NULL);
        secs = after.tv_sec - before.tv_sec;
        usec = after.tv_usec - before.tv_usec;
        return secs * 1000000 + usec;
}

int main(void)
{
        unsigned long delays = 0;
        int i;
        /* take the average over 100 measurements */
        for (i = 0; i < 100; i++)
                delays += do_time(1000);
        delays = delays / 100;

        /* we asked for a 1.000 msec delay, if this takes more than 2.5 msec that's  an unacceptable. */
        if (delays > 2500) {
                printf("Unacceptable long delay; asked for 1000 usec, got %li usec \n", delays);
                exit(EXIT_FAILURE);
        }

        delays = 0;
        for (i = 0; i < 100; i++)
                delays += do_time(2000);
        delays = delays / 100;
//        printf("%li -> %li \n", 2000, delays);

        /* we asked for a 2.000 msec delay, if this takes more than 3.5 msec that's unacceptable. */
        if (delays > 3500) {
                printf("Unacceptable long delay; asked for 2000 usec, got %li usec \n", delays);
                exit(EXIT_FAILURE);
        }
        exit(EXIT_SUCCESS);
}

