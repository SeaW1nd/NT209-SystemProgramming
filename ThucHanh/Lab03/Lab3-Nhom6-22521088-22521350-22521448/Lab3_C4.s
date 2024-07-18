# Program to check if 4-digit year is a leap year or not
# by creating function to check if year is leap year or not
# and then calling the function to check if year is leap year or not
# also finding out next leap year after the given year

.section .data
    msg_input: .string "Enter a year (4-digits): "
    msg_leap: .string "Nam nhuan"
    msg_not_leap: .string "Khong phai nam nhuan"
    msg_next_leap: .string "Nam nhuan ke tiep: "
    buffer: .space 5 # 4 digits and a null terminator
    format: .string "%d"
    newline: .string "\n"

.section .bss
    .lcomm year, 4
    .lcomm int_year, 4

.section .text
    .globl _start

_start:
    # Print message to enter a year
    mov $4, %eax
    mov $1, %ebx
    mov $msg_input, %ecx
    mov $25, %edx
    int $0x80

    # Read year from user
    mov $3, %eax
    mov $0, %ebx
    mov $year, %ecx
    mov $4, %edx
    int $0x80

    # Convert year from string to integer and store at %edx
    mov $0, %eax # %eax = 0
    mov $year, %ecx # %ecx = year
    mov $10, %ebx # %ebx = 10
    # Clean up %edx
    xor %edx, %edx

    # Loop to convert string to integer
    convert_to_int:
        movb (%ecx), %al
        cmp $0, %al
        je end_convert_to_int
        sub $48, %al
        imul %ebx, %edx
        add %eax, %edx
        inc %ecx
        jmp convert_to_int
    
    end_convert_to_int:
    # Save year in int_year
    mov %edx, int_year

    # Code to check if year is leap year or not
    # Input: year
    # Output: 1 if year is leap year, 0 if year is not leap year

    # If year%400 == 0, return 1
    # Implement year%400 == 0
    movl %edx, %eax # %eax = year
    movl $400, %ebx # %ebx = 400
    cltd
    divl %ebx # %eax = %eax/%ebx, %edx = %eax%ebx
    cmp $0, %edx
    jne not_divisible_by_400
    # Else assign 1 to %eax and jump to end_is_leap_year
    mov $1, %eax
    jmp end_is_leap_year

not_divisible_by_400:
    # If year%100 == 0, return 0

    # Restore year from int_year to %edx
    mov int_year, %edx

    # Implement year%100 == 0
    movl %edx, %eax # %eax = year
    movl $100, %ebx # %ebx = 100
    cltd
    divl %ebx # %eax = %eax/%ebx, %edx = %eax%ebx

    cmp $0, %edx
    jne not_divisible_by_100

    # Else assign 0 to %eax and jump to end_is_leap_year
    mov $0, %eax
    jmp end_is_leap_year

not_divisible_by_100:
    # If year%4 == 0, return 1

    # Restore year from int_year to %edx
    mov int_year, %edx

    movl %edx, %eax # %eax = year
    movl $4, %ebx # %ebx = 4
    cltd
    divl %ebx # %eax = %eax/%ebx, %edx = %eax%ebx

    cmp $0, %edx
    jne not_divisible_by_4

    # Else assign 1 to %eax and jump to end_is_leap_year
    mov $1, %eax
    jmp end_is_leap_year

not_divisible_by_4:
    # Else assign 0 to %eax and jump to end_is_leap_year
    mov $0, %eax

end_is_leap_year:
    # If %eax is 0, jump to not_leap
    cmp $0, %eax
    je not_leap

    # Else, jump to leap
    jmp leap

not_leap:
    # Print message if year is not leap year
    mov $4, %eax
    mov $1, %ebx
    mov $msg_not_leap, %ecx
    mov $20, %edx
    int $0x80
    jmp print_newline

leap:
    # Print message if year is leap year
    mov $4, %eax
    mov $1, %ebx
    mov $msg_leap, %ecx
    mov $9, %edx
    int $0x80
    jmp print_newline

