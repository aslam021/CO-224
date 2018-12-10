
	.global main
main:
	@ stack handling, will discuss later
	@ push (store) lr to the stack
	sub sp, sp, #4
	str lr, [sp, #0]

	@scanf Input1
sub sp, sp, #4
ldr r0, =formats
mov r1, sp
bl scanf
ldr r2, [sp, #0]

@scanf Input2
sub sp, sp, #4
ldr r0, =formats
mov r1, sp
bl scanf
ldr r5, [sp, #0]

add sp,sp, #8

lsl r5, r2

ldr r0, =formatp
mov r1, r2
bl printf

	ldr lr, [sp, #0]
	add sp, sp, #4
	mov pc, lr

	.data	@ data memory
@getChar: .asciz "%c"
formats: .asciz "%d" and formatp: .asciz "%d.\n"

