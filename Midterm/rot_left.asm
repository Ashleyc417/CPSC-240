; Author: Ashley Chan
; Date: 10/25/2023
; Program Name: Midterm Program Test

;===============================================================================
; Declarations
;===============================================================================  
global rot_left

section .bss
    align 64
    storedata resb 832

;==================================================================================================================================
; Functionality Logic
;==================================================================================================================================
section .text
rot_left:
    ; Backup registers
    push rbp
    mov rbp, rsp
    push rbx
    push rcx
    push rdx
    push rsi
    push rdi
    push r8
    push r9
    push r10
    push r11
    push r12
    push r13
    push r14
    push r15
    pushf

    ; Backup AVX, SSE, FPU registers
    mov rax, 7
    mov rdx, 0
    xsave [storedata]

    mov r13, rsi                       
    mov r14, rdi                      

    movsd xmm0, [r14]                  

    mov r15, 0                         

    loop_:
        cmp r15, r13                       
        je loop_end                        

        movsd xmm1, [r14 + r15 * 8]        
        movsd [r14 + (r15 - 1) * 8], xmm1  

        inc r15                            
        jmp loop_                          

    loop_end:
        movsd [r14 + (r13 - 1) * 8], xmm0  

    mov rax, 7
    mov rdx, 0
    xrstor [storedata]

    ; Restore General Purpose Registers
    popf
    pop     r15
    pop     r14
    pop     r13
    pop     r12
    pop     r11
    pop     r10
    pop     r9
    pop     r8
    pop     rdi
    pop     rsi
    pop     rdx
    pop     rcx
    pop     rbx
    pop     rbp

    ret