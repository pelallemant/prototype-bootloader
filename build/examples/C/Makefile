# Recursive Wildcard Function
rwildcard=$(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2) $(filter $(subst *,%,$2),$d))

CFLAGS= -fno-stack-protector

# Sources
C_SRC=$(call rwildcard, ../../../examples/C/kernel1/, *.c)
ASM_SRC=$(call rwildcard, ../../../examples/C/kernel1/, *.asm)

C_OBJ_TMP=$(C_SRC:.c=.o)
ASM_OBJ=$(ASM_SRC:.asm=)

C_OBJ=$(filter-out ../../../examples/C/kernel1/kernel.o,$(C_OBJ_TMP))

all: build clean

build: $(C_OBJ) $(ASM_OBJ)
	rm -f ../../../bin/kernel ../../../bin/kernel_tmp.o
	mkdir -p ../../../bin/examples/C
	gcc -m32 -c -o ../../../bin/kernel_tmp.o ../../../examples/C/kernel1/kernel.c $(CFLAGS)
	ld --oformat binary -m elf_i386 -Ttext 1000 -o ../../../bin/kernel ../../../bin/kernel_tmp.o $(C_OBJ) $(ASM_OBJ)
	cat ../../../bin/bootloader ../../../bin/kernel /dev/zero | dd of=../../../bin/examples/C/kernel1 bs=512 count=2880
	rm ../../../bin/kernel_tmp.o


%.o: %.c
	gcc -m32 -c -o $@ $< $(CFLAGS)

%: %.asm
	nasm -f elf -o $@ $<

clean:
	rm -f $(C_OBJ)
	rm -f $(ASM_OBJ)

