.text
.global main
main:
	movsg $2, $cctrl
	andi $2,$2, 0xF
	ori $2, $2, 0x42
	movgs $cctrl, $2

	movsg $2, $evec
	sw $2, old_vector($0)
	la $2, our_handler
	movgs $evec, $2
	
	sw $0, 0x72003($0)
	addui $2, $0, 24
	sw $2, 0x72001($0)
	addui $2, $0, 0x03
	sw $2, 0x72000($0)
	
	jal serial_main
our_handler:
	movsg $13, $estat
	andi $13, $13, 0x40
	bnez $13, handler_timer
	lw $13, old_vector($0)
	jr $13
handler_timer:
	sw $0, 0x72003($0)
	lw $13, counter($0)
	addui $13, $13, 1
	sw $13, counter($0)
	rfe
.bss
old_vector: .word
