;Author: Ashley Chan
;Date: 09/05/2023
;Program Name: Assignment 01 - Las Vegas

;Declarations
    extern printf                                   ;External C function for writing to standard output device
    extern scanf                                    ;External C function for reading from standard output device
    extern exit                                     ;Enternal C keyword to terminate program
    global las_vegas                                ;Allowing las_vegas function to be used externally

;Initialized Constants / Constant Variables
segment .data
    ;Printf formats
    string_format db "%s", 0        ;s - string
    float_format db "%lf", 0        ;lf - 64 bit float
    decimal_format db "%f", 0       ;f - 32 bit float

    ;Total Distance from CSUF -> Las Vegas
    total_distance dq 253.5

    ;Prompts for user input
    prompt1 db "Please enter the speed for the initial segment of the trip (mph): ", 0
    prompt2 db "For how many miles will you maintain this average speed? ", 0
    prompt3 db "What will be your speed during the final segment of the trip (mph)? ", 0
    output1 db 10, "Your average speed will be %lf mph", 10, 0
    output2 db "The total travel time will be %lf hours", 10, 10, 0

    ;Invalid Response
    invalid_message0 db "", 10, 0
    invalid_message1 db "An invalid speed was entered. Please run the program again and enter correct data.", 10, 10, 0
    invalid_message2 db "Your average speed was not calculated.", 10, 0
    invalid_message3 db "The total travel time was not calculated.", 10, 0
    
    ;Zero to Check Validity
    zero dd 0

;Store Memory Locations and Mutable Variables (bss - "Block Starting Symbols")
segment .bss                                        ;resq - "reserve quadword" aka 64 bits of memory
    speed1 resq 1                                   ;Reserve 64 bits - for initial speed
    speed2 resq 1                                   ;Reserve 64 bits - for final speed
    dist1 resq 1                                    ;Reserve 64 bits - for inital distance traveled
    dist2 resq 1                                    ;Reserve 64 bits - for final distance traveled
    time1 resq 1                                    ;Reserve 64 bits - for distance of segment1
    time2 resq 1                                    ;Reserve 64 bits - for distance of segment2
    total_time resq 1                               ;Reserve 64 bits - for trip's total time
    avg_speed resq 1                                ;Reserve 64 bits - for avg speed during trip

