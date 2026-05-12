	.file	"hexdump.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%08lx "
.LC1:
	.string	"%02x "
.LC2:
	.string	"   "
.LC3:
	.string	"|"
	.text
	.globl	main
	.type	main, @function
main:
	endbr64
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbp
	pushq	%rbx
	subq	$40, %rsp
	movq	%fs:40, %rax
	movq	%rax, 24(%rsp)
	xorl	%eax, %eax
	movl	$0, %r14d
	leaq	.LC2(%rip), %r13
	leaq	.LC1(%rip), %r12
	jmp	.L2
.L3:
	movq	%r13, %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
.L4:
	addq	$1, %rbx
	cmpq	$16, %rbx
	je	.L14
.L5:
	cmpq	%rbp, %rbx
	jnb	.L3
	movzbl	(%rbx,%r15), %edx
	movq	%r12, %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	jmp	.L4
.L14:
	movl	$124, %edi
	call	putchar@PLT
	movq	%rsp, %rbx
	leaq	0(%rbp,%rbx), %r15
	jmp	.L8
.L6:
	movq	stdout(%rip), %rsi
	movl	$46, %edi
	call	putc@PLT
.L7:
	addq	$1, %rbx
	cmpq	%r15, %rbx
	je	.L15
.L8:
	movzbl	(%rbx), %edi
	leal	-32(%rdi), %eax
	cmpb	$94, %al
	ja	.L6
	movzbl	%dil, %edi
	movq	stdout(%rip), %rsi
	call	putc@PLT
	jmp	.L7
.L15:
	leaq	.LC3(%rip), %rdi
	call	puts@PLT
	addq	%rbp, %r14
.L2:
	movq	%rsp, %rdi
	movq	stdin(%rip), %rcx
	movl	$16, %edx
	movl	$1, %esi
	call	fread@PLT
	movq	%rax, %rbp
	testq	%rax, %rax
	je	.L16
	movq	%r14, %rdx
	leaq	.LC0(%rip), %rsi
	movl	$2, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	movl	$0, %ebx
	movq	%rsp, %r15
	jmp	.L5
.L16:
	movq	24(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L17
	movl	$0, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rbp
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	ret
.L17:
	call	__stack_chk_fail@PLT
	.size	main, .-main
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
