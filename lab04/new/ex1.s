@ ARM Assembly - exercise 4

        .text   @ instruction memory


@ Write YOUR CODE HERE  

.global main    
main:
        @ stack handling, will discuss later
        @ push (store) lr to the stack

	sub sp, sp, #4
	str lr, [sp, #0]

//////////////////////////////////////////////////////////////////////////////


	ldr r0, =formats
	sub sp, sp,#4
	mov r2, sp
	sub sp, sp, #4
	mov r1, sp
	bl scanf

	ldr r5, [sp, #0] //x
	ldr r6, [sp, #4] //y
	add sp, sp, #8

	LSL r3, r5, r6
	LSR r4, r5, r6

	ldr r0, =format
	mov r1, r3
	mov r2, r4
	bl printf

	ldr lr, [sp, #0]
        add sp, sp, #4
        mov pc, lr
	.data 
formats: .asciz "%d %d"
format: .asciz "X*2^Y=%d X/2^Y=%d\n"

