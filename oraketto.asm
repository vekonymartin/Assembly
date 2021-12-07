
Code	Segment
	assume CS:Code, DS:Data, SS:Stack

Start:
	mov ax, Code
	mov DS, ax

Kiir:
	mov ax, 03h
	int 10h

	mov ah, 02h
	mov dl, 5
	mov dh, 2
	mov bl, 28
	int 10h

	mov dx, offset uzenet1
	mov ah, 09h
	int 21h

	mov dx, offset szamlalotizes
	mov ah, 09h
	int 21h

	mov dx, offset szamlaloegyes
	mov ah, 09h
	int 21h

	mov dx, offset uzenet2
	mov ah, 09h
	int 21h

Bevitel:
	xor ax, ax
	int 16h

	cmp al, 27
	jz Program_Vege

	cmp al, 'a'
	jz Szamol

	cmp al, 'd'
	jz Csokkent
	jmp Bevitel

Szamol:
	mov di, offset szamlaloegyes
	mov al, [di]

	inc al
	mov [di], al
	cmp al, ':'
	jz Szamoltizes

	jmp Kiir

Szamoltizes:
	mov al, '0'
	mov [di], al

	mov di, offset szamlalotizes
	mov al, [di]
	inc al
	mov [di], al

	cmp al, ':'
	jz Program_Vege

	jmp Kiir

Csokkent:	
	mov di, offset szamlaloegyes
	mov al, [di]
	dec al
	mov [di], al

	cmp al, '/'
	jz Csokkenttizes

	jmp Kiir

Csokkenttizes:
	mov al, '9'
	mov [di], al

	mov di, offset szamlalotizes
	mov al, [di]
	dec al
	mov [di], al

	cmp al, '/'
	jz Program_Vege

	jmp Kiir

Program_Vege:
	mov	ax, 4c00h
	int	21h

szamlaloegyes: db'0$'
szamlalotizes: db'0$'
uzenet1: db'Az a billentyu $'
uzenet2: db' alkalommal volt leutve.$'

Code	Ends

Data	Segment

Data	Ends

Stack	Segment

Stack	Ends
	End	Start

