/**
 * Исходный: src/krnl/main.c
 * 
 * Главный файл ядра операционной системы Nullhave
 * 
 * Изменения:
 *      13 Nov, 16:34 :: Файл создан.
 *      13 Nov, 16:40 :: Добавлена зависимость `defaults/procio.h` и функция `main` которая вызывает `halt` из procio.
 *      13 Nov, 20:33 :: Изменён путь зависимости procio с `defaults/procio.h` на `cpu/procio.h`
 */

#include "cpu/procio.h"

void main(void) {
    halt();
}