; Author: Ashley Chan
; Date: 10/25/2023
; Program Name: Midterm Program Test

;===============================================================================
; Declarations
;=============================================================================== 
extern printf
extern exit

extern input_array
extern output_array
extern sum_array
extern rot_left

size equ 10
global manage

;===============================================================================
; Static Variables
;=============================================================================== 
segment .data
    prompt db "Please enter floating point numbers separated by ws.  After the last valid input enter one more ws followed by control+d.", 10, 0
    this_is_the_array_message db "This is the array: ", 10, 0

    rot_left1_message db "Function rot-left was called 1 time.", 10, 0
    here_is_the_array_message db "Here is the array: ", 10, 0
    rot_left3_message db "Function rot_left was called 3 times consecutively.", 10, 0
    rot_left2_message db "Function rot_left was called 2 times consecutively.", 10, 0

    string_format db "%s", 0 
    float_format db "%lf", 0 

;===============================================================================
; Mutable Variables
;=============================================================================== 
segment .bss
    align 64
    storedata resb 832
    array resq size

segment .text

manage:
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
; Print Prompts
;===============================================================================

    ; Prompt the user for floats
    mov rax, 0
    mov rdi, string_format
    mov rsi, prompt
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
; Call output_array / Print initial array
;===============================================================================
    mov rax, 0
    mov rdi, string_format
    mov rsi, this_is_the_array_message
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
; Call rot_left
;===============================================================================
    
    mov rax, 0
    mov rdi, string_format
    mov rsi, rot_left1_message
    call printf
    pop rax

    ; Call rot_left once
    mov rsi, r15                   ;Set counter value to rsi
    mov rdi, array                 ;Set array address to rdi
    call rot_left                  ;Print values

    ; Print "Here is the array"
    mov rax, 0
    mov rdi, string_format
    mov rsi, here_is_the_array_message
    call printf
    pop rax

    mov rax, 0
    mov rdi, string_format
    mov rsi, rot_left3_message
    call printf
    pop rax

    ; Call rot_left once
    mov rsi, r15                   ;Set counter value to rsi
    mov rdi, array                 ;Set array address to rdi
    call rot_left                  ;Print values

    ; Call rot_left once
    mov rsi, r15                   ;Set counter value to rsi
    mov rdi, array                 ;Set array address to rdi
    call rot_left                  ;Print values

    ; Call rot_left once
    mov rsi, r15                   ;Set counter value to rsi
    mov rdi, array                 ;Set array address to rdi
    call rot_left                  ;Print values

    ; Print "Here is the array"
    mov rax, 0
    mov rdi, string_format
    mov rsi, here_is_the_array_message
    call printf
    pop rax

    mov rax, 0
    mov rdi, string_format
    mov rsi, rot_left2_message
    call printf
    pop rax

    ; Call rot_left once
    mov rsi, r15                   ;Set counter value to rsi
    mov rdi, array                 ;Set array address to rdi
    call rot_left                  ;Print values

    ; Call rot_left once
    mov rsi, r15                   ;Set counter value to rsi
    mov rdi, array                 ;Set array address to rdi
    call rot_left                  ;Print values

    ; Print "Here is the array"
    mov rax, 0
    mov rdi, string_format
    mov rsi, here_is_the_array_message
    call printf
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

    movsd xmm0, xmm15
    pop rax

;===============================================================================
; Clean up Stack
;===============================================================================
    mov rax, 7
    mov rdx, 0
    xrstor [storedata]

    movsd xmm8, qword [rsp]
    add rsp, 8
    movsd xmm0, xmm8

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
