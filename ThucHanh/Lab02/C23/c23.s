.section .data
request:
    .string "Enter a number (2-digit): "
request_len = . -request
request2:
    .string "Enter a number (2-digit): "
request2_len = . -request2
reminder:
    .string "Reminder: X\n"
reminder_len = . -reminder
.section .bss
    .lcomm number1, 2 #Khởi tạo ô nhớ chứa giá trị số thứ nhất
    .lcomm number2, 8 #Khởi tạo ô nhớ chứa giá trị số thứ hai

.section .text
    .globl _start
_start:
display_request: #In ra yêu cầu người dùng nhập số thứ nhất
    inc %ebx
    mov $request, %ecx
    mov $request_len, %edx
    mov $4, %al
    int $0x80

read_input: #Đọc số thứ nhất từ người dùng
    xor %ebx, %ebx
    mov $number1, %ecx
    mov $3, %dl
    mov $3, %al
    int $0x80

display_request2: #In ra yêu cầu người dùng nhập số thứ hai
    mov $1, %ebx
    mov $request2, %ecx
    mov $request2_len, %edx
    mov $4, %al
    int $0x80

read_input2: #Đọc số thứ hai từ người dùng
    xor %ebx, %ebx
    mov $number2, %ecx
    mov $3, %dl
    mov $3, %al
    int $0x80


calculate: 
    #Chuyển đổi từ dạng ASCII ký tự người dùng sang giá trị số đối với số thứ nhất
    xor %eax, %eax
    xor %ebx, %ebx
    mov $number1, %edx
    movb (%edx), %al
    sub $48, %eax
    imul $10, %eax
    movb 1(%edx), %bl
    sub $48, %ebx
    add %ebx, %eax
    mov %eax, %edi

    #Chuyển đổi từ dạng ASCII ký tự người dùng sang giá trị số đối với số thứ hai
    mov $number2, %edx
    movb (%edx), %al
    sub $48, %eax
    imul $10, %eax
    movb 1(%edx), %bl
    sub $48, %ebx
    add %ebx, %eax
    add %edi, %eax
    #Tiến hành cộng giá trị hai số và chia lấy giá trị dư cho 4
    mov $4, %ebx
    mov %eax, %edx
    div %bl
    mov %ah, %cl
    add $48, %ecx
    mov $reminder, %edx
    movb %cl, 10(%edx)

exit:
    #In ra giá trị dư ra màn hình
    xor %ebx, %ebx
    xor %eax, %eax
    xor %ecx, %ecx
    xor %edx, %edx
    mov $1, %bl
    mov $reminder, %ecx
    mov $reminder_len, %edx
    mov $4, %eax
    int $0x80
    #Kết thúc chương trình
    mov $1, %al
    int $0x80
