; Author: Ashley Chan
; Date: 10/25/2023
; Program Name: Midterm Program Test

;===============================================================================
; Declarations
;===============================================================================  
global sum_array

segment .bss
    align 64
    storedata resb 832

segment .text
sum_array:
;===============================================================================
; Set up Stack
;===============================================================================  
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

    ;===============================================================================
    ; Store Values
    ;===============================================================================  
    mov r14, rdi                                       ;Array Pointer
    mov r15, rsi                                       ;Size of Array
    xor r13, r13                                       ;Counter for Loop

    mov rax, 1 
    mov rdx, 0

    cvtsi2sd xmm15, rdx                                ;Store ongoing sum in xmm15

loop:
    cmp r13, r15                                       ;Check the loop counter
    je done                                            ;Jump to done if max size is reached

    addsd xmm15, [r14 + 8*r13]                         ;Add the current element to xmm15 


    inc r13                                            ;Add to Counter
    jmp loop                                           ;Repeat Loop

done:
    pop rax
    movsd xmm0, xmm15                                  ;Return with the array's sum in xmm0

;===============================================================================
; Clean up Stack
;===============================================================================  
    mov rax, 7
    mov rdx, 0
    xrstor [storedata]

    popf
    pop r15
    pop r14
    pop r13
    pop r12
    pop r11
    pop r10
    pop r9
    pop r8
    pop rdi
    pop rsi
    pop rdx
    pop rcx
    pop rbx
    pop rbp

    ret



