 .equ     pcb_link, 0
 .equ     pcb_reg1, 1      
 .equ     pcb_reg2, 2      
 .equ     pcb_reg3, 3
 .equ     pcb_reg4, 4      
 .equ     pcb_reg5, 5      
 .equ     pcb_reg6, 6  
 .equ     pcb_reg7, 7      
 .equ     pcb_reg8, 8      
 .equ     pcb_reg9, 9  
 .equ     pcb_reg10, 10
 .equ     pcb_reg11, 11        
 .equ     pcb_reg12, 12      
 .equ     pcb_reg13, 13  
 .equ     pcb_sp, 14  
 .equ     pcb_ra, 15      
 .equ     pcb_ear, 16      
 .equ     pcb_cctrl, 17
 .equ 		pcb_timeslice, 18
 .equ pcb_timer, 19

.text
.global main
main:
	#setup interrupts and other stuff
	movsg $5, $cctrl
	andi $5,$5, 0xD
	# Unmask IRQ2,KU=1,OKU=1,IE=0,OIE=1
	ori $5, $5, 0x4D
	movgs $cctrl, $5
	movsg $2, $evec
	sw $2, old_vector($0)
	la $2, our_handler
	movgs $evec, $2
	sw $0, 0x72003($0)
	addui $2, $0, 24
	sw $2, 0x72001($0)
	addui $2, $0, 0x03
	sw $2, 0x72000($0)
	j process1_main
process1_main:
	# Setup the pcb for process 1 
	la    $1, process1_pcb
	addui $3, $0, 2
	sw $3,  pcb_timeslice($1)
	# Setup the link field 
	la    $2, process2_pcb 
	sw    $2, pcb_link($1) 
	# Setup the stack pointer 
	la    $2, process1_stack
	sw    $2, pcb_sp($1) 
	# Setup the $ear field 
	la    $2, serial_main
	sw    $2, pcb_ear($1) 
	# Setup the $cctrl field 
	movsg $5, $cctrl
	sw    $5, pcb_cctrl($1)
	sw	$1, current_process($0) 
	#setup exitSetup
	la $13, exitSetup
	sw $13, pcb_ra($1)
	j process2_main
process2_main:
	# Setup the pcb for process 1 
	la    $1, process2_pcb
	addui $3, $0, 2
	sw $3,  pcb_timeslice($1)
	# Setup the link field 
	la    $2, process3_pcb 
	sw    $2, pcb_link($1) 
	# Setup the stack pointer 
	la    $2, process2_stack
	sw    $2, pcb_sp($1) 
	# Setup the $ear field 
	la    $2, parallel_main
	sw    $2, pcb_ear($1) 
	# Setup the $cctrl field 
	movsg $5, $cctrl
	sw    $5, pcb_cctrl($1)
	#setup exit
	la $13, exitSetup
	sw $13, pcb_ra($1)
	j process3_main
process3_main:
	# Setup the pcb for process 1 
	la    $1, process3_pcb
	addui $3, $0, 4
	sw $3,  pcb_timeslice($1)
	# Setup the link field 
	la    $2, process1_pcb 
	sw    $2, pcb_link($1) 
	# Setup the stack pointer 
	la    $2, process3_stack
	sw    $2, pcb_sp($1) 
	# Setup the $ear field 
	la    $2, gameSelect_main
	sw    $2, pcb_ear($1) 
	# Setup the $cctrl field 
	movsg $5, $cctrl
	sw    $5, pcb_cctrl($1)
	#setup exit
	la $13, exitSetup
	sw $13, pcb_ra($1)
	j load_context
our_handler:
	#check which exception occured
	#if it was the timer interrupt, jump to handler timer
	#otherwise jump to default exception handler
	movsg $13, $estat
	andi $13, $13, 0x40
	bnez $13, handler_timer
	lw $13, old_vector($0)
	jr $13
handler_timer:
	#acknowledge the interrupt
	#subtract 1 from time slice counter
	#if timeslice counter is zero, go to dispatcher
	#otherwise we return from exception
	sw $0, 0x72003($0)
	lw $13, counter($0)
	addui $13, $13, 1
	sw $13, counter($0)
	lw $13, temptime($0)
	subui $13, $13, 1
	sw $13, temptime($0)
	beqz $13, dispatcher
	rfe
