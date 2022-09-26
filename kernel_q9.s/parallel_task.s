.global	switches
switches:
	.word	0x0
.global	buttons
buttons:
	.word	0x0
.global	loop
loop:
	.word	0x0
.global	currentmode
currentmode:
	.word	0x0
.global	button1
.text
button1:
	subui	$sp, $sp, 2
	sw	$12, 0($sp)
	sw	$13, 1($sp)
	lw	$13, switches($0)
	remi	$13, $13, 16
	sw	$13, digits($0)
	lhi	$13, 0x7
	ori	$13, $13, 0x3009
	lw	$12, digits($0)
	sw	$12, 0($13)
	lw	$13, switches($0)
	srai	$13, $13, 4
	sw	$13, switches($0)
	lw	$13, switches($0)
	remi	$13, $13, 16
	sw	$13, digits($0)
	lhi	$13, 0x7
	ori	$13, $13, 0x3008
	lw	$12, digits($0)
	sw	$12, 0($13)
	lw	$13, switches($0)
	srai	$13, $13, 4
	sw	$13, switches($0)
	lw	$13, switches($0)
	remi	$13, $13, 16
	sw	$13, digits($0)
	lhi	$13, 0x7
	ori	$13, $13, 0x3007
	lw	$12, digits($0)
	sw	$12, 0($13)
	lw	$13, switches($0)
	srai	$13, $13, 4
	sw	$13, switches($0)
	lw	$13, switches($0)
	remi	$13, $13, 16
	sw	$13, digits($0)
	lhi	$13, 0x7
	ori	$13, $13, 0x3006
	lw	$12, digits($0)
	sw	$12, 0($13)
L.5:
	lw	$12, 0($sp)
	lw	$13, 1($sp)
	addui	$sp, $sp, 2
	jr	$ra
.global	button2
button2:
	subui	$sp, $sp, 2
	sw	$12, 0($sp)
	sw	$13, 1($sp)
	lw	$13, switches($0)
	remi	$13, $13, 10
	sw	$13, digits($0)
	lhi	$13, 0x7
	ori	$13, $13, 0x3009
	lw	$12, digits($0)
	sw	$12, 0($13)
	addui	$13, $0, 10
	lw	$12, switches($0)
	div	$12, $12, $13
	sw	$12, switches($0)
	lw	$12, switches($0)
	rem	$13, $12, $13
	sw	$13, digits($0)
	lhi	$13, 0x7
	ori	$13, $13, 0x3008
	lw	$12, digits($0)
	sw	$12, 0($13)
	addui	$13, $0, 10
	lw	$12, switches($0)
	div	$12, $12, $13
	sw	$12, switches($0)
	lw	$12, switches($0)
	rem	$13, $12, $13
	sw	$13, digits($0)
	lhi	$13, 0x7
	ori	$13, $13, 0x3007
	lw	$12, digits($0)
	sw	$12, 0($13)
	addui	$13, $0, 10
	lw	$12, switches($0)
	div	$12, $12, $13
	sw	$12, switches($0)
	lw	$12, switches($0)
	rem	$13, $12, $13
	sw	$13, digits($0)
	lhi	$13, 0x7
	ori	$13, $13, 0x3006
	lw	$12, digits($0)
	sw	$12, 0($13)
L.6:
	lw	$12, 0($sp)
	lw	$13, 1($sp)
	addui	$sp, $sp, 2
	jr	$ra
.global	parallel_main
parallel_main:
	subui	$sp, $sp, 2
	sw	$13, 0($sp)
	sw	$ra, 1($sp)
	lhi	$13, 0x7
	ori	$13, $13, 0x3000
	lw	$13, 0($13)
	sw	$13, switches($0)
	jal	button1
	addui	$13, $0, 1
	sw	$13, loop($0)
	j	L.9
L.8:
	lhi	$13, 0x7
	ori	$13, $13, 0x3001
	lw	$13, 0($13)
	sw	$13, buttons($0)
	lhi	$13, 0x7
	ori	$13, $13, 0x3000
	lw	$13, 0($13)
	sw	$13, switches($0)
	lw	$13, buttons($0)
	snei	$13, $13, 2
	bnez	$13, L.11
	addui	$13, $0, 1
	sw	$13, currentmode($0)
L.11:
	lw	$13, buttons($0)
	snei	$13, $13, 4
	bnez	$13, L.13
	sw	$0, loop($0)
L.13:
	lw	$13, buttons($0)
	snei	$13, $13, 1
	bnez	$13, L.15
	sw	$0, currentmode($0)
L.15:
	lw	$13, currentmode($0)
	sne	$13, $13, $0
	bnez	$13, L.17
	jal	button1
	j	L.18
L.17:
	jal	button2
L.18:
L.9:
	lw	$13, loop($0)
	sne	$13, $13, $0
	bnez	$13, L.8
L.7:
	lw	$13, 0($sp)
	lw	$ra, 1($sp)
	addui	$sp, $sp, 2
	jr	$ra
.bss
.global	digits
digits:
	.space	1
.global	mask
mask:
	.space	1
