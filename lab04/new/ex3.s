@ ARM Assembly - exercise 4

	.text 	@ instruction memory


@ Write YOUR CODE HERE

.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #4
	str lr, [sp, #0]

	ldr r0, =format
	bl printf

	ldr r0, =getNumber
	sub sp, sp, #4
	mov r1, sp
	bl scanf

	ldr r4, [sp, #0]
	add sp, sp, #4
	mov r5, #1

loop:
	cmp r4, r5
	blt exit

	ldr r0, =printNumber
	mov r1, r5
	bl printf
	add r5, #1
	b loop

exit:
	ldr lr, [sp,#0]
	add sp, sp, #4
	mov pc, lr

	.data
format: .asciz "Enter a number: "
getNumber: .asciz "%d"
printNumber: .asciz "%d\n"
