@ ARM Assembly - lab 2
@
@ Roshan Ragel - roshanr@pdn.ac.lk
@ Hasindu Gamaarachchi - hasindu@ce.pdn.ac.lk

	.text 	@ instruction memory
	.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #4
	str lr, [sp, #0]

	@ Load REQUIRED VALUES HERE
	@ load i to r0
	@ load j to r1
	@load sum to r5


	@ Write YOUR CODE HERE

	@	Sum = 0;
	@	for (i=0;i<10;i++){
	@			for(j=5;j<15;j++){
	@				if(i+j<10) sum+=i*2
	@				else sum+=(i&j);
	@			}
	@	}
	@ Put final sum to r5


	@ ---------------------
	mov r5, #0
	mov r0, #0;

	loop1:
		mov r1, #5
		loop2:
			ADD r2, r0, r1
			cmp r2, #10
			BLT if
				AND r2, r1, r0
				ADD r5, r5, r2
				b exit

			if:
				MUL r2, r0, #2
				ADD r5, r5, r2
			exit:
		ADD r1, r1, #1
		cmp r1, #15
		BLT loop2
	ADD r0, r0, #1
	cmp r0, #10
	BLT loop1


	@ ---------------------


	@ load aguments and print
	ldr r0, =format
	mov r1, r5
	bl printf

	@ stack handling (pop lr from the stack) and return
	ldr lr, [sp, #0]
	add sp, sp, #4
	mov pc, lr

	.data	@ data memory
format: .asciz "The Answer is %d (Expect 300 if correct)\n"

