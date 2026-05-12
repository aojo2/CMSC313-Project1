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
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
	endbr64
	pushq	%r15
	pushq	%r14
	leaq	.LC2(%rip), %r14
	pushq	%r13
	leaq	.LC1(%rip), %r13
	pushq	%r12
	pushq	%rbp
	pushq	%rbx
	subq	$56, %rsp
	movq	%fs:40, %rax
	movq	%rax, 40(%rsp)
	xorl	%eax, %eax
	leaq	16(%rsp), %rbp
	movq	$0, 8(%rsp)
	.p2align 4,,10
	.p2align 3
.L2:
	movq	stdin(%rip), %rcx
	movl	$16, %edx
	movl	$1, %esi
	movq	%rbp, %rdi
	call	fread@PLT
	movq	%rax, %rbx
	testq	%rax, %rax
	je	.L16
	movq	8(%rsp), %rdx
	movl	$2, %edi
	xorl	%eax, %eax
	xorl	%r12d, %r12d
	leaq	.LC0(%rip), %rsi
	call	__printf_chk@PLT
	jmp	.L5
	.p2align 4,,10
	.p2align 3
.L18:
	movzbl	0(%rbp,%r12), %edx
	movq	%r13, %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	addq	$1, %r12
	call	__printf_chk@PLT
	cmpq	$16, %r12
	je	.L17
.L5:
	cmpq	%rbx, %r12
	jb	.L18
	movq	%r14, %rsi
	movl	$2, %edi
	xorl	%eax, %eax
	addq	$1, %r12
	call	__printf_chk@PLT
	cmpq	$16, %r12
	jne	.L5
.L17:
	movl	$124, %edi
	movq	%rbp, %r15
	leaq	0(%rbp,%rbx), %r12
	call	putchar@PLT
	.p2align 4,,10
	.p2align 3
.L8:
	movzbl	(%r15), %edi
	movq	stdout(%rip), %rsi
	leal	-32(%rdi), %eax
	cmpb	$94, %al
	jbe	.L14
	movl	$46, %edi
.L14:
	call	putc@PLT
	addq	$1, %r15
	cmpq	%r12, %r15
	jne	.L8
	leaq	.LC3(%rip), %rdi
	call	puts@PLT
	addq	%rbx, 8(%rsp)
	jmp	.L2
.L16:
	movq	40(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L19
	addq	$56, %rsp
	xorl	%eax, %eax
	popq	%rbx
	popq	%rbp
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	ret
.L19:
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
