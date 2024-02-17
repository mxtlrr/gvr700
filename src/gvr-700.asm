[bits 16]
[org 0x7c00]

jmp Start
nop

db "NTFS    "		;; OEM ID
dw 0x0200				;; Bytes per secctor
db 0x08					;; Sectors per cluster
dw 0						;; Reserved sectors

;; Unused
dd 0
db 0		;; 4 + 1 = 5

db 0xf8		;; Media descriptor
dw 0			;; Unused
dw 003fh	;; Sectors per track
dw 00ffh	;; Number of heads / drive
dd 0x0000003F   ;; Hidden sectors
dd 0						;; Unused
dd 0x00800080   ;; Unused
dq 0x00000000007FF54A	;; Total sectors

;;; !!!!! MFT STUFF !!!!!
;;; See (#1). Change later.
dq 0x0000000000000004		;; $MFT cluster number
dq 0x000000000007FF54		;; Backup MFT
;; !!!!!! END MFT !!!!!!

dd 0xf6
dd 0x00000001 ;; Unused (first 3 bytes) and then Bytes or Clusters
							;; per index buffer
db 0x00
db 0x00
db 0x00	;; Unused
dq 0x1C741BC9741BA514 ;; Volume serial number, maybe change
dd 0x00000000					;; "Checksum"

;; End of the PBS. We can now do stuff
Start:

jmp $
printf:
	push ax
	push bx

	mov ah, 0x0e
	.Loop:
		cmp [bx], byte 0
		je .Exit					;; null terminator, exit

		mov al, [bx]
		int 0x10
		inc bx
		jmp .Loop
	.Exit:
		pop bx
		pop ax
		ret
	ret


times 510-($-$$) db 0
dw 0xaa55