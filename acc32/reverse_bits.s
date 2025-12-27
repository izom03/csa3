.data
input_addr:     .word 0x80
output_addr:    .word 0x84
input:          .word 0
output:         .word 0
one:            .word 1
count:          .word 32

.text
.org 0x88
_start:
    load_ind    input_addr  ; Загрузка ввода
    store_addr  input
loop_start:
    load_addr   output      ; Сдвиг вывода
    shiftl      one
    store_addr  output

    load_addr   input       ; Извлекаем бит
    and         one
    or          output
    store_addr  output

    load_addr   input       ; Сдвиг ввода
    shiftr      one
    store_addr  input

    load_addr   count       ; Декремент счётчика
    sub         one
    store_addr  count

    bnez        loop_start  ; Возвращение

    load_addr   output      ; Выгрузка ввода
    store_ind   output_addr
    halt
