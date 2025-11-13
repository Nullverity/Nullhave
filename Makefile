_src := src
_bootldr_bootleg := bootldr/bootleg
_bleg_legacy_src := legacy.asm
_bleg_legacy_out := legacy.bin
_make_cache := .make_cache

all: clean compile

compile:
	nasm $(_src)/$(_bootldr_bootleg)/$(_bleg_legacy_src) -I $(_src)/$(_bootldr_bootleg) -o $(_make_cache)/$(_bleg_legacy_out)

clean:
	rm -rf $(_make_cache)
	mkdir $(_make_cache)

bootrun:
	qemu-system-i386 -fda $(_make_cache)/$(_bleg_legacy_out)

phony: all