SRC_DIR       := src
BOOTLDR_DIR   := $(SRC_DIR)/bootldr/bootleg
KERNEL_DIR    := $(SRC_DIR)/krnl
CACHE_DIR     := .make_cache
OUT_DIR       := build

BOOT_ASM      := $(BOOTLDR_DIR)/legacy.asm
BOOT_BIN      := $(CACHE_DIR)/legacy.bin
KERNEL_ELF    := $(CACHE_DIR)/kernel.elf
KERNEL_BIN    := $(CACHE_DIR)/kernel.bin
KERNEL_LD     := $(KERNEL_DIR)/link.ld
IMG_FILE      := $(OUT_DIR)/Nullhave.img

NASM          := nasm
CC            := i686-elf-gcc
LD            := i686-elf-ld
OBJCOPY       := i686-elf-objcopy
QEMU          := qemu-system-i386
CFLAGS        := -m32 -ffreestanding -fno-pie -fno-stack-protector -O2 -Wall -Wextra
LDFLAGS       := -T $(KERNEL_LD) -m elf_i386 -nostdlib
C_SOURCES     := $(wildcard $(KERNEL_DIR)/*.c)
C_OBJECTS     := $(patsubst $(KERNEL_DIR)/%.c,$(CACHE_DIR)/%.o,$(C_SOURCES))

.PHONY: all clean run dirs

all: dirs $(IMG_FILE)

dirs:
	mkdir -p $(CACHE_DIR)
	mkdir -p $(OUT_DIR)

$(BOOT_BIN): $(BOOT_ASM)
	$(NASM) -f bin $< -I $(BOOTLDR_DIR) -o $@

$(CACHE_DIR)/%.o: $(KERNEL_DIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@

$(KERNEL_ELF): $(C_OBJECTS)
	$(LD) $(LDFLAGS) -o $@ $^

$(KERNEL_BIN): $(KERNEL_ELF)
	$(OBJCOPY) -O binary $< $@

$(IMG_FILE): $(BOOT_BIN) $(KERNEL_BIN)
	cat $^ > $@

run: all
	$(QEMU) -drive file=$(IMG_FILE),format=raw,index=1 -d in_asm,int,cpu_reset -D qemu.log

clean:
	rm -rf $(CACHE_DIR) $(OUT_DIR)