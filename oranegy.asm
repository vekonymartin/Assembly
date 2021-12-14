
Code	Segment
	assume CS:Code, DS:Data, SS:Stack

Start:
	mov di, 82h
	mov cx, 10

Keres:
	mov dl, [di]
	cmp dl, "/"
	jz ParamKezdet

	inc di
	loop Keres
	jmp Default

ParamKezdet:
	inc di
	mov bl, [di]
	mov cx, 10
	mov ah, '0'
V1:
	cmp bl, ah
	jz F1
	inc ah
	loop V1

	jmp Err1
F1:
	sub bl, 48
	inc di

	mov bh, [di]
	mov cx, 10
	mov ah, '0'

V2:
	cmp bh, ah
	jz F2
	inc ah
	loop V2

	jmp Err2
F2:
	sub bh, 48

	mov ax, 10
	mul bl

	add al, bh
	mov cx, ax

	jmp Init

Err1:
	call Error_msg1

	jmp Default

Err2:
	call Error_msg2

	jmp Default

Default:
	mov cx, 5

Init:
	mov ax, Code
	mov DS, ax

	xor di, di
	xor si, si

	xor dx, dx
	push dx

Torles:
	mov ax, 03h
	int 10h

Rajz:
	mov bx, di
	mov dh, bl ; X
	mov bx, si
	mov dl, bl
	xor bh, bh ; Y
	mov ah, 02h
	int 10h

	mov dx, offset labda
	mov ah, 09h
	int 21h

	pop ax   ; ido az a veremben van kivesz
	push ax  ; visszament

	mov bl, al
	mul bl	
	shr ax, 1 	; 2-vel osztas
	shr ax, 1
	shr ax, 1	; 4-vel osztas
	mov di, ax 	; sor koordinata beallitasa
				; sx kiszamolsa v*t

	pop ax
	inc ax
	push ax		; ido kiment
	dec ax

	mov bl, cl
	mul bl		; al*bl (v*t)
	mov si, ax  ; oszlop koordinata beallit

	cmp si, 80  ; sorvegere ertunk
	jnc Var

	cmp di, 25  ; oszlop vegere ertunk
	jnc Var

	jmp Rajz

Var:
	xor ax, ax
	int 16h

Program_Vege:
	pop cx

	mov	ax, 4c00h
	int	21h
; ====================================
;			ERROR MESSAGE 1
; ====================================
Error_msg1:
	mov ax, 03h
	int 10h

	mov ax, Code
	mov DS, ax

	mov dx, offset error1
	mov ah, 09h
	int 21h

	xor ax, ax
	int 16h

	ret
; ====================================
;			ERROR MESSAGE 2
; ====================================
Error_msg2:
	mov ax, 03h
	int 10h

	mov ax, Code
	mov DS, ax

	mov dx, offset error2
	mov ah, 09h
	int 21h

	xor ax, ax
	int 16h

	ret
; ====================================

labda: db'o$'
error1: db'Hibas parameterrel nem tudok szamolni!',0ah,'(1. parameter hibas)$'
error2: db'Hibas parameterrel nem tudok szamolni!',0ah,'(2. parameter hibas)$'


Code	Ends

Data	Segment

Data	Ends

Stack	Segment

Stack	Ends
	End	Start

