; %FFILE%
;
; Copyright (C) %YEAR% %USER% <%MAIL%>

section .data
	SYS_READ  equ 0
	SYS_WRITE equ 1
	SYS_EXIT  equ 60

	STD_IN    equ 0
	STD_OUT   equ 1
	STD_ERR   equ 2

	text db "Hello, World!",10,0

section .text
	global _start

%macro exit 1
        mov rax, SYS_EXIT
        mov rdi, %1
        syscall
%endmacro


_start:
	mov rax, text
	call _print

	exit 0

; input: rax as pointer to string
; output: print string at rax
_print:
	push rax
	mov rbx, 0

_printLoop:
	inc rax
	inc rbx
	mov cl, [rax]
	cmp cl, 0
	jne _printLoop

	mov rax, SYS_WRITE
	mov rdi, STD_OUT
	pop rsi
	mov rdx, rbx
	syscall
	ret
