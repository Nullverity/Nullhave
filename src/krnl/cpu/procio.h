/**
 * Исходный: src/krnl/defaults/procio.h
 * 
 * Вспомогательный файл для управления портами процессора
 * 
 * Изменения:
 *      13 Nov, 16:38 :: Файл создан.
 */

static inline void halt(void)
{
    __asm__ __volatile__("hlt");
}