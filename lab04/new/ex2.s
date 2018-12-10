	.text

.global main
main:
	sub sp, sp, #4
	str lr, [sp, #0]

	ldr r0, =formats
	sub sp, sp, #4
	mov r1, sp
	sub sp, sp, #4
	mov r2, sp
	bl scanf

	ldr r6, [sp, #0] //x
	ldr r7, [sp, #4] //y
	add sp, sp, #8

	CMP r6, r7
	beq if
	ldr r0, =format2
	b exit

if:
	ldr r0, =format1

exit:
	bl printf

	ldr lr, [sp, #0]
	add sp, sp, #4
	mov pc, lr

	.data
//formats: .asciz "%d %d"
format1: .asciz "equel\n"
format2: .asciz "not equel\n"
formats: .asciz "%d %d"
