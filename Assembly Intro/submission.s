.code32

.globl strlen1
strlen1: 
	push %ebp
	mov %esp, %ebp
	mov 8(%ebp), %ecx
	sub %eax, %eax
loop1: 
	cmpb $0, (%ecx)
	je quit1
	inc %ecx
	inc %eax
	jmp loop1
quit1:
	mov %ebp, %esp
	pop %ebp
	ret

.globl strlen2
strlen2:
    push %ebp
    mov %esp, %ebp
    sub %eax, %eax
    mov 8(%ebp), %ecx
loop2: 
    cmpb $0, (%ecx, %eax)
    jz quit2
    inc %eax
    jmp loop2
quit2: 
    mov %ebp, %esp
    pop %ebp
    ret


.globl strlen3
strlen3:
    push %ebp
    mov %esp, %ebp
    mov 8(%ebp), %ecx
    mov %ecx, %eax 
loop3: 
    cmpb $0, (%eax)
    je quit3
    inc %eax
    jmp loop3
quit3: 
    sub %ecx, %eax
    mov %ebp, %esp
    pop %ebp
    ret