;Code Logic/Execution
segment .text
    ;Function to quit the program once an invalid input is received.
    stop_program:

        ;Output invalid message
        mov qword rax, 0
        push rax
        mov rdi, invalid_message0
        call printf
        pop rax

        mov qword rax, 0
        push rax
        mov rdi, invalid_message1
        call printf
        pop rax

        mov qword rax, 0
        push rax
        mov rdi, invalid_message2
        call printf
        pop rax

        mov qword rax, 0
        push rax
        mov rdi, invalid_message3
        call printf
        pop rax

        ;Terminate Program
        movsd xmm0, qword [total_distance]
        ret

    ;Start of Las Vegas Function
    las_vegas:

        ;=== FIRST INPUT ====================================================================================
        ;Prompt user for Speed of 1st segment
        mov qword rax, 0                            ;Allocate 64 bits of memory on the stack for rax
        push rax                                    ;push rax to the stack
        mov rdi, prompt1                            ;Move prompt1 into rdi
        call printf                                 ;Print prompt1
        pop rax                                     ;Deallocate memory rax was using

        ;Read/Store user input (speed1)
        mov rdi, float_format                       ;Move float_format into rdi
        mov rsi, speed1                             ;Move speed1 into rsi
        mov qword rax, 0                            ;Allocate 64 bits of memory on the stack for rax
        push rax                                    ;push rax to the stack
        call scanf                                  ;Grab user input 
        pop rax                                     ;Deallocate memory rax was using
        
        ;Check for Validity (speed1 < or == 0)
        movsd xmm0, qword [speed1]                  ;Move dist1 into xmm0
        ucomisd xmm0, qword [zero]                  ;Check if speed1 > 0
        jbe stop_program                            ;Jump (if below or equal) to stop_program function

        ;=== SECOND INPUT ===================================================================================
        ;Prompt user for Distance of 1st segment
        mov qword rax, 0                            ;Allocate 64 bits of memory on the stack for rax
        push rax                                    ;Set rax to the stack
        mov rdi, prompt2                            ;move prompt2 into rdi
        call printf                                 ;Print prompt1
        pop rax                                     ;Deallocate memory rax was using

        ;Read/Store user input (dist1)
        mov rdi, float_format                       ;Move float_format into rdi
        mov rsi, dist1                              ;Move dist1 into rsi
        mov qword rax, 0                            ;Allocate 64 bits of memory on the stack for rax
        push rax                                    ;push rax to the stack
        call scanf                                  ;Grab user input
        pop rax                                     ;Deallocate memory rax was using

        ;Check for Validity (dist1 < or == 0)
        movsd xmm0, qword [dist1]                  ;Move dist1 into xmm0
        ucomisd xmm0, qword [zero]                  ;Check if dist1 > 0
        jbe stop_program                            ;Jump (if below or equal) to stop_program function

        ;=== THIRD INPUT ====================================================================================
        ;Prompt user for Speed of 2nd segment
        mov qword rax, 0                            ;Allocate 64 bits of memory on the stack for rax
        push rax                                    ;Set rax to the stack
        mov rdi, prompt3                            ;Move prompt3 into rdi
        call printf                                 ;Print prompt1
        pop rax                                     ;Deallocate memory rax was using
        
        ;Read/Store user input (speed2)
        mov rdi, float_format                       ;Move float_format into rdi
        mov rsi, speed2                             ;Move speed2 into rsi
        mov qword rax, 0                            ;Allocate 64 bits of memory on the stack for rax
        push rax                                    ;push rax to the stack
        call scanf                                  ;Grab user input
        pop rax                                     ;Deallocate memory rax was using

        ;Check for Validity (speed2 < or == 0)
        movsd xmm0, qword [speed2]                  ;Move dist1 into xmm0
        ucomisd xmm0, qword [zero]                  ;Check if speed2 > 0
        jbe stop_program                            ;Jump (if below or equal) to stop_program function

        ;====================================================================================================
        ;Breakdown of Register Values
        ;====================================================================================================
        ;xmm8 = speed1: Speed of 1st segment (mph)
        ;xmm9 = dist1: Distance of 1st segment (miles)

        ;xmm10 = speed2: Speed of 2nd segment (mph)
        ;xmm11 = dist2: Distance of 2nd segment (miles)

        ;xmm12 = time1: Time for first segment
        ;xmm13 = time2: Time for second segment
        ;xmm14 = total_time: Total time for trip
        ;xmm15 = avg_speed: Average Speed for Trip
        ;=====================================================================================================

        ;Calculate Distance of 2nd segment (dist2)
        movsd xmm11, qword [total_distance]           ;Move total distance into xmm11
        movsd xmm9, qword [dist1]                     ;Move dist1 into xmm9
        subsd xmm11, xmm9                             ;dist2 = total_distance - dist1
        movsd qword [dist2], xmm11                   

        ;=====================================================================================================
        ;Time = Distance/Speed
        ;=====================================================================================================
        ;Calculate time for 1st segment (time1)
        movsd xmm12, qword [dist1]                     ;Move dist1 into xmm12 
        movsd xmm8, qword [speed1]                     ;Move speed1 into the xmm8
        divsd xmm12, xmm8                              ;time1 = dist1 / speed1
        movsd qword [time1], xmm12                    

        ;Calculate time for 2nd segment (time2)
        movsd xmm13, qword [dist2]                     ;Move dist2 into xmm13 
        movsd xmm10, qword [speed2]                    ;Move speed2 into the xmm10
        divsd xmm13, xmm10                             ;time2 = dist2 / speed2
        movsd qword [time2], xmm13

        ;Compute Total Time (total_time)
        movsd xmm14, qword [time1]                     ;Move time1 into xmm14 
        movsd xmm13, qword [time2]                     ;Move time2 into xmm13
        addsd xmm14, xmm13                             ;total_time = time1 + time2
        movsd qword [total_time], xmm14
    
        ;Compute Average Speed (avg_speed)
        movsd xmm15, [total_distance]                  ;Move total_distance into xmm15
        movsd xmm14, qword [total_time]                ;Move total_time into xmm14
        divsd xmm15, xmm14                             ;avg_speed = total distance / total_time
        movsd qword [avg_speed], xmm15
        
        ;Print out Average Speed
        push qword 0                                   
        mov rax, 1
        mov rdi, output1
        movsd xmm0, qword [avg_speed]
        call printf
        pop rax

        ;Print out Total time for Trip
        push qword 0                                
        mov rax, 1
        mov rdi, output2
        movsd xmm0, qword [total_time]
        call printf
        pop rax

        movsd xmm0, qword[total_time]

        ;End program
        ret
        