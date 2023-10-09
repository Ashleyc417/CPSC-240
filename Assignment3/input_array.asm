;******************************************************************************************************************************************
;Program name: "Assignment 3 - Sort by Pointers".  This program demonstrates the use of cntl+d to terminate an input sequence.            *
;Copyright (C) 2023  Ashley Chan                                                                                                          *
;                                                                                                                                         *
;This file is part of the software program "Assignment 3 - Sort by Pointers".                                                             *
;"Assignment 3 - Sort by Pointers" is free software: you can redistribute it and/or modify it under the terms of the GNU General Public   *
;License version 3 as published by the Free Software Foundation.                                                                          *
;This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied                       *
;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.                   *
;A copy of the GNU General Public License v3 has been distributed with this software. If not found it is available here:                  * 
;<https://www.gnu.org/licenses/>.   The copyright holder may be contacted here: ashleyc417@csu.fullerton.edu                              *
;******************************************************************************************************************************************
;
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;Author information
;  Author name: Ashley Chan
;  Author email: ashleyc417@csu.fullerton.edu
;
;Program information
;  Program name: Assignment 3 - Sort by Pointers
;  Programming languages: Two module in C, One module in C++, Two module in X86-64, and One module in Bash.
;  Date program began: 2023-Oct-4
;  Date of last update: 2023-Oct-9
;  Files in this program: main.c, output_array.c, sorted_array.cpp, director.asm, input_array.asm, rx.sh
;  Status: This program was tested over a dozen times on Ubuntu 22.04.3 (Oct 2023) without errors.
;  Purpose: The intent of this program is to sort an inputted array and return the result.
;
;This file
;  Name: input_array,asm
;  Language: X86-64
;  Syntax: Intel
;  Purpose: Set up a loop that takes in user input for the array and terminates on a control-d signal from the keyboard
;
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**


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
    align   64
    backup  resb 832

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

    ; State Component Backup 
    mov         rax, 7
    mov         rdx, 0
    xsave       [backup]

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
    ; State Component Restore 
    mov     rax, 7
    mov     rdx, 0
    xrstor  [backup]


    ; Before returning to main.c. fill the move value of r13 into rax
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