# Recursive Wildcard Function
rwildcard=$(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2) $(filter $(subst *,%,$2),$d))

-include ../prototype-bootloader.conf

all: build examples

build:
	mkdir -p ../bin
# compile the bootloader
	nasm -f bin -o ../bin/bootloader -dKERNEL_SECTORS=$(KERNEL_SECTORS) ../src/x86/bootloader.asm

examples:
	cd examples/x86 && $(MAKE)

clean:
	rm -rf ../bin

mrproper: clean

.PHONY: examples
