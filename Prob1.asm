#The data uses spaces to ensure alignment. As a result, the words are aligned in 10 bytes.
	.data
LowerCase:	.asciiz "alpha","   ","bravo","   ","china","   ","delta","   ","echo","    ","foxtrot"," ",
			"golf","    ","hotel","   ","india","   ","juliet","  ","kilo","    ","lima","    ",
			"mary","    ","november","","oscar","   ","paper","   ","quebec","  ","research","",
			"sierra","  ","tango","   ","uniform"," ","victor","  ","whisky","  ","x-ray","   ",
			"yankee","  ","zulu"
			
UpperCase:	.asciiz "Alpha","   ","Bravo","   ","China","   ","Delta","   ","Echo","    ","Foxtrot"," ",
			"Golf","    ","Hotel","   ","India","   ","Juliet","  ","Kilo","    ","Lima","    ",
			"Mary","    ","November","","Oscar","   ","Paper","   ","Quebec","  ","Research","",
			"Sierra","  ","Tango","   ","Uniform"," ","Victor","  ","Whisky","  ","X-ray","   ",
			"Yankee","  ","Zulu"
			
Number:		.asciiz "Zero","    ","First","   ","Second","  ","Third","   ","Fourth","  ","Fifth","   ",
			"Sixth","   ","Seventh"," ","Eighth","  ","Ninth"

	.text	
start:
	li $v0, 12
	syscall
	move $t0, $v0
	beq $t0, '?', end	#equals '?'

#In the ASCII Code, [0-9] < [A-Z] < [a-z]. So there are six comparations: "<0?" "<=9?" "<A?" "<=Z?" "<a?" "<z?"
examination:
	blt $t0, '0', other
	
	la $a0, Number		#If it is [0-9]
	subi $t1, $t0, '0'
	ble $t0, '9', numberorletter
	
	blt $t0, 'A', other
	
	la $a0, UpperCase	#If it is [A-Z]
	subi $t1, $t0, 'A'
	ble $t0, 'Z', numberorletter
	
	blt $t0, 'a', other
	
	la $a0, LowerCase	#If it is [a-z]
	subi $t1, $t0, 'a'
	ble $t0, 'z', numberorletter
	
	j other
	
#Print '*'
other:	
	li $v0, 11	# print '*'
	li $a0, '*'
	syscall
	li $a0, '\n'	# print '\n'
	syscall
	j start
	
#Print words
numberorletter:
	li $v0, 4	# print word
	mul $t1, $t1, 10
	add $a0, $a0, $t1
	syscall
	li $v0, 11	#print '\n'
	li $a0, '\n'
	syscall
	j start

end:
	li $v0, 10
	syscall
