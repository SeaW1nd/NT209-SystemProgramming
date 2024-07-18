# ASM file at AT&T syntax and 32-bit mode
# to check if a number 5 digits is palindrome or not

.section .data
    msg_input: .string "Enter a number (5-digits): "
    msg_true: .string "Doi xung"
    msg_false: .string "Khong doi xung"
    msg_newline: .string "\n"

.section .bss
    .lcomm number, 5
    .lcomm number_reversed, 5

.section .text
    .globl _start

_start:
    # Print the message to enter a number
    movl $4, %eax
    movl $1, %ebx
    movl $msg_input, %ecx
    movl $27, %edx
    int $0x80

    # Read the number
    movl $3, %eax
    movl $0, %ebx
    movl $number, %ecx
    movl $5, %edx
    int $0x80

    # Clean the register %eax, %ebx, %ecx, %edx
    xorl %eax, %eax
    xorl %ebx, %ebx
    xorl %ecx, %ecx
    xorl %edx, %edx
    # Take first digit and store it at %ebx
    movl $number, %eax
    movb (%eax), %bl
    # Take last digit and store it at %ecx
    movb 4(%eax), %cl
    # Compare first and last digit, if they are different, jump to false
    cmpl %ebx, %ecx
    jne false
    # Take second digit and store it at %ebx
    movb 1(%eax), %bl
    # Take second last digit and store it at %ecx
    movb 3(%eax), %cl
    # Compare second and second last digit, if they are different, jump to false
    cmpl %ebx, %ecx
    jne false
    # If all digits are equal, jump to true
    jmp true
true:
    # Print the message that the number is palindrome
    movl $4, %eax
    movl $1, %ebx
    movl $msg_true, %ecx
    movl $8, %edx
    int $0x80
    # Exit the program
    movl $1, %eax
    movl $0, %ebx
    int $0x80
false:
    # Print the message that the number is not palindrome
    movl $4, %eax
    movl $1, %ebx
    movl $msg_false, %ecx
    movl $14, %edx
    int $0x80
    # Exit the program
    movl $1, %eax
    movl $0, %ebx
    int $0x80
