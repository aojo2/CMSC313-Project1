# CMSC 313 Project 3 - Makefile
# Tony

CC      = gcc
CFLAGS  = -Wall -Wextra -fno-asynchronous-unwind-tables
SRC     = hexdump.c

EXES = hexdump_O0 hexdump_O1 hexdump_O3
ASMS = hexdump_O0.s hexdump_O1.s hexdump_O3.s

.PHONY: all clean check

all: $(EXES) $(ASMS)

hexdump_O0: $(SRC)
	$(CC) $(CFLAGS) -O0 -o $@ $<
hexdump_O1: $(SRC)
	$(CC) $(CFLAGS) -O1 -o $@ $<
hexdump_O3: $(SRC)
	$(CC) $(CFLAGS) -O3 -o $@ $<

hexdump_O0.s: $(SRC)
	$(CC) $(CFLAGS) -O0 -S $< -o $@
hexdump_O1.s: $(SRC)
	$(CC) $(CFLAGS) -O1 -S $< -o $@
hexdump_O3.s: $(SRC)
	$(CC) $(CFLAGS) -O3 -S $< -o $@

# sanity check - all three should produce identical output
check: all
	./hexdump_O0 < binary.out > .o0
	./hexdump_O1 < binary.out > .o1
	./hexdump_O3 < binary.out > .o3
	diff .o0 .o1 && diff .o0 .o3 && echo "OK - all three match"
	rm -f .o0 .o1 .o3

clean:
	rm -f $(EXES) $(ASMS) .o0 .o1 .o3
