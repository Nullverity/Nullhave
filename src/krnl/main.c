/**
 * Исходный: src/krnl/main.c
 * 
 * Главный файл ядра операционной системы Nullhave
 * 
 * Изменения:
 *      13 Nov, 16:34 :: Файл создан.
 *      13 Nov, 16:40 :: Добавлена зависимость `defaults/procio.h` и функция `main` которая вызывает `halt` из procio.
 *      13 Nov, 20:33 :: Изменён путь зависимости procio с `defaults/procio.h` на `cpu/procio.h`
 *      15 Nov, 21:52 :: Добавлен вывод символа 'X' белым на чёрном фоне в видеопамять (VGA).
 */

#include "cpu/procio.h"

volatile unsigned short* vga_buffer = (unsigned short*)0xB8000;

void main(void) {
    vga_buffer[0] = (0x0F << 8) | 'X';
    while (1) {}
    // Альтернативный метод, если вариант сверху падёт из-за break;
    halt();
}