dispatcher:
	#save context for current process
	#select (schedule) the next process
	#reset timeslice counter to addui $13, $0, 1appropriate value
	#load context for next process
	#continues with next process
	#note: be careful in the dispatcher to not lose contents in any registers before they are saved
	#tests to see if the process count has reached zero
	j save_context
save_context:
	# Get the base address of the current PCB     
	lw     $13, current_process($0)     
	# Save the registers     
	sw     $1, pcb_reg1($13)     
	sw     $2, pcb_reg2($13)
	sw     $3, pcb_reg3($13)     
	sw     $4, pcb_reg4($13)
	sw     $5, pcb_reg5($13)     
	sw     $6, pcb_reg6($13)
	sw     $7, pcb_reg7($13)     
	sw     $8, pcb_reg8($13)
	sw     $9, pcb_reg9($13)     
	sw     $10, pcb_reg10($13)
	sw     $11, pcb_reg11($13)     
	sw     $12, pcb_reg12($13)
	sw 	$ra, pcb_ra($13)
	sw 	$sp, pcb_sp($13)
	# $1 is saved now so we can use it     
	# Get the old value of $13     
	movsg  $1, $ers     
	# and save it to the pcb     
	sw     $1, pcb_reg13($13)    
	# Save $ear     
	movsg  $1, $ear  
	#save it to PCB   
	sw    $1, pcb_ear($13)     
	# Save $cctrl     
	movsg  $1, $cctrl     
	sw     $1, pcb_cctrl($13)
	j schedule
exitSetup:
	lw $13, current_process($0)
	sw $13, remove_process($0)
	lw $13, pcb_link($13)
	sw $13, linknext($0)
	lw $13, current_process($0)
	j amIloop
amIloop:
	lw $2, pcb_link($13)
	lw $4, remove_process($0)
	seq $1, $2, $4
	#if equal
	bnez $1, changelink
	#else
	add $13, $0, $2 
	j amIloop
changelink:
	lw $4, linknext($0)
	sw $4, pcb_link($13)
	lw $13, flag($0)
	subui $13, $13, 1
	sw $13, flag($0)
	beqz $13, idle
	j schedule
idle:
	addi $13, $0, '1'
	sw $13, 0x73006($0)
	addi $13, $0, 'm'
	sw $13, 0x73007($0)
	addi $13, $0, '1'
	sw $13, 0x73008($0)
	addi $13, $0, 'n'
	sw $13, 0x73009($0)
	j idle
schedule:
	lw $13, current_process($0) # Get current process     
	lw $13, pcb_link($13) # Get next process from pcb_link field     
	sw $13, current_process($0)# Set next process as current process
	lw $13, current_process($0)
	lw $13, pcb_timeslice($13)
	sw $13, temptime($0)
load_context: 
	lw $13, current_process($0) #Get PCB of current process
	#Get PCB value for $13 back into $ers
	lw $1, pcb_reg13($13)
	movgs $ers, $1	
	#restore ear
	lw $1, pcb_ear($13)
	movgs $ear, $1
	
	lw $1, pcb_cctrl($13)
	movgs $cctrl, $1
	
	#restore other registers
	lw $1, pcb_reg1($13)
	lw $2, pcb_reg2($13)
	lw $3, pcb_reg3($13)
	lw $4, pcb_reg4($13)
	lw $5, pcb_reg5($13)
	lw $6, pcb_reg6($13)
	lw $7, pcb_reg7($13)
	lw $8, pcb_reg8($13)
	lw $9, pcb_reg9($13)
	lw $10, pcb_reg10($13)
	lw $11, pcb_reg11($13)
	lw $12, pcb_reg12($13)
	lw $ra, pcb_ra($13)
	lw 	$sp, pcb_sp($13)
	#return to new process
	rfe
.data
temptime:
	.word 2
flag:
	.word 3
.bss	
#stack for process
	.space 200
process1_stack:
	.space 200
process2_stack:
	.space 200
process3_stack:
current_process: .word
remove_process: .word
linknext: .word
old_vector: .word
process1_pcb:
	.space 20
process2_pcb:
	.space 20
process3_pcb:
	.space 20
