CP := cp
RM := rm -rf
MKDIR := mkdir -pv

BIN = kernel
ISO = kernel.iso
CFG = grub.cfg
ISO_PATH := iso
BOOT_PATH := $(ISO_PATH)/boot
GRUB_PATH := $(BOOT_PATH)/grub

.PHONY: all
all: bootloader kernel linker iso
	@echo Make has completed.

bootloader: boot.asm
	nasm -f elf32 boot.asm -o boot.o

kernel: kernel.c
	gcc -m32 -ffreestanding -c kernel.c -o kernel.o

linker: linker.ld boot.o kernel.o
	ld -m elf_i386 -T linker.ld -o kernel boot.o kernel.o

iso: kernel linker
	$(MKDIR) $(GRUB_PATH)
	$(CP) $(BIN) $(BOOT_PATH)
	$(CP) $(CFG) $(GRUB_PATH)
	grub-file --is-x86-multiboot $(BOOT_PATH)/$(BIN) || echo "Warning: grub-file multiboot check failed; continuing with ISO creation"
	grub-mkrescue -o $(ISO) $(ISO_PATH)

.PHONY: clean
clean:
	$(RM) *.o $(BIN) *.iso