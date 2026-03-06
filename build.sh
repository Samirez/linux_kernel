#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
ISO_DIR="$ROOT_DIR/iso"
OUTPUT_ISO="$ROOT_DIR/kernel.iso"
cd "$ROOT_DIR"

echo "[1/6] Assembling boot.asm"
nasm -f elf32 boot.asm -o boot.o

echo "[2/6] Compiling kernel.c"
gcc -m32 -ffreestanding -c kernel.c -o kernel.o

echo "[3/6] Linking kernel"
ld -m elf_i386 -T linker.ld -o kernel boot.o kernel.o

echo "[4/6] Preparing ISO tree"
mkdir -p "$ISO_DIR/boot/grub"
cp kernel "$ISO_DIR/boot/kernel"
cp grub.cfg "$ISO_DIR/boot/grub/grub.cfg"

echo "[5/6] Validating kernel Multiboot format"
if ! grub-file --is-x86-multiboot "$ISO_DIR/boot/kernel"; then
    echo "ERROR: kernel is not multiboot compatible"
    exit 1
fi

echo "[6/6] Creating kernel.iso"
grub-mkrescue -o "$OUTPUT_ISO" "$ISO_DIR"

echo "[7/7] Done"
ls -lh "$OUTPUT_ISO"
