.extern printf
.extern scanf
.extern rand
.extern srand
	
.section .data
N: .long 10
M: .quad 5
random: .long 0
user_num: .space 4,0x0
user_answer: .space 1,0x0

.section .rodata
num: .string "%d"
answer: .string "%s"
seed: .string "Enter configuration seed: "
easy_mode: .string "Would you like to play in easy mode? (y/n) "
guess: .string "What is your guess? "
incorrect: .string "Incorrect. "
double: .string "Double or nothing! Would you like to continue to another round? (y/n) "
game_over: .string "\nGame over, you lost :(. The correct answer was %d\n"
win: .string "Congratz! You won %d rounds!\n"
below: .string "Your guess was below the actual number ...\n"
above: .string "Your guess was above the actual number ...\n"

.section .text
.globl main
.type	main, @function 
main:
    # Enter
    pushq %rbp
    movq %rsp, %rbp  
	
	# print the string for seed
	movq $seed, %rdi
	xorq %rax, %rax
	call printf
	
	# get the seed
	movq $num, %rdi
	movq $user_num, %rsi
	xorq %rax, %rax
	call scanf
	
	#put the seed in the rdi to call srand and rand
	movq user_num, %r13
	movl user_num, %edi
	xorq %rax, %rax
	call srand
	call rand
    
    # copy N in ecx to do modulo
	movl N, %ecx
	# edx =0 
	xorl %edx, %edx
	# divide ecx/eax
	divl %ecx    # the modulo result is in edx and it's the random number
	movl %edx, random
	incl random
    #initialize r15 to use him as a counter of guess
	xorq %r15, %r15

	#initialize r14 to use him as a counter of rounds
	xorq %r14, %r14
	
	# print the easy mode
	movq $easy_mode, %rdi
	xorq %rax,%rax
	call printf
	
	# scan the answer of the user
	movq $answer, %rdi
	movq $user_answer, %rsi
	xorq %rax, %rax
	call scanf

	#compare the answer with n or y
	movq user_answer, %rsi
	movq $'n', %rbx
	cmpq %rbx, %rsi
	je normal_mode

	movq user_answer, %rsi
	movq $'y', %rbx
	cmpq %rbx, %rsi
	je easy
	
normal_mode:
    # check if ecx is equal to M and stop if needed
    cmpq M, %r15
    je gameOver

    # printing the guess string
	movq $guess, %rdi
	xorq %rax, %rax
	call printf

	# increment r15
    inc %r15

	# get the guess
	movq $num, %rdi
	movq $user_num, %rsi
	xorq %rax, %rax
	call scanf
	  
	#compare the guess with the number
	movl user_num, %eax
	cmpl random, %eax
	je correct_guess
	jne incorrect_guess
	
easy:
	#create a flag to tell that i am in the easy mode
	movq $1, %r12
	# check if the counter of guess is equal to M and stop if needed
    cmpq M, %r15
    je gameOver

    # printing the guess string
	movq $guess, %rdi
	xorq %rax, %rax
	call printf

	# increment r15
    inc %r15

	# get the guess
	movq $num, %rdi
	movq $user_num, %rsi
	xorq %rax, %rax
	call scanf
	  
	#compare the guess with the number
	movl user_num, %eax
	cmpl random, %eax
	jb below_the_guess
	ja above_the_guess
	je correct_guess

above_the_guess:
	#print the above string and go back to the easy mode loop
	movq $incorrect, %rdi
    xorq %rax, %rax
    call printf
	movq $above, %rdi
	xorq %rax, %rax
	call printf
	jmp easy

below_the_guess:
	#print the below string and go back to the easy mode loop
	movq $incorrect, %rdi
    xorq %rax, %rax
    call printf
	movq $below, %rdi
	xorq %rax, %rax
	call printf
	jmp easy

incorrect_guess:
	#print the incorrect string
    movq $incorrect, %rdi
    xorq %rax, %rax
    call printf
    jmp normal_mode

correct_guess:
	#increment r14
	inc %r14

	#print the double or nothing string
	movq $double, %rdi
	xorq %rax, %rax
	call printf

	# scan the answer of the user
	movq $answer, %rdi
	movq $user_answer, %rsi
	xorq %rax, %rax
	call scanf

	#compare the answer with n or y
	movq user_answer, %rsi
	movq $'n', %rbx
	cmpq %rbx, %rsi
	je congratz

	movq user_answer, %rsi
	movq $'y', %rbx
	xorq %r15, %r15
	cmpq %rbx, %rsi
	je doubling

gameOver:
	#print the game over string and end the code
    movq $game_over, %rdi
    movl random, %esi
    xorq %rax, %rax
    call printf
    jmp exit

congratz:
	#print the congratz string and end the code
	movq $win, %rdi
	movq %r14, %rsi
	xorq %rax, %rax
	call printf
	jmp exit

doubling:
	#double the N
	movl N, %eax
	imull $2, %eax
	movl %eax, N

	#double the seed and call srand and rand
	imull $2, %r13d
	movl %r13d, %edi
	call srand
	call rand
    
    # put the address of N in ecx to do modulo
	movl N, %ecx
	# edx =0 
	xorl %edx, %edx
	# divide ecx/eax
	divl %ecx    # the modulo result is in edx and it's the random number
	movl %edx, random
	incl random

	#check if I am in easy or normal mode
	cmpl $1, %r12d
	je easy
	jne normal_mode

exit:	
	# Exit
    xorq %rax, %rax
    movq %rbp, %rsp
    popq %rbp
    ret
	
