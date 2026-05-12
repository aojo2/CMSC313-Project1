	.file	"hexdump.c"
	.text
	.section	.rodata
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
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$64, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movq	$0, -48(%rbp)
	jmp	.L2
.L11:
	movq	-48(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC0(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, -52(%rbp)
	jmp	.L3
.L6:
	movl	-52(%rbp), %eax
	cltq
	cmpq	-40(%rbp), %rax
	jnb	.L4
	movl	-52(%rbp), %eax
	cltq
	movzbl	-32(%rbp,%rax), %eax
	movzbl	%al, %eax
	movl	%eax, %esi
	leaq	.LC1(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L5
.L4:
	leaq	.LC2(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
.L5:
	addl	$1, -52(%rbp)
.L3:
	cmpl	$15, -52(%rbp)
	jle	.L6
	movl	$124, %edi
	call	putchar@PLT
	movl	$0, -52(%rbp)
	jmp	.L7
.L10:
	movl	-52(%rbp), %eax
	cltq
	movzbl	-32(%rbp,%rax), %eax
	cmpb	$31, %al
	jbe	.L8
	movl	-52(%rbp), %eax
	cltq
	movzbl	-32(%rbp,%rax), %eax
	cmpb	$126, %al
	ja	.L8
	movl	-52(%rbp), %eax
	cltq
	movzbl	-32(%rbp,%rax), %eax
	movzbl	%al, %eax
	movl	%eax, %edi
	call	putchar@PLT
	jmp	.L9
.L8:
	movl	$46, %edi
	call	putchar@PLT
.L9:
	addl	$1, -52(%rbp)
.L7:
	movl	-52(%rbp), %eax
	cltq
	cmpq	-40(%rbp), %rax
	jb	.L10
	leaq	.LC3(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	movq	-40(%rbp), %rax
	addq	%rax, -48(%rbp)
.L2:
	movq	stdin(%rip), %rdx
	leaq	-32(%rbp), %rax
	movq	%rdx, %rcx
	movl	$16, %edx
	movl	$1, %esi
	movq	%rax, %rdi
	call	fread@PLT
	movq	%rax, -40(%rbp)
	cmpq	$0, -40(%rbp)
	jne	.L11
	movl	$0, %eax
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L13
	call	__stack_chk_fail@PLT
.L13:
	leave
	ret
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
