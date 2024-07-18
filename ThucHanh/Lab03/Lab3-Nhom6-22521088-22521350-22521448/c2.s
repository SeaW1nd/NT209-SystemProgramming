.section .data
request:
    .string "Enter a string (<255 chars): "
request_len = .-request

response:
    .string "Number of words: "
response_len = .-response

.section .bss
    .lcomm user_input, 2 #Ô nhớ trong bss section để lưu giá trị input của người dùng
    .lcomm result, 8 # Ô nhớ chứa kết quả trả về sau khi xử lý giá trị input 

.section .text
    .globl _start
_start:
display_request: #In ra yêu cầu nhập chuỗi từ người dùng
    inc %ebx
    mov $request, %ecx
    mov $request_len, %edx
    mov $4, %al
    int $0x80

read_input: #Đọc chuỗi từ người dùng
    xor %ebx, %ebx
    mov $user_input, %ecx
    mov $256, %edx
    mov $3, %al
    int $0x80

#Vong lap
    mov %eax, %edx
    xor %ecx, %ecx
    xor %edi, %edi #Số từ đếm được = 0
    xor %esi, %esi #Biến kiểm tra = 0
loop: #Tạo vòng lặp kiểm tra từng ký tự trong chuỗi, nếu gặp ký tự khoảng cách thì biến kiểm tra = 1, đồng thời nếu ký tự đó mà không phải là khoảng trắng mà biến kiểm tra = 1 thì số từ đếm được + 1 và biến kiểm tra = 0
    cmp %ecx, %edx
    jz exit
    mov $user_input, %ebx
    add %ecx, %ebx
    movb (%ebx), %al
    cmp $32, %al
    jz check_out
    movb (%ebx), %al
    cmp $10, %al
    jz check_out
    movb (%ebx), %al
    cmp $9, %al
    jnz count_word


check_out:
    xor %esi, %esi

return_loop:
    inc %ecx
    jmp loop


count_word:
    cmp $0, %esi
    jnz return_loop
    inc %esi
    inc %edi
    jmp return_loop

exit: #Tiến hành xuất kết quả ra ngoài màn hình
    add $48, %edi
    mov %edi, result

    xor %ebx, %ebx
    mov $1, %bl
    mov $response, %ecx
    mov $response_len, %edx
    mov $4, %eax
    int $0x80


    xor %ebx, %ebx
    mov $1, %bl
    mov $result, %ecx
    mov $2, %edx
    mov $4, %eax
    int $0x80
    #Kết thúc chương trình
    mov $1, %al
    int $0x80
