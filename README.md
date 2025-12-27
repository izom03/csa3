# АК: Лабораторная работа №3. Опыты

Выполнил: Лихачев Владлен Артемович 

ИСУ: 367355

Группа: P3330

## Запуск программ

### Запуск напрямую через Wrench
```
wrench INPUT.s --isa ISA -c CONF.yaml
```

### Запуск через скрипт
```
Использование:
  ./run.sh <program>

Где <program> может быть:

  1 | reverse_bits    | acc32
  2 | hello_user_pstr | f32a
  3 | sum_of_digits   | risc-iv-32
```

## acc32

Функция: [reverse_bits](https://github.com/ryukzak/wrench/blob/master/variants.md#reverse_bits)

[Программа](acc32/reverse_bits.s)

[Конфигурация](acc32/reverse_bits.yaml)

[Wrench](https://wrench.edu.swampbuds.me/report/3c2eb6e7-3e19-4173-8ab1-3183a7378149)

## f32a

Функция: [hello_user_pstr](https://github.com/ryukzak/wrench/blob/master/variants.md#hello_user_pstr)

[Программа](f32a/hello_user_pstr.s)

[Конфигурация](f32a/hello_user_pstr.yaml)

[Wrench](https://wrench.edu.swampbuds.me/report/e5ebb394-2f62-4ed8-836a-9840f47d41b0)

## RISC-IV

Функция: [sum_of_digits](https://github.com/ryukzak/wrench/blob/master/variants.md#sum_of_digits)

[Программа](risc-iv/sum_of_digits.s)

[Конфигурация](risc-iv/sum_of_digits.yaml)

[Wrench](https://wrench.edu.swampbuds.me/report/fd2ae693-89d2-4d9d-9984-78fffb0f2575)