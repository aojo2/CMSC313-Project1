/*
 * hexdump.c
 * CMSC 313 Project 3 - Optimization Comparison
 * Tony
 *
 * Reads bytes from stdin and prints them out as a hex dump:
 *   - left column:  byte offset (8 hex digits)
 *   - middle:       16 bytes in hex, space separated
 *   - right:        the same bytes as ASCII, with '.' for non-printables
 *
 * Run it like:  ./hexdump < binary.out
 */

#include <stdio.h>

#define LINE 16  /* bytes printed per line */

int main(void)
{
    unsigned char buf[LINE];
    unsigned long offset = 0;
    size_t n;
    int i;

    /* grab up to 16 bytes at a time until we hit EOF */
    while ((n = fread(buf, 1, LINE, stdin)) > 0) {

        /* left column - the address */
        printf("%08lx ", offset);

        /* middle column - the hex bytes
         * if the last line is short, pad with spaces so the
         * ascii column still lines up */
        for (i = 0; i < LINE; i++) {
            if ((size_t)i < n)
                printf("%02x ", buf[i]);
            else
                printf("   ");
        }

        /* right column - the ascii view
         * standard ASCII printable range is 0x20 thru 0x7E
         * (from class notes on computer codes / character storage) */
        printf("|");
        for (i = 0; (size_t)i < n; i++) {
            if (buf[i] >= 0x20 && buf[i] <= 0x7E)
                putchar(buf[i]);
            else
                putchar('.');
        }
        printf("|\n");

        offset += n;
    }

    return 0;
}
