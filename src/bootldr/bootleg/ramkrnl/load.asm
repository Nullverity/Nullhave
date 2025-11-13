; Модуль загрузки ядра с диска в озу
; За основу этого взят пример из:
;   https://gist.github.com/lpsantil/1874befe382ab43cbd5d#file-boot-asm-L8
;   ^^^^^^^^^^^^~ НЕ ИСПОЛЬЗУЙТЕ ЭТО !!!
; Изменения:
;   13 Nov, 19:48 :: Файл создан.
;   13 Nov, 20:29 :: Добавлена минимальная документация и система загрузки ядра с диска в озу
;   13 Nov, 20:47 :: Исправлены фундаментальные ошибки в загрузке ядра с диска в озу

_KRNL_BOOTDRV db 0x0

; Определяем `krnl_load`
; Это функиця загрузчки ядра с вызовом `krnl_ramload`
krnl_load:
    mov dl, [_KRNL_BOOTDRV]
    call krnl_ramload

; Определяем `krnl_ramload`
; Это функция загрузки ядра со второго сектора этого диска
krnl_ramload:
    mov dh, 0x00                ; Головка
    mov cl, 0x02                ; Сектор с когорого нужно читать
    mov ch, 0x00                ; Цилиндр
    mov al, _KRNL_SECTORS       ; Передаём в al число секторов которые надо загрузить

    ; Подготовка ES:BX на физический адрес _KRNL_ADDR
    mov ax, (_KRNL_ADDR >> 4)   ; Выравниваем по 4 байта сегменты физического адреса
    mov es, ax                  ; Передаём в регистр es значение из ax
    mov bx, _KRNL_ADDR & 0x0F   ; Смещаем наш физиаческий адрес

    ; Вызываем чтение
    pushad
    ; Сисколл биоса для чтения с диска
    mov ah, 0x02
    ; Вызываем прерывание BIOS
    int 0x13
    popad
    jc krnl_ramload_error
    ret

; Определяем `krnl_ramload_error`
; Функция будет вызываться лишь только тогда, когда будет ошибка загрузки с диска
krnl_ramload_error:
    mov si, disk_load_eror_message
    call m_tty_print
    jmp $

disk_load_eror_message db 0x0A, 0x0D, "Kernel load error occured.", 0x0