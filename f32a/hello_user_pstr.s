.data
.org 0x0
buffer:         .byte  7, 'Hello, ________________________'

ask_str:        .byte  19, 'What is your name?\n'
message_end:    .byte  '!'

input_addr:     .word 0x80
output_addr:    .word 0x84

.text
.org 0x500
byte:
    lit 0xFF and
    ;

neg:
    inv lit 1 +
    ;

sub:
    neg +
    ;

_start:
    \ Выводим строку вопроса
    lit ask_str a!
    @p output_addr b!
    print_string

    \ Ввод пользователя
    @p input_addr b!
    read_line

    if successful_read

    @p output_addr b!
    lit 0xCCCCCCCC !b

    halt

successful_read:
    lit message_end b!
    message_end_add

    \ Вывод приветствия
    lit buffer a!
    @p output_addr b!
    print_string

    halt

print_string:
    \ Читаем длину строки
    @+ byte
print_string_loop:
    \ Выход если оставшаяся длина == 0
    dup
    if print_string_exit

    \ Выводим символ
    lit -1 +
    @+ byte
    !b

    print_string_loop ;
print_string_exit:
    drop
    ;

message_end_add:
    @b byte
    lit buffer a!
    @ byte lit 1 +
    dup @ lit 0xFFFFFF00 and + !
    lit buffer + a!
    @ lit 0xFFFFFF00 and + !
    ;

read_line:
read_line_loop:
    \ Читаем символ
    @b
    dup

    \ Если \n, то выход
    lit 0xA sub
    if read_line_exit_success

    \ Увеличиваем длину строки
    lit buffer a!
    @ byte lit 1 +
    dup
    \ Если длина == 30 - ошибка
    lit 30 sub
    if read_line_exit_failure
    \ Сохраняем длину
    dup @ lit 0xFFFFFF00 and + !
    \ Добавляем символ
    lit buffer + a!
    @ lit 0xFFFFFF00 and + !
    read_line_loop ;
read_line_exit_failure:
    drop drop
    lit -1
    ;
read_line_exit_success:
    drop
    lit 0
    ;