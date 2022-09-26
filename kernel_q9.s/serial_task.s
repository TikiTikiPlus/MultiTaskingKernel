.global	counter
counter:
	.word	0x0
.global	printTimer
.text
printTimer:
	subui	$sp, $sp, 2
	sw	$12, 0($sp)
	sw	$13, 1($sp)
L.6:
L.7:
	lhi	$13, 0x7
	ori	$13, $13, 0x1003
	lw	$13, 0($13)
	andi	$13, $13, 2
	seq	$13, $13, $0
	bnez	$13, L.6
	lhi	$13, 0x7
	ori	$13, $13, 0x1000
	lw	$12, 2($sp)
	addi	$12, $12, 48
	sw	$12, 0($13)
L.5:
	lw	$12, 0($sp)
	lw	$13, 1($sp)
	addui	$sp, $sp, 2
	jr	$ra
.global	receiveChar
receiveChar:
	subui	$sp, $sp, 1
	sw	$13, 0($sp)
	lhi	$13, 0x7
	ori	$13, $13, 0x1003
	lw	$13, 0($13)
	andi	$13, $13, 1
	sne	$13, $13, $0
	bnez	$13, L.10
L.10:
	lhi	$13, 0x7
	ori	$13, $13, 0x1001
	lw	$1, 0($13)
L.9:
	lw	$13, 0($sp)
	addui	$sp, $sp, 1
	jr	$ra
.global	serial_main
serial_main:
	subui	$sp, $sp, 5
	sw	$7, 1($sp)
	sw	$12, 2($sp)
	sw	$13, 3($sp)
	sw	$ra, 4($sp)
	addui	$7, $0, 1
	j	L.14
L.16:
L.17:
	lhi	$13, 0x7
	ori	$13, $13, 0x1003
	lw	$13, 0($13)
	andi	$13, $13, 2
	seq	$13, $13, $0
	bnez	$13, L.16
	lhi	$13, 0x7
	ori	$13, $13, 0x1000
	addui	$12, $0, 13
	sw	$12, 0($13)
	jal	receiveChar
	addu	$13, $0, $1
	sw	$13, character($0)
	lw	$13, character($0)
	seq	$13, $13, $0
	bnez	$13, L.19
	lw	$13, character($0)
	snei	$13, $13, 49
	bnez	$13, L.21
	lw	$13, counter($0)
	divi	$13, $13, 6000
	sw	$13, digit($0)
	addui	$13, $0, 10
	lw	$12, digit($0)
	div	$12, $12, $13
	sw	$12, digit($0)
	lw	$12, digit($0)
	rem	$13, $12, $13
	sw	$13, digit($0)
	lw	$13, digit($0)
	sw	$13, 0($sp)
	jal	printTimer
	lw	$13, counter($0)
	divi	$13, $13, 6000
	sw	$13, digit($0)
	lw	$13, digit($0)
	remi	$13, $13, 10
	sw	$13, digit($0)
	lw	$13, digit($0)
	sw	$13, 0($sp)
	jal	printTimer
L.23:
L.24:
	lhi	$13, 0x7
	ori	$13, $13, 0x1003
	lw	$13, 0($13)
	andi	$13, $13, 2
	seq	$13, $13, $0
	bnez	$13, L.23
	lhi	$13, 0x7
	ori	$13, $13, 0x1000
	addui	$12, $0, 58
	sw	$12, 0($13)
	lw	$13, counter($0)
	divi	$13, $13, 1000
	sw	$13, digit($0)
	lw	$13, digit($0)
	remi	$13, $13, 6
	sw	$13, digit($0)
	lw	$13, digit($0)
	sw	$13, 0($sp)
	jal	printTimer
	lw	$13, counter($0)
	divi	$13, $13, 100
	sw	$13, digit($0)
	lw	$13, digit($0)
	remi	$13, $13, 10
	sw	$13, digit($0)
	lw	$13, digit($0)
	sw	$13, 0($sp)
	jal	printTimer
L.21:
	lw	$13, character($0)
	snei	$13, $13, 50
	bnez	$13, L.26
	lw	$13, counter($0)
	lhi	$12, 0x1
	ori	$12, $12, 0x86a0
	div	$13, $13, $12
	sw	$13, digit($0)
	lw	$13, digit($0)
	remi	$13, $13, 10
	sw	$13, digit($0)
	lw	$13, digit($0)
	sw	$13, 0($sp)
	jal	printTimer
	lw	$13, counter($0)
	divi	$13, $13, 10000
	sw	$13, digit($0)
	lw	$13, digit($0)
	remi	$13, $13, 10
	sw	$13, digit($0)
	lw	$13, digit($0)
	sw	$13, 0($sp)
	jal	printTimer
	lw	$13, counter($0)
	divi	$13, $13, 1000
	sw	$13, digit($0)
	lw	$13, digit($0)
	remi	$13, $13, 10
	sw	$13, digit($0)
	lw	$13, digit($0)
	sw	$13, 0($sp)
	jal	printTimer
	lw	$13, counter($0)
	divi	$13, $13, 100
	sw	$13, digit($0)
	lw	$13, digit($0)
	remi	$13, $13, 10
	sw	$13, digit($0)
	lw	$13, digit($0)
	sw	$13, 0($sp)
	jal	printTimer
