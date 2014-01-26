; %define KERNEL_SECTORS ; sector counts to load (1 sector = 512 bytes)
%define BASE 0x100

[BITS 16] ; MBR is written in 16bits
[ORG 0x0]

jmp start

start:

; Notes:
; - The CPU (i386) is currently in real mode
; - The BIOS loaded the bootloader (512 bytes) in 0x7C00

; ############################################################
; initialize the segments to the adress 0x07C0:0X0 = 0x7C00
; ############################################################
    mov ax, 0x07C0   ; 0x07C0:0000 = 0x07C00 -> real mode adress
    mov ds, ax
    mov es, ax
    mov ax, 0x8000 ; stack in 0xFFFF
    mov ss, ax
    mov sp, 0xf000

; ####################################
; getting the boot drive into bootdrv 
; ####################################
    mov [bootdrv], dl  ; dl is written into bootdrv

; ################################
; loading the kernel into the RAM
; ################################

; first call to a BIOS INTERUPT: init
    xor ax, ax   ; ax = 0x0000 => now ah = 0x00
    int 0x13     ; BIOS INTERUPT: int 0x13 with ah=0x0: Reset Disk Drive

; second call to a BIOS INTERUPT: copy the kernel
    push es           ; save "extra segment" register state
    mov ax, BASE      
    mov es, ax        ; "mov es, BASE" doesn't exists
    mov bx, 0         ; es:bx -> buffer adress pointer BASE:0x0
    mov ah, 2         ; 0x02
    mov al, KERNEL_SECTORS     ; sectors to read count
    mov ch, 0         ; cylinder
    mov cl, 2         ; sector
    mov dh, 0         ; head
    mov dl, [bootdrv] ; dl = drive
    int 0x13          ; BIOS INTERUPT: int 0x13 with ah = 0x02: Read Sectors From Drive
    pop es            ; load es state

; jump to kernel
    jmp dword BASE:0

; ---------------------------------

bootdrv:  db 0

