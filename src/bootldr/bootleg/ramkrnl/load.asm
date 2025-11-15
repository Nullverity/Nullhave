; Модуль загрузки ядра с диска в озу
; За основу этого взят пример из:
;   https://en.wikipedia.org/wiki/INT_13H <- Здесь написано всё в подробностях
; Изменения:
;   13 Nov, 19:48 :: Файл создан.
;   13 Nov, 20:29 :: Добавлена минимальная документация и система загрузки ядра с диска в озу
;   13 Nov, 20:47 :: Исправлены фундаментальные ошибки в загрузке ядра с диска в озу
;   15 Nov, 14:20 :: Исправлена ошибка krnl_ramload_error при загрузке ядра.
;   15 Nov, 21:41 :: Исправлена неверная загрузка ядра в память 
;   15 Nov, 21:45 :: Изменена минимальная документация

[bits 16]

; Определяем `krnl_load`
; Это функция загрузки ядра со второго сектора этого диска
krnl_load:
    pusha
    push dx
    
    ; Сисколл биоса для чтения с диска
    mov ah, 0x02
    mov al, _KRNL_SECTORS       ; Передаём в al число секторов которые надо загрузить
    mov ch, 0x00                ; Цилиндр
    mov dh, 0x00                ; Головка
    mov cl, 0x02                ; Сектор с когорого нужно читать
    mov dl, [_KRNL_BOOTDRV]     ; Передаём номер диска
    ; Настраиваем ES:BX
    ; В данном случае мы будем загружать ядро в 0x100000, что является
    ;   0x1000:0x1000
    ;   ^ ES ~ ^ BX ~
    mov bx, 0x1000              
    mov es, bx
    mov bx, 0x0000
    
    ; Вызываем чтение
    ; Вызываем прерывание BIOS
    int 0x13
    jc krnl_ramload_error
    
    cmp al, _KRNL_SECTORS
    jne krnl_ramload_error
    
    pop dx
    popa
    ret

; Определяем `krnl_ramload_error`
; Функция будет вызываться лишь только тогда, когда будет ошибка загрузки с диска
krnl_ramload_error:
    mov si, disk_load_eror_message
    call m_tty_print
    jmp $

loading_disk_msg db 0x0A, 0x0D, "Reading kernel from disk...", 0x0
loaded_ok_msg db 0x0A, 0x0D, "Kernel read OK.", 0x0
disk_load_eror_message db 0x0A, 0x0D, "An error occurred while reading the disk.", 0x0