L.28:
L.29:
	lhi	$13, 0x7
	ori	$13, $13, 0x1003
	lw	$13, 0($13)
	andi	$13, $13, 2
	seq	$13, $13, $0
	bnez	$13, L.28
	lhi	$13, 0x7
	ori	$13, $13, 0x1000
	addui	$12, $0, 46
	sw	$12, 0($13)
	addui	$13, $0, 10
	lw	$12, counter($0)
	div	$12, $12, $13
	sw	$12, digit($0)
	lw	$12, digit($0)
	rem	$13, $12, $13
	sw	$13, digit($0)
	lw	$13, digit($0)
	sw	$13, 0($sp)
	jal	printTimer
	lw	$13, counter($0)
	remi	$13, $13, 10
	sw	$13, digit($0)
	lw	$13, digit($0)
	sw	$13, 0($sp)
	jal	printTimer
L.26:
	lw	$13, character($0)
	snei	$13, $13, 51
	bnez	$13, L.31
	lw	$13, counter($0)
	lhi	$12, 0x1
	ori	$12, $12, 0x86a0
	div	$13, $13, $12
	sw	$13, digit($0)
	lw	$13, digit($0)
	remi	$13, $13, 10
	sw	$13, digit($0)
	lw	$13, digit($0)
	sw	$13, 0($sp)
	jal	printTimer
	lw	$13, counter($0)
	divi	$13, $13, 10000
	sw	$13, digit($0)
	lw	$13, digit($0)
	remi	$13, $13, 10
	sw	$13, digit($0)
	lw	$13, digit($0)
	sw	$13, 0($sp)
	jal	printTimer
	lw	$13, counter($0)
	divi	$13, $13, 1000
	sw	$13, digit($0)
	lw	$13, digit($0)
	remi	$13, $13, 10
	sw	$13, digit($0)
	lw	$13, digit($0)
	sw	$13, 0($sp)
	jal	printTimer
	lw	$13, counter($0)
	divi	$13, $13, 100
	sw	$13, digit($0)
	lw	$13, digit($0)
	remi	$13, $13, 10
	sw	$13, digit($0)
	lw	$13, digit($0)
	sw	$13, 0($sp)
	jal	printTimer
	addui	$13, $0, 10
	lw	$12, counter($0)
	div	$12, $12, $13
	sw	$12, digit($0)
	lw	$12, digit($0)
	rem	$13, $12, $13
	sw	$13, digit($0)
	lw	$13, digit($0)
	sw	$13, 0($sp)
	jal	printTimer
	lw	$13, counter($0)
	remi	$13, $13, 10
	sw	$13, digit($0)
	lw	$13, digit($0)
	sw	$13, 0($sp)
	jal	printTimer
L.31:
	lw	$13, character($0)
	snei	$13, $13, 113
	bnez	$13, L.39
	addu	$7, $0, $0
	j	L.12
L.19:
	lw	$13, counter($0)
	divi	$13, $13, 6000
	sw	$13, digit($0)
	addui	$13, $0, 10
	lw	$12, digit($0)
	div	$12, $12, $13
	sw	$12, digit($0)
	lw	$12, digit($0)
	rem	$13, $12, $13
	sw	$13, digit($0)
	lw	$13, digit($0)
	sw	$13, 0($sp)
	jal	printTimer
	lw	$13, counter($0)
	divi	$13, $13, 6000
	sw	$13, digit($0)
	lw	$13, digit($0)
	remi	$13, $13, 10
	sw	$13, digit($0)
	lw	$13, digit($0)
	sw	$13, 0($sp)
	jal	printTimer
L.35:
L.36:
	lhi	$13, 0x7
	ori	$13, $13, 0x1003
	lw	$13, 0($13)
	andi	$13, $13, 2
	seq	$13, $13, $0
	bnez	$13, L.35
	lhi	$13, 0x7
	ori	$13, $13, 0x1000
	addui	$12, $0, 58
	sw	$12, 0($13)
	lw	$13, counter($0)
	divi	$13, $13, 1000
	sw	$13, digit($0)
	lw	$13, digit($0)
	remi	$13, $13, 6
	sw	$13, digit($0)
	lw	$13, digit($0)
	sw	$13, 0($sp)
	jal	printTimer
	lw	$13, counter($0)
	divi	$13, $13, 100
	sw	$13, digit($0)
	lw	$13, digit($0)
	remi	$13, $13, 10
	sw	$13, digit($0)
	lw	$13, digit($0)
	sw	$13, 0($sp)
	jal	printTimer
L.38:
L.39:
	lhi	$13, 0x7
	ori	$13, $13, 0x1003
	lw	$13, 0($13)
	andi	$13, $13, 2
	seq	$13, $13, $0
	bnez	$13, L.38
	lhi	$13, 0x7
	ori	$13, $13, 0x1000
	addui	$12, $0, 13
	sw	$12, 0($13)
	lhi	$13, 0x7
	ori	$13, $13, 0x1000
	addui	$12, $0, 32
	sw	$12, 0($13)
	lhi	$13, 0x7
	ori	$13, $13, 0x1000
	addui	$12, $0, 32
	sw	$12, 0($13)
L.41:
L.42:
	lhi	$13, 0x7
	ori	$13, $13, 0x1003
	lw	$13, 0($13)
	andi	$13, $13, 2
	seq	$13, $13, $0
	bnez	$13, L.41
	lhi	$13, 0x7
	ori	$13, $13, 0x1000
	addui	$12, $0, 32
	sw	$12, 0($13)
L.14:
	sne	$13, $7, $0
	bnez	$13, L.17
L.12:
	lw	$7, 1($sp)
	lw	$12, 2($sp)
	lw	$13, 3($sp)
	lw	$ra, 4($sp)
	addui	$sp, $sp, 5
	jr	$ra
.bss
.global	character
character:
	.space	1
.global	digit
digit:
	.space	1
.global	timer
timer:
	.space	1
