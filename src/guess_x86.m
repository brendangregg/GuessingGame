#
# guess_x86.m - guessing game in x86 assembly (with m4 preprocessor)
#
# This is written to demonstrate this language versus the same program
# written in other languages.
#
# COMPILE:
#	m4 < guess_x86.m > guess.s
#	gcc -o guess guess.s
#
# 14-May-2006  Brendan Gregg   Created this.
#

define(PRINTF, `
	pushl	$1
	call	printf
	addl	$ 4, %esp ')
define(PRINTF_NUM, `
	pushl	$2
	pushl	$1
	call	printf
	addl	$ 8, %esp ')
define(FPRINTF_ERR_STR, `
	pushl	$2
	pushl	$1
	pushl	$__iob+32
	call	fprintf
	addl	$ 12, %esp ')
define(FGETS_STR, `
	pushl	$__iob
	pushl	$bufsize_l
	pushl	$1
	call	fgets
	addl	$ 12, %esp ')

	.section	".rodata"
greet_s:    .string	"guess_x86 - Guess a number between 1 and 100\n\n"
entry1_s:   .string	"Enter guess %d: "
higher_s:   .string	"Higher...\n"
lower_s:    .string	"Lower...\n"
correct_s:  .string	"Correct! That took %d guesses.\n\n"
entry2_s:   .string	"Please enter your name: "
file_s:     .string	"highscores_x86"
mode1_s:    .string	"a"
mode2_s:    .string	"r"
err1_s:     .string	"ERROR: Can't write to %s\n"
err2_s:     .string	"ERROR: Can't read from %s\n"
save_s:     .string	"%s %d\n"
prev_s:     .string	"\nPrevious high scores,\n"
out_s:      .string	"%s"
bufsize_l:  .long	256

	.section	".bss"
reply_b:    .skip	256
name_b:     .skip	256
buf_b:      .skip	256

	.data
answer_l:   .long	0
guess_l:    .long	0
num_l:      .long	0
fd_l:       .long	0

	.text
	.globl	main
	.type	main, @function
main:	pushl	%ebp
	movl	%esp, %ebp
	subl	$12, %esp
	PRINTF($greet_s)

	/* Generate random number */
	pushl	$0
	call	time
	addl	$4, %esp
	pushl	%eax
	call	srand
	call	rand
	addl	$4, %esp
	movl	$0, %edx
	movl	$100, %ebx
	divl	%ebx
	incl	%edx
	movl	%edx, answer_l

	/* Play game */
game:	movl	num_l, %eax
	incl	%eax
	movl	%eax, num_l
	PRINTF_NUM($entry1_s, num_l)
	FGETS_STR($reply_b)
	pushl	$reply_b
	call	atoi
	addl	$4, %esp
	movl	answer_l, %ebx
	cmpl	%ebx, %eax
	jge	.lower
	PRINTF($higher_s)
	jmp	game
.lower:	cmp	%ebx, %eax
	je	.done
	PRINTF($lower_s)
	jmp	game
.done:	PRINTF_NUM($correct_s, num_l)

	/* Save high score */
	PRINTF($entry2_s)
	FGETS_STR($name_b)
	movl	$name_b, %eax
	movl	$0, %ebx
.L1:	movb	(%eax), %cl
	cmpb	$'\n', %cl
	je	.L2
	incl	%eax
	incl	%ebx
	cmpl	$256, %ebx
	jge	.L2
	jmp	.L1
.L2:	movb	$0, (%eax)
	pushl	$mode1_s
	pushl	$file_s
	call	fopen
	addl	$8, %esp
	movl	%eax, fd_l
	cmpl	$0, %eax
	jne	.write
	FPRINTF_ERR_STR($err1_s, $file_s)
	pushl	$1
	pushl	(%esp)
	call	exit
.write:	addl	$8, %esp
	pushl	num_l
	pushl	$name_b	
	pushl	$save_s
	pushl	fd_l
	call	fprintf
	addl	$16, %esp
	pushl	fd_l
	call	fclose
	addl	$4, %esp

	/* Print high scores */
	PRINTF($prev_s)
	pushl	$mode2_s
	pushl	$file_s
	call	fopen
	addl	$8, %esp
	movl	%eax, fd_l
	cmpl	$0, %eax
	jne	.read
	FPRINTF_ERR_STR($err2_s, $file_s)
	pushl	$2
	pushl	(%esp)
	call	exit
.read:	pushl	fd_l
	pushl	$bufsize_l
	pushl	$buf_b
	call	fgets
	addl	$12, %esp
	cmpl	$0, %eax
	je	.eof
	pushl	$buf_b
	pushl	$out_s
	call	printf
	addl	$4, %esp
	jmp	.read
.eof:	pushl	fd_l
	call	fclose
	addl	$4, %esp

	leave
	ret
	.size	main, .-main
