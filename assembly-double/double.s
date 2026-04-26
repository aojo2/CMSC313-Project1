# double.s
# CMSC 313 Project 2
# Reads an integer from argv[1], doubles it, prints "The double is: <n>"
# GAS / AT&T syntax, x86 32-bit, Linux int 0x80 syscalls (no libc).

.section .data
usage:      .ascii "Usage: ./double <integer>\n"
            usage_len = . - usage
prefix:     .ascii "The double is: "
            prefix_len = . - prefix
nl:         .ascii "\n"

.section .bss
.lcomm buf, 16

.section .text
.globl _start

_start:
    movl    (%esp), %eax        # argc
    cmpl    $2, %eax
    jl      do_usage

    movl    8(%esp), %esi       # argv[1]
    call    atoi                # eax = number

    addl    %eax, %eax          # double it

    call    itoa                # ecx = ptr, edx = length
    pushl   %edx
    pushl   %ecx

    # write "The double is: "
    movl    $4, %eax
    movl    $1, %ebx
    movl    $prefix, %ecx
    movl    $prefix_len, %edx
    int     $0x80

    # write the number
    popl    %ecx
    popl    %edx
    movl    $4, %eax
    movl    $1, %ebx
    int     $0x80

    # write "\n"
    movl    $4, %eax
    movl    $1, %ebx
    movl    $nl, %ecx
    movl    $1, %edx
    int     $0x80

    # exit 0
    movl    $1, %eax
    xorl    %ebx, %ebx
    int     $0x80

do_usage:
    movl    $4, %eax
    movl    $1, %ebx
    movl    $usage, %ecx
    movl    $usage_len, %edx
    int     $0x80
    movl    $1, %eax
    movl    $1, %ebx
    int     $0x80


# atoi: esi -> string, returns int in eax
atoi:
    xorl    %eax, %eax          # result
    xorl    %ecx, %ecx          # neg flag

    movb    (%esi), %bl
    cmpb    $'-', %bl
    jne     atoi_loop
    movl    $1, %ecx
    incl    %esi

atoi_loop:
    movb    (%esi), %bl
    testb   %bl, %bl
    jz      atoi_end
    cmpb    $'0', %bl
    jl      atoi_end
    cmpb    $'9', %bl
    jg      atoi_end

    imull   $10, %eax
    subb    $'0', %bl
    movzbl  %bl, %ebx
    addl    %ebx, %eax
    incl    %esi
    jmp     atoi_loop

atoi_end:
    testl   %ecx, %ecx
    jz      atoi_ret
    negl    %eax
atoi_ret:
    ret


# itoa: eax = number, returns ecx = ptr, edx = length (in buf)
itoa:
    xorl    %edi, %edi          # neg flag
    testl   %eax, %eax
    jns     itoa_pos
    movl    $1, %edi
    negl    %eax
itoa_pos:
    leal    buf+16, %ecx

    testl   %eax, %eax
    jnz     itoa_loop
    decl    %ecx                # special case: 0
    movb    $'0', (%ecx)
    jmp     itoa_sign

itoa_loop:
    testl   %eax, %eax
    jz      itoa_sign
    xorl    %edx, %edx
    movl    $10, %ebx
    divl    %ebx                # eax /= 10, edx = remainder
    addb    $'0', %dl
    decl    %ecx
    movb    %dl, (%ecx)
    jmp     itoa_loop

itoa_sign:
    testl   %edi, %edi
    jz      itoa_done
    decl    %ecx
    movb    $'-', (%ecx)

itoa_done:
    leal    buf+16, %edx
    subl    %ecx, %edx
    ret
