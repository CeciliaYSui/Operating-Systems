.code32

.globl _boo
_boo:
    mov _g,%eax
    add $31,%eax
    ret

.globl _bar
_bar:
    # Prologue
    push %ebp       # Save old base pointer
    mov %esp, %ebp  # Set new base pointer

    mov 8(%ebp),%eax
    add 12(%ebp),%eax

    # Epilogue
    mov %ebp,%esp   # Deallocate local variables
    pop %ebp        # Restore caller's base pointer
    ret

.globl _baz
_baz:
    push %ebp       # Save old base pointer
    mov %esp, %ebp  # Set new base pointer

    mov $0,%edx             # edx = 0
    mov 8(%ebp),%eax        # eax = pointer
spin:
    add (%eax),%edx         # edx += *eax
    add $4,%eax             # eax++
    decl 12(%ebp)           # n--
    jnz spin
    mov %edx,%eax
    
    # Epilogue
    mov %ebp,%esp   # Deallocate local variables
    pop %ebp        # Restore caller's base pointer
    ret

/*
    Example C call:

    x = myFunc(eax,216,*ebx);

    Equivalent assembly (CALLER):

    push %ecx   # optional
    push %edx   # optional

    push (%ebx)
    push $216
    push %eax
    call myFunc
    add $12, %esp

    pop %edx   # optional
    pop %ecx   # optional
    
    # %eax contains return value


    Example assembly function (CALLEE):

    # Prologue
    push %ebp       # Save old base pointer
    mov %esp, %ebp  # Set new base pointer
    sub $12, %esp   # Make room for three 4-byte local variables.
    push %edi       # Save any used registers: edi, esi, ebx
    push %esi
    push %ebx

    mov XX(%ebp),%eax   # parameter N at 8+4N
    mov %eax,XX(%ebp)   # local var N at -4-4N

    # Epilogue
    pop %ebx        # Recover saved registers
    pop %esi        
    pop %edi
    mov %ebp,%esp   # Deallocate local variables
    pop %ebp        # Restore caller's base pointer
    ret
*/