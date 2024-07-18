.section .data
request:
    .string "Nhap MSSV (6 ky tu): "
temp: 
    .string "XXXXXX" #Khởi tạo ô nhớ để đọc mssv từ người dùng
mssv:
    .string "XXXXXXXX, " #Khởi tạo ô nhớ chứ mssv sau khi xử lý
year:
    .string "Nien khoa: 20XX, " #Khởi tạo ô nhớ chứa niên khóa của sinh viên
result:
    .string "Sinh vien nam: X\n" # Khởi tạo ô nhớ chứa năm của sinh viên

.section .text
    .globl _start
_start:
display_request: #In ra yêu cầu nhập mssv từ người dùng
    inc %ebx
    mov $request, %ecx
    mov $21, %edx
    mov $4, %al
    int $0x80

read_input: #Đọc mssv từ người dùng
    xor %ebx, %ebx
    mov $temp, %ecx
    mov $6, %dl
    mov $3, %al
    int $0x80

part1: #Tiến hành chèn thêm '52' vào mssv vừa nhập vào từ người dùng
    mov $4, %edx
    xor %ecx, %ecx
    xor %ebx, %ebx
    mov $2, %edi
loop1:
    cmp %ecx, %edx
    jz loop2
    mov $temp, %eax
    add %edi, %eax
    add %ecx, %eax
    movb (%eax), %bl
    mov $mssv, %esi
    add %ecx, %esi
    add %edi, %esi
    movb %bl, 2(%esi)
    inc %ecx
    jmp loop1

loop2:
    xor %ebx, %ebx
    xor %ecx, %ecx
    mov $temp, %eax
    mov $mssv, %ebx
    movb (%eax), %cl
    movb %cl, (%ebx)
    movb 1(%eax), %cl
    movb %cl, 1(%ebx)
    movb $53, 2(%ebx)
    movb $50, 3(%ebx)

part2: #Tiến hành lấy hai ký tự đầu của sinh viên để đọc niên khóa sinh viên
    xor %eax, %eax
    xor %ebx, %ebx
    mov $mssv, %ecx
    movb (%ecx), %al
    movb 1(%ecx), %bl
    mov $year, %ecx
    movb %al, 13(%ecx)
    movb %bl, 14(%ecx)

part3: #Tiến hành tính số năm của sinh viên bằng cách lấy 24 - giá trị số của 2 ký tự đầu của mssv. Sau đó chuyển về giá trị ASCII để biểu diễn khi in ra
    sub $48, %al
    sub $48, %bl
    imul $10, %eax
    add %ebx, %eax
    mov $24, %ebx
    sub %eax, %ebx
    add $48, %ebx
    mov $result, %edx
    movb %bl, 15(%edx)

    
exit:
    #Tiến hành in ra MSSV sau khi xử lý, niên khóa và năm của sinh viên
    mov $1, %bl
    mov $mssv, %ecx
    mov $45, %edx
    mov $4, %eax
    int $0x80
    #Kết thúc chương trình
    mov $1, %al
    int $0x80