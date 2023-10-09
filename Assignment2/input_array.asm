;Author: Ashley Chan
;Date: 09/25/2023
;Program Name: Assignment 02 - Array Management System

;===============================================================================
; Declarations
;===============================================================================  
extern scanf
global input_array

;===============================================================================
; Static Variables
;=============================================================================== 
segment .data
floatform db "%lf", 0

segment .text
input_array:
;===============================================================================
; Set up Stack
;===============================================================================  
    push rbp                                          ;Backup rbp
    mov  rbp,rsp                                      ;The base pointer now points to top of stack
    push rdi                                          ;Backup rdi
    push rsi                                          ;Backup rsi
    push rdx                                          ;Backup rdx
    push rcx                                          ;Backup rcx
    push r8                                           ;Backup r8
    push r9                                           ;Backup r9
    push r10                                          ;Backup r10
    push r11                                          ;Backup r11
    push r12                                          ;Backup r12
    push r13                                          ;Backup r13
    push r14                                          ;Backup r14
    push r15                                          ;Backup r15
    push rbx                                          ;Backup rbx
    pushf
    push qword 0

;===============================================================================
; Store Values
;===============================================================================  
    mov r14, rdi                                       ;Array Pointer
    mov r15, rsi                                       ;Size of Array
    xor r13, r13                                       ;Counter for Loop

loop:
    ; Check the loop count, exit if necessary
    cmp r13, r15                                       ;Check the loop counter
    je done                                            ;Jump to done if max size is reached

    mov rax, 0
    mov rdi, floatform                                 ;Specify scanf format
    push qword 0
    mov rsi, rsp
    call scanf                                         ;Take in user's input value

    cdqe

    cmp rax, -1                                        ;Check for Ctrl+D being entered
    pop r12                                            ;Pop the value into r12 
    je done

    mov [r14 + r13 * 8], r12                           ;Insert value into array
    inc r13                                            ;Increment Counter
    jmp loop                                           ;Repeat Loop

done:
    pop rax
    mov rax, r13                                       ;Array size will be returned in r13

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



