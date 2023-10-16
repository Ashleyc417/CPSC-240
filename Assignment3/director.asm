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
;  Name: director.asm
;  Language: X86-64
;  Syntax: Intel
;  Purpose: Manage input, sorting, and printing the array.




; ========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

;==================================================================================================================================
; Declarations
;==================================================================================================================================
extern printf         ; external C function to write to standard output
extern input_array    ; external function from the assembly module inputarray.asm
extern output_array   ; external function from the assembly module outputarray.c
extern sort_pointers  ; external function from the assembly module sort_pointers.asm 

;==================================================================================================================================
; Static Variables
;==================================================================================================================================
segment .data
    initial_prompt              db "This program will sort all of your doubles.", 10, 0
    input_nums_prompt           db "Please enter floating point numbers separated by white space. After the last numeric input enter at least one more white space and press ctrl+d.", 10, 0
    start_print_nums_output     db "Thank you. You entered these numbers:", 10, 0
    end_print_nums_output       db "End of output of array.", 10, 0
    start_sort_nums_output      db "The array is now being sorted without moving any numbers.", 10, 0
    end_sort_nums_output        db "The data in the array are now ordered as follows:", 10, 0
    function_complete_message   db "The array will be sent back to the caller function.", 10, 0
    array_size equ 10

    string_format db "%s", 0
    floatform     db "%lf", 0

;==================================================================================================================================
; Mutable Variables
;==================================================================================================================================
segment .bss
    align   64
    backup  resb 832
    array   resq array_size

;==================================================================================================================================
; Functionality LoGic
;==================================================================================================================================
section .text
global director

director:

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


    ; Print initial messages
    mov         rax, 0
    mov         rdi, initial_prompt
    call        printf

    mov         rax, 0
    mov         rdi, input_nums_prompt
    call        printf

    ; Take in numbers using input_array.asm
    mov         rax, 0
    mov         rdi, array
    mov         rsi, array_size
    call        input_array
    mov         r13, rax

    ; Show the nums the user entered
    mov         rax, 0
    mov         rdi, start_print_nums_output
    call        printf

    ; Print the elements in the array using output_array
    mov         rax, 0
    mov         rdi, array
    mov         rsi, r13
    call        output_array

    ; Print mesage "End of ouput of array."
    mov         rax, 0
    mov         rdi, end_print_nums_output
    call        printf

    ; Print a message that it will start sorting by pointers 
    mov         rax, 0
    mov         rdi, start_sort_nums_output
    call        printf

    ; Call sort_pointers (sorts the array by pointers)
    mov         rax, 0
    mov         rdi, array
    mov         rsi, r13
    call        sort_pointers

    ; Print update that array has been sorted
    mov         rax, 0
    mov         rsi, string_format
    mov         rdi, end_sort_nums_output
    call        printf

    ; Print the sorted elements
    mov         rax, 0
    mov         rdi, array
    mov         rsi, r13
    call        output_array

    ; Print "End of ouput of array." message
    mov         rax, 0
    mov         rdi, string_format
    mov         rsi, end_sort_nums_output
    call        printf

    ; Print final message before returning to main.c
    mov         rax, 0
    mov         rdi, string_format
    mov         rsi, function_complete_message
    call        printf

    ; State Component Restore 
    mov         rax, 7
    mov         rdx, 0
    xrstor      [backup]


    ; Before returning to main.c. fill the move value of r13 into rax
    mov         rax, r13

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

    mov     qword [rdi], rax

    ; Return the array to the C module
    mov     rax, array

    ret