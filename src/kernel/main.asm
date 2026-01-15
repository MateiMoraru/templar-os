org 0x7C00
bits 16

%define ENDL 0x0D, 0x0A

start:
	jmp main

; Prints a string
; Params: 
;	-ds:si points to string

puts:
	; save registers to modify
	push si
	push ax
	push bx
	
.loop:
	lodsb			;loads nex char in al
	or al, al		;verify if next character is null
	jz .done

	mov ah, 0x0e 	; call bios interrupt
	mov bh, 0
	int 0x10

	jmp .loop
	
.done:
	pop bx
	pop ax
	pop si
	ret

	
main:
	; setup data seg
	mov ax, 0 		; cant write to ds/es directly
	mov ds, ax
	mov es, ax

	mov ss, ax
	mov sp, 0x7C00 	; stack grows downwords ig

	; print message
	mov si, msg_hello
	call puts
	
	hlt

.halt:
	jmp .halt

msg_hello: db 'Hello world', ENDL, 0

times 510-($-$$) db 0
dw 0AA55h
