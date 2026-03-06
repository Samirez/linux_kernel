OUTPUT_FORMAT(elf32-i386)

MEMORY {
    FLASH (rx) : ORIGIN = 0x00100000, LENGTH = 512K
    RAM (rwx)  : ORIGIN = 0x01000000, LENGTH = 256K
}

PHDRS {
    text PT_LOAD FLAGS(5);  /* RX: Readable, Executable */
    data PT_LOAD FLAGS(6);  /* RW: Readable, Writable */
    bss PT_LOAD FLAGS(6);   /* RW */
}

ENTRY(start)

SECTIONS {
    .text : {
        *(.text)
    } > FLASH :text

    .data : {
        __data_start = .;
        *(.data)
        __data_end = .;
    } > RAM :data

    .bss : {
        __bss_start = .;
        *(.bss)
        __bss_end = .;
    } > RAM :bss
}