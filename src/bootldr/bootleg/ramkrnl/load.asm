; Модуль загрузки ядра с диска в озу
; За основу этого взят пример из:
;   https://gist.github.com/lpsantil/1874befe382ab43cbd5d#file-boot-asm-L8
; Изменения:
;   13 Nov, 19:48 :: Файл создан.
;   13 Nov, 20:29 :: Добавлена минимальная документация и система загрузки ядра с диска в озу

_KRNL_BOOTDRV db 0x0

; Определяем `krnl_load`
; Это функиця загрузчки ядра с вызовом `krnl_ramload`
krnl_load:
    mov bx, _KRNL_ADDR
    mov dh, _KRNL_SECTORS
    mov dl, [_KRNL_BOOTDRV]
    call krnl_ramload

; Определяем `krnl_ramload`
; Это функция загрузки ядра со второго сектора этого диска
krnl_ramload:
    ; Сохраняем регистры из стека
    pusha

    push dx

    ; Сисколл биоса для чтения с диска
    mov ah, 0x02
    mov al, dh          ; Передаём в al число секторов которые надо загрузить
    mov ah, 0x00        ; Цилиндр
    mov dh, 0x00        ; Головка
    mov cl, 0x02        ; Сектор с когорого нужно читать

    ; Вызываем прерывание BIOS
    int 0x13

    jc krnl_ramload_error

    pop dx
    cmp dh, al
    jne krnl_ramload_error

    popa
    ret

; Определяем `krnl_ramload_error`
; Функция будет вызываться лишь только тогда, когда будет ошибка загрузки с диска
krnl_ramload_error:
    mov si, disk_load_eror_message
    call m_tty_print
    jmp $

disk_load_eror_message db 0x0A, 0x0D, "Kernel load error occured.", 0x0