; ******************************************************************************************************************************************
; Program name: "Assignment 3 - Sort by Pointers".  This program demonstrates the use of cntl+d to terminate an input sequence.            *
; Copyright (C) 2023  Ashley Chan                                                                                                          *
;                                                                                                                                          *
; This file is part of the software program "Assignment 3 - Sort by Pointers".                                                             *
; "Assignment 3 - Sort by Pointers" is free software: you can redistribute it and/or modify it under the terms of the GNU General Public   *
; License version 3 as published by the Free Software Foundation.                                                                          *
; This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied                       *
; warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.                   *
; A copy of the GNU General Public License v3 has been distributed with this software. If not found it is available here:                  * 
; <https://www.gnu.org/licenses/>.   The copyright holder may be contacted here: ashleyc417@csu.fullerton.edu                              *
; ******************************************************************************************************************************************




; ========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
; Author information
;  Author name: Ashley Chan
;  Author email: ashleyc417@csu.fullerton.edu

; Program information
;  Program name: Assignment 3 - Sort by Pointers
;  Programming languages: Two module in C, One module in C++, Two module in X86-64, and One module in Bash.
;  Date program began: 2023-Oct-4
;  Date of last update: 2023-Oct-15
;  Files in this program: main.c, output_array.c, sorted_array.cpp, director.asm, input_array.asm, rx.sh
;  Status: This program was tested over a dozen times on Ubuntu 22.04.3 (Oct 2023) without errors.
;  Purpose: The intent of this program is to sort an inputted array and return the result.

; This file
;  Name: sort_pointers,asm
;  Language: X86-64
;  Syntax: Intel
;  Purpose: Sorting numbers in array in increasing order.




; ========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

;==================================================================================================================================
; Declarations
;==================================================================================================================================
segment .bss
    align 64
    backup_r resq 832

segment .text
    global sort_pointers

sort_pointers:
    ; Back up every general purpose register
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

    ; Utilize xsave to backup component
    mov rax, 7
    mov rdx, 0
    xsave [backup_r]
    
    mov r8, rdi     ; Pointer for array
    mov r9, rsi     ; Size of array
    xor r10, r10    ; Counter for loop
    inc r10             

    xor r11, r11       
    xor r12, r12    ; Temp variable
    xor r13, r13    ; Temp variable

    jmp sweep

restart:
    xor r10, r10
    inc r10
    xor r11, r11
    inc r11
    jmp sweep

sweep:
    ; If true, array is completely sorted, and jump to done
    cmp r11, r9
    je done
   
    ; If true, sweep again
    cmp r10, r9
    jge restart

    ; If current element is larger, swap elements
    mov r12, [r8 + r10 * 8 - 8]
    mov r13, [r8 + r10 * 8]
    
    movsd xmm8, [r12]
    movsd xmm9, [r13]

    ; Compare both, swap if needed
    ucomisd xmm8, xmm9
    ja swap

    ; Increment counter if there was no swap
    inc r11
    jmp after_swap

swap:
    ; Swap both pointers using temp registers
    mov r12, [r8 + r10 * 8 - 8]
    mov r13, [r8 + r10 * 8]
    mov [r8 + r10 * 8 - 8], r13
    mov [r8 + r10 * 8], r12

    jmp after_swap

after_swap:
    ; Increment counter and continue loop
    inc r10
    jmp sweep

done:
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

