.section .data
request:
    .string "Nhap chuoi ky tu (5 ky tu): "
request_len = . -request
number:
    .string "Nhap n (0-9): "
number_len = . -number
.section .bss
    .lcomm user_string, 2 #Khởi tạo ô nhớ chứa chuỗi từ người dùng
    .lcomm user_number, 8 #Khởi tạo ô nhớ chứa giá trị của n

.section .text
    .globl _start
_start:
display_request: #In ra yêu cầu người dùng nhập chuỗi ký tự
    inc %ebx
    mov $request, %ecx
    mov $request_len, %edx
    mov $4, %al
    int $0x80

read_request: #Đọc chuỗi từ người dùng
    xor %ebx, %ebx
    mov $user_string, %ecx
    mov $6, %dl
    mov $3, %al
    int $0x80

display_number: #In ra yêu cầu người dùng nhập n
    mov $1, %ebx
    mov $number, %ecx
    mov $number_len, %edx
    mov $4, %al
    int $0x80

read_number: #Đọc n từ người dùng
    xor %ebx, %ebx
    mov $user_number, %ecx
    mov $3, %dl
    mov $3, %al
    int $0x80


calculate_number:
    movb (user_number),%bl
    sub $48, %ebx
    movb %bl, (user_number)

modify_string: #Tiến hành mã hóa Ceaser chuỗi bằng cách cộng từ ký tự trong chuỗi với giá trị của n. Nếu như giá trị của ký tự đó vượt qua 'Z' (tức là 90 trong mã ASCII) thì sẽ trừ đi 26 để quay lại thành ký tự 'A' trong mã ASCII.
    mov %ebx, %edi
    mov $5, %edx
    xor %ecx, %ecx
loop:
    cmp %ecx, %edx
    jz exit
    mov $user_string, %eax
    add %ecx, %eax
    movb (%eax), %bl
    add %edi, %ebx
    cmp $90, %ebx
    ja second_modify
    mov %bl, (%eax)
    inc %ecx
    jmp loop


second_modify:
    sub $26, %ebx
    mov %bl, (%eax)
    inc %ecx
    jmp loop

exit:
    #In ra chuỗi ký tự sau khi được mã hóa
    xor %ebx, %ebx
    xor %eax, %eax
    xor %ecx, %ecx
    xor %edx, %edx
    mov $1, %bl
    mov $user_string, %ecx
    mov $6, %edx
    mov $4, %eax
    int $0x80
    #Kết thúc chương trình
    mov $1, %al
    int $0x80
