
Code	Segment
	assume CS:Code, DS:Data, SS:Stack

Start:
ParamDolgoz:
	mov di, 82h
	mov bl, [di]
	cmp bl, '-'
	jnz Default

	mov cl, [di+1]
	mov bh, [di+2]

	cmp bh, 48
	jc Hiba

	sub bh, 48
	sub cl, 48

	xor ax, ax
	mov ax, cx
	mov bl, 10
	mul bl

	add al, bh
	mov cl, al

	jmp RajzInit

Hiba:
	mov ax, Code
	mov DS, ax

	mov dx, offset hibakod
	mov ah, 09h
	int 21h

	jmp Program_Vege

Default:
	mov ax, Code
	mov DS, ax
	mov cl, 128

RajzInit:
	mov ax, Code
	mov DS, ax
	mov dl, 100
	mov dh, 100
	push dx
	xor ax, ax
	mov ax, 13h
	int 10h

	mov ax, 0a000h
	mov es, ax

Rajz:
	pop dx
	xor ah, ah
	mov al, dh
	push dx
	mov bx, 320
	mul bx
	pop dx
	add al, dl
	jnc Pixel
	inc ah

Pixel:
	push dx
	mov di, ax
	mov al, cl
	mov es:[di], al

Var:
	xor ah, ah
	int 16h

	cmp al, 27
	jz Program_Vege

	cmp ah, 75
	jz Balra

	cmp ah, 77
	jz Jobbra

	cmp ah, 72
	jz Felfele

	cmp ah,80
	jz Lefele

	cmp al, "$"
	jz PixelAllit

	jmp Var

PixelAllit:
	add cl, 10
	jmp Pixel

Balra:
	pop dx
	dec dl
	cmp dl, 1
	jnc Tarol
	inc dl
	jmp Tarol

Jobbra:
	pop dx
	dec dl
	cmp dl, 255
	jnc Tarol
	dec dl
	jmp Tarol

Felfele:
	pop dx
	dec dl
	cmp dl, 1
	jnc Tarol
	inc dh
	jmp Tarol

Lefele:
	pop dx
	dec dh
	cmp dl, 200
	jnc Tarol
	inc dh
	jmp Tarol

Tarol:
	push dx
	jmp Rajz

Program_Vege:
	xor ax, ax
	xor bx, bx
	xor cx, cx
	xor dx, dx
	xor di, di
	
	xor ax, ax
	int 16h
	mov	ax, 4c00h
	int	21h

hibakod: db 'error$'

Code	Ends

Data	Segment

Data	Ends

Stack	Segment

Stack	Ends
	End	Start

