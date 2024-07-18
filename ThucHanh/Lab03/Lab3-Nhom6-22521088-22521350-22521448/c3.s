.section .data
request:
    .string "Enter a number (1 digit): "
request_len = .-request

response:
    .string "Max number: "
response_len = .-response


.section .bss
    .lcomm array, 20
    .lcomm max_number 24

.section .text
    .globl _start
_start:
    
    mov $5, %edi
    xor %esi, %esi
loop_input: #Tạo vòng lặp vừa nhập số từ người dùng 5 lần, vừa tiến hành so sánh để tìm ra số lớn nhất
    cmp %edi, %esi
    jz exit
display_request: #In ra yêu cầu nhập số từ người dùng
    mov $1, %ebx
    mov $request, %ecx
    mov $request_len, %edx
    mov $4, %al
    int $0x80

read_input: #Đọc số từ người dùng
    xor %ebx, %ebx
    mov $array, %ecx
    mov %esi, %eax
    imul $4, %eax
    add %eax, %ecx
    mov $2, %edx
    mov $3, %eax
    int $0x80

comparison: #Gắn số lớn nhất bằng số đầu tiên và tiến hành so sánh với những số tiếp theo nhập vào. Nếu số nhập vào lớn hơn số lớn nhất hiện tại,
#thì gắn giá trị số lớn nhất bằng số đó
    movb (max_number), %bl
    mov (%ecx), %al
    cmp %al, %bl
    ja return_loop_input
    movb %al, (max_number)
return_loop_input:
    inc %esi
    jmp loop_input
    
exit: #Tiến hành xuất ra số lớn nhất trong tổng 5 số vừa nhập
    mov $1, %ebx
    mov $response, %ecx
    mov $response_len, %edx
    mov $4, %al
    int $0x80
    mov $1, %ebx
    mov $max_number, %ecx
    mov $2, %edx
    mov $4, %al
    int $0x80
    #Kết thúc chương trình
    mov $1, %al
    int $0x80