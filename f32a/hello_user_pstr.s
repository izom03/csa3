.data
buffer:         .byte  7, 'Hello, ________________________'

ask_str:        .byte  19, 'What is your name?\n'
message_end:    .byte  '!'

input_addr:     .word 0x80
output_addr:    .word 0x84

.text
.org 0x88
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
    lit ask_str a!              \ Выводим строку вопроса
    @p output_addr b!
    print_string

    @p input_addr b!            \ Ввод пользователя
    read_line

    if successful_read

    @p output_addr b!
    lit 0xCCCCCCCC !b

    halt

successful_read:
    lit message_end b!
    message_end_add

    lit buffer a!               \ Вывод приветствия
    @p output_addr b!
    print_string

    halt

print_string:
    @+ byte                     \ Читаем длину строки
print_string_loop:
    dup                         \ Выход если оставшаяся длина == 0
    if print_string_exit

    lit -1 +                    \ Выводим символ
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
    @b                          \ Читаем символ
    dup

    lit 0xA sub                 \ Если \n, то выход
    if read_line_exit_success

    lit buffer a!               \ Увеличиваем длину строки
    @ byte lit 1 +
    dup

    lit 30 sub                  \ Если длина == 30 - ошибка
    if read_line_exit_failure

    dup @ lit 0xFFFFFF00 and + !    \ Сохраняем длину

    lit buffer + a!             \ Добавляем символ
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