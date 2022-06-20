; This program performs a simple XOR base one-time pad educational demo
;
; Author: Josh McIntyre
;

; Program constants
PLAINTEXT equ 2
KEY equ 1

; Useful syscall constants
SYS_EXIT equ 1
SYS_WRITE equ 4
STDOUT equ 1
KERNEL equ 0x80

section .text
	global main
	extern printf

; The main entry point for the program
main:
	; Output an intro message
	mov edx, len_intro ; Intro message length
        mov ecx, intro ; Intro message
        call output

	; Output the plaintext
	mov edx, len_plaintext_msg_hdr
	mov ecx, plaintext_msg_hdr
	call output

	mov eax, PLAINTEXT
	call output_hexnum

	; Output the key
	mov edx, len_key_msg_hdr
	mov ecx, key_msg_hdr
	call output

	mov eax, KEY
	call output_hexnum

	; Output the ciphertext message
	mov edx, len_ciphertext_msg_hdr
	mov ecx, ciphertext_msg_hdr
	call output

	; Perform the one-time pad (XOR plaintext and key)
	mov eax, PLAINTEXT
	xor eax, KEY

	; Output the result
	; The ciphertext is already stored in eax
	call output_hexnum

	; Exit the program
	mov eax, SYS_EXIT ; sys_exit system call
	int KERNEL ; call the kernel

; A procedure for outputting messages to stdout
; Push msg length to edx
; Push msg to ecx
; Then call
output:
	mov ebx, STDOUT ; stdout file descriptor
	mov eax, SYS_WRITE ; sys_write system call
	int KERNEL ; call the kernel
	ret

; A procedure for outputting numberical messages via printf
; (C standard library)
; Push message to eax
; Then call
output_hexnum:
	push eax
	push hexfmt
	call printf
	add esp, 8
	ret
	
section .data
	intro db 'Simple XOR cipher program',0ah ; Title string
	len_intro equ $-intro ; Title string length

	plaintext_msg_hdr db 'Plaintext: ',0ah
	len_plaintext_msg_hdr equ $-plaintext_msg_hdr

	key_msg_hdr db 'One-time key (pad): ',0ah
	len_key_msg_hdr equ $-key_msg_hdr
	
	ciphertext_msg_hdr db 'Ciphertext: ',0ah
	len_ciphertext_msg_hdr equ $-ciphertext_msg_hdr

	hexfmt db "%#x", 10, 0

