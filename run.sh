#!/usr/bin/env bash

set -e

print_help() {
    cat <<EOF
Использование:
  ./run.sh <program>

Где <program> может быть:

  1 | reverse_bits    | acc32
  2 | hello_user_pstr | f32a
  3 | sum_of_digits   | risc-iv-32
EOF
}

if [[ $# -ne 1 ]]; then
    print_help
    exit 1
fi

arg="$1"

case "$arg" in
    1|reverse_bits|acc32)
        prog="acc32/reverse_bits.s"
        isa="acc32"
        cfg="acc32/reverse_bits.yaml"
        name="reverse_bits"
        ;;
    2|hello_user_pstr|f32a)
        prog="f32a/hello_user_pstr.s"
        isa="f32a"
        cfg="f32a/hello_user_pstr.yaml"
        name="hello_user_pstr"
        ;;
    3|sum_of_digits|risc-iv-32)
        prog="risc-iv/sum_of_digits.s"
        isa="risc-iv-32"
        cfg="risc-iv/sum_of_digits.yaml"
        name="sum_of_digits"
        ;;
    help|-h|--help)
        print_help
        exit 0
        ;;
    *)
        echo "❌ Неизвестный аргумент: $arg"
        echo
        print_help
        exit 1
        ;;
esac

echo "▶ Wrench"
echo "▶ Запуск программы: $name"
echo "▶ Архитектура: $isa"
echo

wrench "$prog" --isa "$isa" -c "$cfg"
