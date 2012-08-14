CFLAGS = -Wall -W -g -O2 -Wimplicit -D_FORTIFY_SOURCE=2

all: timer-test

timer-test: timer-test.o

%.o : %.c
	@$(CC) $(CFLAGS) -c $<

clean:
	@rm -f *.o timer-test
