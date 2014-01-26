# Recursive Wildcard Function
rwildcard=$(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2) $(filter $(subst *,%,$2),$d))

CFLAGS= -fno-stack-protector

# Sources
C_SRC=$(call rwildcard, ../../../examples/x86/kernel1/, *.c)
ASM_SRC=$(call rwildcard, ../../../examples/x86/kernel1/, *.asm)

C_OBJ=$(C_SRC:.c=.o)
ASM_OBJ_TMP=$(ASM_SRC:.asm=)

ASM_OBJ=$(filter-out ../../../examples/x86/kernel1/kernel,$(ASM_OBJ_TMP))

all: $(C_OBJ) $(ASM_OBJ)
	mkdir -p ../../../bin/examples/x86
	nasm -f elf -o ../../../bin/kernel_tmp ../../../examples/x86/kernel1/kernel.asm
	ld --oformat binary -m elf_i386 -Ttext 1000 -o ../../../bin/kernel ../../../bin/kernel_tmp $(C_OBJ) $(ASM_OBJ)
	cat ../../../bin/bootloader ../../../bin/kernel /dev/zero | dd of=../../../bin/examples/x86/kernel1 bs=512 count=2880

%.o: %.c
	gcc -m32 -c -o $@ $< $(CFLAGS)

%: %.asm
	nasm -f elf -o $@ $<

