/*
 * guess_sparc.m - guessing game in SPARC assembly (with m4 preprocessor)
 *
 * This is written to demonstrate this language versus the same program
 * written in other languages.
 *
 * COMPILE:
 *	m4 < guess_sparc.m > guess.s
 *	gcc -o guess guess.s
 *
 * 14-May-2006  Brendan Gregg   Created this.
 */

define(`answer_r', l7)
define(`guess_r', l6)
define(`num_r', l5)
define(`fd_r', l4)

define(PRINTF, `
	sethi	%hi($1), %o0
	call	printf, 0
	or	%o0, %lo($1), %o0 ')
define(PRINTF_NUM, `
	set	$1, %o0
	call	printf, 0
	mov	$2, %o1 ')
define(FPRINTF_ERR_STR, `
	set	__iob+32, %o0
	set	$1, %o1
	sethi	%hi($2), %o2
	call	fprintf, 0
	or	%o2, %lo($2), %o2 ')
define(FGETS_STR, `
	set	$1, %o0
	set	__iob, %o2
	call	fgets
	mov	256, %o1 ')

	.section	".rodata"
greet_s:    .asciz	"guess_sparc - Guess a number between 1 and 100\n\n"
entry1_s:   .asciz	"Enter guess %d: "
higher_s:   .asciz	"Higher...\n"
lower_s:    .asciz	"Lower...\n"
correct_s:  .asciz	"Correct! That took %d guesses.\n\n"
entry2_s:   .asciz	"Please enter your name: "
file_s:     .asciz	"highscores_sparc"
mode1_s:    .asciz	"a"
mode2_s:    .asciz	"r"
err1_s:     .asciz	"ERROR: Can't write to %s\n"
err2_s:     .asciz	"ERROR: Can't read from %s\n"
save_s:     .asciz	"%s %d\n"
prev_s:     .asciz	"\nPrevious high scores,\n"
out_s:      .asciz	"%s"

	.section	".bss"
reply_b:    .skip	256
name_b:     .skip	256
buf_b:      .skip	256

	.section	".text"
	    .global	main
	    .type	main,#function
	    .align	4

main:	save		%sp, -96, %sp
	clr	%num_r
	PRINTF(greet_s)
	
	/* Generate random number */
	call	time
	clr	%o0
	call	srand
	nop
	call	rand
	nop
	sdiv	%o0, 328, %answer_r
	inc	%answer_r

	/* Play game */
game:	inc	%num_r
	PRINTF_NUM(entry1_s, %num_r)
	FGETS_STR(reply_b)
	sethi	%hi(reply_b), %o0
	call	atoi
	or	%o0, %lo(reply_b), %o0
	mov	%o0, %guess_r
	cmp	%guess_r, %answer_r
	bge	.lower
	nop
	PRINTF(higher_s)
	ba	game
	nop
.lower:	cmp	%guess_r, %answer_r
	be	.done
	nop
	PRINTF(lower_s)
	ba	game
	nop
.done:  PRINTF_NUM(correct_s, %num_r)
	
	/* Save high score */
	PRINTF(entry2_s)
	FGETS_STR(name_b)
	set	name_b, %l0
	clr	%l1
.L1:	ldub	[%l0], %l3
	cmp	%l3, '\n'
	be	.L2
	inc	%l1
	inc	%l0
	cmp	%l1, 256
	bge	.L2
	nop
	ba	.L1
	nop
.L2:	stb	%g0, [%l0]
	set	file_s, %o0
	set	mode1_s, %o1
	call	fopen
	nop
	cmp	%o0, %g0
	bne	.write
	mov	%o0, %fd_r
	FPRINTF_ERR_STR(err1_s, file_s)
	call	exit
	mov	1, %o0
.write:	set	save_s, %o1
	set	name_b, %o2
	call	fprintf
	mov	%num_r, %o3
	mov	%fd_r, %o0
	call	fclose
	nop

	/* Print high scores */
	PRINTF(prev_s)
	set	file_s, %o0
	set	mode2_s, %o1
	call	fopen
	nop
	cmp	%o0, %g0
	bne	.read
	mov	%o0, %fd_r
	FPRINTF_ERR_STR(err2_s, file_s)
	call	exit
	mov	2, %o0
.read:	set	buf_b, %o0
	mov	256, %o1
	call	fgets
	mov	%fd_r, %o2
	cmp	%o0, %g0
	be	.eof
	nop
	set	out_s, %o0
	set	buf_b, %o1
	call	printf
	nop
	ba	.read
	nop
.eof:	mov	%fd_r, %o0
	call	fclose
	nop

	ret
	restore
        .size    main,.-main
