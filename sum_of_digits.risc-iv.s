.data
input_addr:     .word 0x80
output_addr:    .word 0x84

.text
.org 0x100
_start:
    lui     a0, %hi(input_addr)
    addi    a0, a0, %lo(input_addr)
    lw      a0, 0(a0)               ; Адрес ввода

    lui     a1, %hi(output_addr)
    addi    a1, a1, %lo(output_addr)
    lw      a1, 0(a1)               ; Адрес вывода

    lw      a0, 0(a0)               ; Значение ввода
    addi    a2, zero, 0             ; Итог

    bgt     a0, zero, sum_loop
    sub     a0, zero, a0            ; Делаем положительным

sum_loop:
    addi    a3, zero, 10            ; Число для деления
    rem     a4, a0, a3              ; Цифра
    add     a2, a2, a4              ; Прибавляем цифру
    div     a0, a0, a3              ; Сокращаем число

    beqz    a0, sum_loop_end        ; Если цифры закончились
    j       sum_loop

sum_loop_end:
    sw      a2, 0(a1)               ; Вывод
    halt