print_newline:
    # Print newline
    mov $4, %eax
    mov $1, %ebx
    mov $newline, %ecx
    mov $1, %edx
    int $0x80
    jmp next_leap

next_leap:
    # Find next leap year after the given year
    # Idea: Increase year by 1 until we find a leap year

    # Restore year from int_year to %edx
    mov int_year, %edx
    # Increase year by 1
    inc %edx
    # Store year in int_year
    mov %edx, int_year

    # Loop to find next leap year
    # If year%400 == 0, return 1
    find_next_leap:
        # Implement year%400 == 0
        movl %edx, %eax # %eax = year
        movl $400, %ebx # %ebx = 400
        cltd
        divl %ebx # %eax = %eax/%ebx, %edx = %eax%ebx

        cmp $0, %edx
        jne not_divisible_by_400_next

        # Else assign 1 to %eax and jump to end_is_leap_year_next
        mov $1, %eax
        jmp end_is_leap_year_next

    # If year%100 == 0, return 0
    not_divisible_by_400_next:
        # Restore year from int_year to %edx
        mov int_year, %edx

        # Implement year%100 == 0
        movl %edx, %eax # %eax = year
        movl $100, %ebx # %ebx = 100
        cltd
        divl %ebx # %eax = %eax/%ebx, %edx = %eax%ebx

        cmp $0, %edx
        jne not_divisible_by_100_next

        # Else assign 0 to %eax and jump to end_is_leap_year_next
        mov $0, %eax
        jmp end_is_leap_year_next

    # If year%4 == 0, return 1
    not_divisible_by_100_next:
        # Restore year from int_year to %edx
        mov int_year, %edx

        # Implement year%4 == 0
        movl %edx, %eax # %eax = year
        movl $4, %ebx # %ebx = 4
        cltd
        divl %ebx # %eax = %eax/%ebx, %edx = %eax%ebx

        cmp $0, %edx
        jne not_divisible_by_4_next

        # Else assign 1 to %eax and jump to end_is_leap_year_next
        mov $1, %eax
        jmp end_is_leap_year_next

    # Else assign 0 to %eax and jump to end_is_leap_year_next
    not_divisible_by_4_next:
        mov $0, %eax

    # If result from %eax is 1, print next leap year, else continue to find next leap year
    end_is_leap_year_next:
        # If %eax is 0, jump to not_leap_next
        cmp $0, %eax
        je not_leap_next
        # Else, jump to leap_next
        jmp leap_next

    # Print message if year is not leap year
    not_leap_next:
        # Jump to find_next_leap
        jmp next_leap

    # Print message if year is leap year
    leap_next:
        # Print message if year is leap year
        mov $4, %eax
        mov $1, %ebx
        mov $msg_next_leap, %ecx
        mov $19, %edx
        int $0x80

        # Print next leap year in int_year
        # But first, convert int_year to string
        # Convert int_year to string
        mov int_year, %edx
       
        # Initialize buffer index to the end
        mov $buffer + 4, %ecx  # Point to the end of the buffer

        # Clear upper bits of %edx
        mov %edx, %eax
        and $0xFFFF, %eax

        # Convert each digit of the integer to ASCII
        convert_to_string:
            mov $10, %ebx       # Divisor for decimal conversion
            xor %edx, %edx      # Clear %edx for division
            div %ebx            # Divide %eax by 10, quotient in %eax, remainder in %edx

            # Convert the remainder (digit) to ASCII and store in the buffer
            add $'0', %dl       # Convert digit to ASCII
            mov %dl, (%ecx)     # Store ASCII digit in the buffer

            dec %ecx            # Move to the next position in the buffer

            test %eax, %eax     # Check if quotient is zero
            jnz convert_to_string   # If not zero, continue conversion

        # Print the next leap year
        mov $4, %eax
        mov $1, %ebx
        mov $buffer, %ecx
        mov $5, %edx
        int $0x80
        jmp exit

exit:
    # Exit program
    mov $1, %eax
    mov $0, %ebx
    int $0x80