/**
 * Исходный: src/krnl/main.c
 * 
 * Главный файл ядра операционной системы Nullhave
 * 
 * Изменения:
 *      13 Nov, 16:34 :: Файл создан.
 *      13 Nov, 16:40 :: Добавлена зависимость `defaults/procio.h` и функция `main` которая вызывает `halt` из procio.
 */

#include "defaults/procio.h"

void main(void) {
    halt();
}