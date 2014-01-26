Prototype Bootloader
====================

[![Build Status](https://travis-ci.org/pelallemant/prototype-bootloader.png?branch=master)](https://travis-ci.org/pelallemant/prototype-bootloader)

This is the first parametrable bootloader of Prototype-OS.

Warning: The kernel is expected to be concatenated to the bootloader, this bootloader works only for floppy disk images.

A parametrable interface has been written, which allows you to know the machine configuration (memory for example).

You can write your kernel with:

- x86
- C

You must configure the file `prototype-bootloader.conf` to renseign the size of your kernel.


PB Compilation
==============

- configure `prototype-bootloader.conf`
- cd build && make

Your Kernel Compilation
=======================

If the kernel is written in x86: use `[ORG 0x1000]`

If the kernel is written in C: use `gcc -m32 -c -o kernel.o kernel.c` and `ld --oformat binary -m elf_i386 -Ttext 1000 kernel.o $(YOUR_ASM_OBJ) $(YOUR_C_OBJ) -o kernel`

Creating a bootable kernel (for floppy)
=======================================

`cat bin/bootsect your_kernel /dev/zero | dd of=floppyA bs=512 count=2880`

And use "floppyA".
