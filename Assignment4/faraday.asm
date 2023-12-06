; Program name: "Work Calculator". This program calculate the work performed 
; based on volts, resistance and time with input validation for float input

; This file is part of the software program "Work Calculator".

; Author information
;   Author name : Ashley Chan
;   Author email: ashleyc417@csu.fullerton.edu
;   Author section: 240-3
;   Author CWID : 885814376

global faraday
extern fgets
extern printf
extern strlen
extern isfloat
extern stdin
extern atof

max_size equ 60
true equ -1
false equ 0

segment .data
    prompt_name db "Please enter your name: ", 0
    prompt_title db "Please enter your title or profession: ", 0
    prompt_welcome db "We always welcome an %s to our electrical lab.", 10, 10, 0

    prompt_voltage db "Please enter the voltage of the electrical system at your site (volts): ", 0
    prompt_resistance  db "Please enter the electrical resistance in the system at your site (ohms): ", 0
    prompt_time db "Please enter the time your system was operating (seconds): ", 0

    prompt_output db 10, "Thank you %s. We at Majestic are pleased to inform you that your system performed %1.2lf joules of work.", 10, 10, 0

    prompt_congrats1 db "Congratulations %s. Come back any time and make use of our software.", 10, 0
    prompt_congrats2 db "Everyone with title %s is welcome to use our programs at a reduced price.", 10, 0
    prompt_error db "Attention %s. Invalid inputs have been encountered. Please run the program again.", 10, 0
    
    debug_float db "Debug %lf", 10, 0
    debug_int db "Debug %d", 10, 0
    debug_text db "Debug %s", 10, 0

segment .bss
    align 64
    storedata resb 832
    input_name resb max_size 
    input_title resb max_size 
    input_volts resb max_size
    input_ohms resb max_size
    input_time resb max_size

segment .text
faraday:
    ; Back up components
    push        rbp
    mov         rbp, rsp
    push        rbx
    push        rcx
    push        rdx
    push        rsi
    push        rdi
    push        r8 
    push        r9 
    push        r10
    push        r11
    push        r12
    push        r13
    push        r14
    push        r15
    pushf

    ; Save all floating-point numbers
    mov         rax, 7
    mov         rdx, 0
    xsave       [storedata]

    ; Print prompt_name
    mov         rax, 0
    mov         rdi, prompt_name                ; Please enter your name:
    call        printf

    ; Get name input
    mov         rax, 0
    mov         rdi, input_name
    mov         rsi, max_size  		            ;accept 59, null at the end
    mov         rdx, [stdin]
    call        fgets			                

    ; Remove newline character
    mov         rax, 0
    mov         rdi, input_name
    call        strlen
    mov         byte[input_name + rax - 1], byte 0

    ; Print prompt_title
    mov         rax, 0
    mov         rdi, prompt_title               ;Please enter your title or profession: 
    call        printf

    ; Get title input
    mov         rax, 0
    mov         rdi, input_title
    mov         rsi, max_size
    mov         rdx, [stdin]
    call        fgets

    ; Remove newline character
    mov         rax, 0
    mov         rdi, input_title
    call        strlen
    mov         byte[input_title + rax - 1], byte 0

    ; Print prompt_welcome
    mov         rax, 0
    mov         rdi, prompt_welcome             ;We always welcome a %s to our electrical lab.
    mov         rsi, input_title
    call        printf

    ; Print prompt_voltage
    mov         rax, 0
    mov         rdi, prompt_voltage             ;Please enter the voltage of the electrical system at your site (volts): %lf
    call        printf

    ; Get voltage input    
    mov         rax, 0
    mov         rdi, input_volts
    mov         rsi, max_size
    mov         rdx, [stdin]
    call        fgets   

    ; Remove newline character
    mov         rax, 0
    mov         rdi, input_volts
    call        strlen
    mov         byte[input_volts + rax - 1], byte 0

    ; Check if the input is a float
    mov         rax, 0
    mov         rdi, input_volts
    call        isfloat
    cmp         rax, false
    je          error

    ; Print prompt_resistance
    mov         rax, 0
    mov         rdi, prompt_resistance          ;Please enter the electrical resistance in the system at your site (ohms): %lf
    call        printf

    ; Get voltage input    
    mov         rax, 0
    mov         rdi, input_ohms
    mov         rsi, max_size
    mov         rdx, [stdin]
    call        fgets   

    ; Remove newline character
    mov         rax, 0
    mov         rdi, input_ohms
    call        strlen
    mov         byte[input_ohms + rax - 1], byte 0

    ; Check if the input is a float
    mov         rax, 0
    mov         rdi, input_ohms
    call        isfloat
    cmp         rax, false
    je          error

    ; Print prompt_time
    mov         rax, 0
    mov         rdi, prompt_time                ;Please enter the time your system was operating (seconds): %lf
    call        printf

    ; Get voltage input    
    mov         rax, 0
    mov         rdi, input_time
    mov         rsi, max_size
    mov         rdx, [stdin]
    call        fgets   

    ; Remove newline character
    mov         rax, 0
    mov         rdi, input_time
    call        strlen
    mov         byte[input_time + rax - 1], byte 0

    ; Check if input is a float
    mov         rax, 0
    mov         rdi, input_time
    call        isfloat
    cmp         rax, false
    je          error

    ; Convert volts from string to float
    mov         rax, 0
    mov         rdi, input_volts
    call        atof
    movsd       xmm15, xmm0

    ; Square voltage
    mulsd       xmm15, xmm15                    

    ; Convert time from string to float
    mov         rax, 0
    mov         rdi, input_time
    call        atof
    movsd       xmm14, xmm0

    ; Multiply the volt with time
    mulsd       xmm15, xmm14

    ; Convert resistance from string to float
    mov         rax, 0
    mov         rdi, input_ohms
    call        atof
    movsd       xmm14, xmm0

    ; Divide the volt square x time by the resistance
    divsd       xmm15, xmm14

    ; Print the prompt_output
    mov         rax, 1
    mov         rdi, prompt_output              ;Thank you %s. We at Majestic are pleased to inform you that your system performed %1.2lf joules of work.
    mov         rsi, input_title
    movsd       xmm0, xmm15
    call        printf

    ; Print the prompt_congrats1
    mov         rax, 0
    mov         rdi, prompt_congrats1           ;Congratulations %s. Come back any time and make use of our software.
    mov         rsi, input_name
    call        printf

    ; Print the prompt_congrats2
    mov         rax, 0
    mov         rdi, prompt_congrats2           ;Everyone with title %s is welcome to use our programs at a reduced price.
    mov         rsi, input_title
    call        printf
    jmp         exit

error:
    ; Print the prompt_error
    mov         rax, 0
    mov         rdi, prompt_error               ;Attention %s. Invalid inputs have been encountered. Please run the program again.
    mov         rsi, input_title
    call        printf

exit:
    ; Save the result on the stack
    movsd       [rsp], xmm15

    ; Restore all the floating-point numbers
    mov         rax, 7
    mov         rdx, 0
    xrstor      [storedata]

    ;  Restore the result and send it to the main module
    movsd       xmm0, [rsp]
    
    ;Restore the original values to the GPRs
    popf          
    pop         r15
    pop         r14
    pop         r13
    pop         r12
    pop         r11
    pop         r10
    pop         r9 
    pop         r8 
    pop         rdi
    pop         rsi
    pop         rdx
    pop         rcx
    pop         rbx
    pop         rbp

    ; Clean up
    ret


