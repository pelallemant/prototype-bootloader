# Recursive Wildcard Function
rwildcard=$(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2) $(filter $(subst *,%,$2),$d))

CFLAGS= -fno-stack-protector

all: 
	rm -f ../../../bin/kernel ../../../bin/kernel_tmp.o
	mkdir -p ../../../bin/examples/C
	gcc -m32 -c -o ../../../bin/kernel_tmp.o ../../../examples/C/kernel1.c $(CFLAGS)
	ld --oformat binary -m elf_i386 -Ttext 1000 -o ../../../bin/kernel ../../../bin/kernel_tmp.o
	cat ../../../bin/bootloader ../../../bin/kernel /dev/zero | dd of=../../../bin/examples/C/kernel1 bs=512 count=2880

