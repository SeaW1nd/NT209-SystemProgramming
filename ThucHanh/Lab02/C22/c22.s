.section .data
request:
    .string "Nhap MSSV (6 ky tu): "
.section .bss
    .lcomm mssv, 2 #Ô nhớ trong bss section để lưu giá trị input của người dùng
    .lcomm result, 8 # Ô nhớ chứa kết quả trả về sau khi xử lý giá trị input 

.section .text
    .globl _start
_start:
display_request: #In ra yêu cầu nhập MSSV từ người dùng
    inc %ebx
    mov $request, %ecx
    mov $21, %edx
    mov $4, %al
    int $0x80

read_input: #Đọc MSSV từ người dùng
    xor %ebx, %ebx
    mov $mssv, %ecx
    mov $7, %dl
    mov $3, %al
    int $0x80
write_output: #Vòng lặp để đọc giá trị từ 4 ký tự cuối ô nhớ mssv sang ô nhớ result 
    mov $4, %edx
    xor %ecx, %ecx
    xor %ebx, %ebx
    mov $2, %edi
loop1:
    cmp %ecx, %edx
    jz loop2
    mov $mssv, %eax #Di chuyển địa chỉ mssv vào thanh ghi %eax
    add %edi, %eax #Cộng giá trị chứa index bắt đầu 4 ký tự cuối của mssv với index
    add %ecx, %eax #Cộng giá trị địa chỉ mssv với index
    movb (%eax), %bl
    mov $result, %esi #Di chuyển địa chỉ chứa mssv mới vào thanh ghi %esi
    add %ecx, %esi
    add %edi, %esi
    movb %bl, 2(%esi) # Ghi giá trị của 4 ký tự cuối mssv vào địa chỉ chứa mssv mới
    inc %ecx
    jmp loop1

loop2: #Di chuyển 2 ký tự đầu tiên vào ô nhớ chứa mssv mới
    xor %ebx, %ebx
    xor %ecx, %ecx
    mov $mssv, %eax 
    mov $result, %ebx
    movb (%eax), %cl
    movb %cl, (%ebx)
    movb 1(%eax), %cl
    movb %cl, 1(%ebx)
    movb $53, 2(%ebx) #Thêm ký tự '5' vào trong ô nhớ chứa mssv mới ở vị trí 3
    movb $50, 3(%ebx) #Thêm ký tự '2' vào trong ô nhớ chứa mssv mới ở vị trí 4

exit:
    # In ra giá trị của mssv mới
    xor %ebx, %ebx
    mov $1, %bl
    mov $result, %ecx
    mov $9, %edx
    mov $4, %eax
    int $0x80
    #Kết thúc chương trình
    mov $1, %al
    int $0x80
