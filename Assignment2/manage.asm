;Author: Ashley Chan
;Date: 09/25/2023
;Program Name: Assignment 02 - Array Management System

;===============================================================================
; Declarations
;=============================================================================== 
extern printf
extern exit

extern input_array
extern output_array
extern sum_array

size equ 8
global manage

;===============================================================================
; Static Variables
;=============================================================================== 
segment .data
    prompt1 db "We will take care of all your array needs.", 10, 0
    prompt2 db "Please input float numbers separated by ws.", 10, 0

    output1 db "Thank you. The numbers in the array are:", 10, 0
    output2 db "The sum of numbers in the array is %8.10lf", 10, 0
    output3 db "Thank you for using Array Management System.", 10, 0

;===============================================================================
; Mutable Variables
;=============================================================================== 
segment .bss
    align 16
    array resq size

segment .text

manage:
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
; Print Prompts
;===============================================================================
    push qword 0
    mov rax, 0
    mov rdi, prompt1
    call printf
    pop rax

    ; Prompt the user for floats
    push qword 0
    mov rax, 0
    mov rdi, prompt2
    call printf
    pop rax

;===============================================================================
; Call input_array
;===============================================================================
    push qword 0
    mov rax, 0
    mov rdi, array
    mov rsi, size
    call input_array
    mov r13, rax
    pop rax

;===============================================================================
; Call output_array
;===============================================================================
    push qword 0
    mov rax, 0
    mov rdi, output1
    call printf
    pop rax

    ; Call on output_array helper function to print the entire array
    push qword 0
    mov rax, 0
    mov rdi, array  
    mov rsi, r13 ; Again it is important to note r13 is the actual size of our array
    call output_array
    pop rax

;===============================================================================
; Call sum_array
;===============================================================================
    push qword 0
    mov rax, 0
    mov rdi, array 
    mov rsi, r13
    call sum_array
    movsd xmm15, xmm0
    pop rax

    push qword 0
    mov rax, 1
    movsd xmm0, xmm15
    mov rdi, output2
    call printf
    pop rax

    push qword 0
    mov rax, 0
    mov rdi, output3
    call printf
    pop rax

    movsd xmm0, xmm15
    pop rax

;===============================================================================
; Clean up Stack
;===============================================================================
    popf                                    ;Restore rflags
    pop rbx                                 ;Restore rbx
    pop r15                                 ;Restore r15
    pop r14                                 ;Restore r14
    pop r13                                 ;Restore r13
    pop r12                                 ;Restore r12
    pop r11                                 ;Restore r11
    pop r10                                 ;Restore r10
    pop r9                                  ;Restore r9
    pop r8                                  ;Restore r8
    pop rcx                                 ;Restore rcx
    pop rdx                                 ;Restore rdx
    pop rsi                                 ;Restore rsi
    pop rdi                                 ;Restore rdi
    pop rbp                                 ;Restore rbp

    ret
