;Author: Ashley Chan
;Date: 09/25/2023
;Program Name: Assignment 02 - Array Management System

;===============================================================================
; Declarations
;=============================================================================== 
    extern printf
    global output_array

;===============================================================================
; Static Variables
;=============================================================================== 
section .data
    float_format db "%f", 10, 0

section .text
output_array:
;===============================================================================
; Set up Stack
;=============================================================================== 
    push rbp                                           ;Backup rbp
    mov  rbp,rsp                                       ;The base pointer now points to top of stack
    push rdi                                           ;Backup rdi
    push rsi                                           ;Backup rsi
    push rdx                                           ;Backup rdx
    push rcx                                           ;Backup rcx
    push r8                                            ;Backup r8
    push r9                                            ;Backup r9
    push r10                                           ;Backup r10
    push r11                                           ;Backup r11
    push r12                                           ;Backup r12
    push r13                                           ;Backup r13
    push r14                                           ;Backup r14
    push r15                                           ;Backup r15
    push rbx                                           ;Backup rbx
    pushf
    push qword 0

    ;===============================================================================
    ; Store Array Pointer and Size
    ;=============================================================================== 
    mov r15, rsi                                       ;Times to loop
    xor r13, r13                                       ;Loop counter
    mov r14, rdi                                       ;Array Pointer


loop:
    cmp r13, r15                                       ;Check the loop counter
    je done                                            ;Jump to done if max size is reached

    ;===============================================================================
    ; Print Each Value
    ;===============================================================================
    push qword 0
    mov rax, 1
    movq xmm0, [r14 + r13 * 8]                         ;Obtain value at index
    mov rdi, float_format                              ;Specify print format
    call printf
    pop rax

    inc r13                                            ;Add to Counter
    jmp loop                                           ;Repeat Loop

done:
    mov rax, 0
    pop rax                                            ;Return with nothing in rax

;===============================================================================
; Clean up Stack
;===============================================================================
    popf                                               ;Restore rflags
    pop rbx                                            ;Restore rbx
    pop r15                                            ;Restore r15
    pop r14                                            ;Restore r14
    pop r13                                            ;Restore r13
    pop r12                                            ;Restore r12
    pop r11                                            ;Restore r11
    pop r10                                            ;Restore r10
    pop r9                                             ;Restore r9
    pop r8                                             ;Restore r8
    pop rcx                                            ;Restore rcx
    pop rdx                                            ;Restore rdx
    pop rsi                                            ;Restore rsi
    pop rdi                                            ;Restore rdi
    pop rbp                                            ;Restore rbp

    ret



