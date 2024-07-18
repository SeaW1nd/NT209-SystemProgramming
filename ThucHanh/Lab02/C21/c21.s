.section .data
output:
    .string "Love UIT" # Khởi tạo chuỗi Love UIT trong data section

.section .bss
    .lcomm result, 2 # Khởi tạo ô nhớ để đọc input người dùng trong bss section

.section .text
    .globl _start
_start:
    mov $8, %edx #Khởi tạo vòng lặp với tối đa 9 vòng lặp
    xor %ecx, %ecx #Khởi tạo %ecx như biến index trong vòng lặp
loop:
    cmp %ecx, %edx # Nếu i > 8 thì sẽ thoát vòng lặp
    jz exit
    mov $output, %eax #Di chuyển địa chỉ chứa chuỗi vào thanh %eax
    add %ecx, %eax #Cộng địa chỉ với giá trị index trong vòng lặp
    movb (%eax), %bl #Đọc giá trị byte tại địa chỉ được chỉ định
    cmp $0, %bl #Kiểm tra xem giá trị ấy có phải null byte không, nếu có thì quay lại vòng lặp
    jz loop
    add $1, %edi #Tăng giá trị với mỗi ký tự khác null byte
    add $1, %ecx # Tăng giá trị index
    jmp loop
exit:
    #Xuất ra màn hình giá trị chiều dài chuỗi
    add $48, %edi
    mov %edi, (result)
    mov $1, %bl
    mov $result, %ecx
    mov $2, %dl
    mov $4, %eax
    int $0x80
    #Kết thúc chương trình
    xor %eax, %eax
    inc %eax
    int $0x80
