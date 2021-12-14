Code	Segment
	assume CS:Code, DS:Data, SS:Stack

Start:
	mov di, 82h
	mov al, [di]
	cmp al, ' '
	jz Default
	sub al, 48
	
	mov bl, 10
	mul bl 
	
	inc di
	mov bl, [di]
	sub al, 48
	
	add al, bl

	mov si, ax
	push ax
Init:
	mov	ax, Code
	mov	DS, AX

	mov ax, 03h
	int 10h
	
	mov di, 0
	pop ax
	mov cx, ax

	jmp Kesleltetes

Default:
	mov	ax, Code
	mov	DS, AX

	mov ax, 03h
	int 10h
	
	mov di, 0
	mov cx, 20

	jmp Kesleltetes
Kiir:
	mov ah, 02h
	mov dl, "x"
	int 21h
	;loop Kiir
	
Kesleltetes:
	mov ah, 01h
	int 16h
	jz nincsbill

	cmp al, 27
	jz Program_Vege
	
nincsbill:
	xor ah, ah
	int 1ah
	pop cx
	push cx
	mov ax, dx
	sub dx, cx
	push ax
	mov al, 18
	
	xor ah, ah
	cmp dx, ax
	pop ax
	jc Kesleltetes
	pop cx
	push ax
	
	cmp si, di
	jz Lefele

	dec si
	jmp Kiir

Lefele:
	;mov bl, si
	mov si, 1
	mov bl, 0

	mov cl, 5
;Lefele_ki:
;	mov ah, 02h
;	mov dx, di  ; 16 bites regisztert hasznalunk
;	mov dh, bl  ; pozicio di sor (8 bites)
;	mov dl, bl ; pozicio 40. oszlop
;	xor bh, bh
;	int 10h

;	mov ah, 02h
;	mov dl, 'x'
;	int 21h

;	inc bl
;	loop Lefele_ki

	
Program_Vege:
	mov	ax, 4c00h
	int	21h

Code	Ends

Data	Segment

Data	Ends

Stack	Segment

Stack	Ends
	End	Start
