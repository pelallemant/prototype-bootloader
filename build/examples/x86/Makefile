# Recursive Wildcard Function
rwildcard=$(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2) $(filter $(subst *,%,$2),$d))

-include ../prototype-bootloader.conf

all: 
	mkdir -p ../../../bin/examples/x86
	nasm -f elf -o ../../../bin/kernel_tmp ../../../examples/x86/kernel1.asm
	ld --oformat binary -m elf_i386 -Ttext 1000 -o ../../../bin/kernel ../../../bin/kernel_tmp
	cat ../../../bin/bootloader ../../../bin/kernel /dev/zero | dd of=../../../bin/examples/x86/kernel1 bs=512 count=2880

