; Author: Ashley Chan
; Date: 10/25/2023
; Program Name: Midterm Program Test

;==================================================================================================================================
; Declarations
;==================================================================================================================================
extern scanf
extern malloc
global input_array

;==================================================================================================================================
; Static Variables
;==================================================================================================================================
segment .data
    floatform db "%lf", 0

;==================================================================================================================================
; Mutable Variables
;==================================================================================================================================
segment .bss
    align 64
    storedata resb 832

;==================================================================================================================================
; Functionality LoGic
;==================================================================================================================================
segment .text

input_array:
    ; Backup all General Purpose Registers
    push    rbp
    mov     rbp, rsp
    push    rbx
    push    rcx
    push    rdx
    push    rsi
    push    rdi
    push    r8
    push    r9
    push    r10
    push    r11
    push    r12
    push    r13
    push    r14
    push    r15
    pushf

    ; ; State Component Backup 
    ; mov         rax, 7
    ; mov         rdx, 0
    ; xsave       [storedata]

    mov         r14, rdi    ; r14 is the array
    mov         r15, rsi    ; r15 is the upper-limit of the number of cells in the array
    xor         r13, r13    ; r13 to count input
    jmp         input_number

; Loop + Ask for user input until ctrl-d is pressed
input_number:
    ; If the current index (r13) is greater than or equal to the limit (r15), end loop.
    cmp         r13, r15
    jge         input_finished

    ; Create storage for one new number
    mov         rax, 0
    mov         rdi, 8
    call        malloc
    mov         r12, rax    ; r12 = pointer to qword

    ; Scan a floating point number from user
    mov         rax, 0
    mov         rdi, floatform
    mov         rsi, r12
    call        scanf       ; either a float number or ctrl-d

    ; Check if the user has pressed ctrl-d
    cdqe
    cmp         rax, -1
    je          input_finished

    ; r14 is the address of the array, r13 is like the "index".
    ; Multiplying r13 * 8, moves 8 bytes to the next iteration to input more numbers.
    mov         [r14 + r13*8], r12
    inc         r13
    jmp         input_number

input_finished:
    ; ; State Component Restore 
    ; mov     rax, 7
    ; mov     rdx, 0
    ; xrstor  [storedata]


    ; Before returning to main.c. fill the move value of r13 into rax
    pop     rax
    mov     rax, r13

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