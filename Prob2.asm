	.data
buf:	.space 128
succ:	.asciiz "Success! Location: "
fail:	.asciiz "Fail!\n"

	.text
readstring:
	la $a0, buf	# address of input buffer
	li $a1 128	# maximum number of characters to read
	li $v0, 8	# read string
	syscall

readchar:
	li $v0, 12	# read character
	syscall
	beq $v0, '?', exit	# '?'
	
	li $t0, 0
	la $t1, buf
search:			#search for matching character
	beq $t0, $a1, failing
	lb $t3, ($t1)
	beq $v0, $t3, success
	addi $t1, $t1, 1
	addi $t0, $t0, 1
	j search

failing:
	li $v0, 4	# print string
	la $a0, fail
	syscall
	j readchar
	
success:
	li $v0, 4	# print string
	la $a0, succ
	syscall
	li $v0, 1
	addi $a0, $t0, 1	# print integer
	syscall
	li $v0, 11	# print '\n'
	li $a0, '\n'
	syscall
	j readchar

exit:
	li $v0, 10
	syscall