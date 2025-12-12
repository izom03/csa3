.data
.org 0x0
input_addr:     .word 0x80
output_addr:    .word 0x84
input:          .word 0
output:         .word 0
one:            .word 1
count:          .word 32

.text
.org 0x500
_start:
    ; Загрузка ввода
    load_ind    input_addr
    store_addr  input
loop_start:
    ; Сдвиг вывода
    load_addr   output
    shiftl      one
    store_addr  output

    ; Извлекаем бит
    load_addr   input
    and         one
    or          output
    store_addr  output

    ; Сдвиг ввода
    load_addr   input
    shiftr      one
    store_addr  input

    ; Декремент счётчика
    load_addr   count
    sub         one
    store_addr  count

    ; Возвращение
    bnez        loop_start

    ; Выгрузка ввода
    load_addr   output
    store_ind   output_addr
    halt
