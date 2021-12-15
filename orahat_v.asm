
Code	Segment
	assume CS:Code, DS:Data, SS:Stack

Start:
	mov ax, Code
	mov DS, ax

	mov dl, 100		; X
	mov dh, 100		; Y
	push dx

	mov ax, 13h		; Grafikus uzemmodba valtas - eleje
	int 10h

	mov ax, 0a000h	; Video kezdocime
	mov es, ax		; extra segmens
					; Grafikus uzemmodba valtas - vege
	mov cl, 1		; szin miatt van letrehozva es a legelso szin erteke van beallitva

; Pixel = Y * 320 + X
Rajz:
	pop dx			; dx-ben Y(dh), X(dl) koordináta
	xor ah, ah
	mov al, dh		; ax-ben Y koordináta
	push dx			; dx mentése, mul utasítás felülírja
	mov bx, 320
	mul bx			; Y koordináta * 320
	pop dx			; dx-ben Y(dh), X(dl) koordináta
	add al, dl		; X koordináta hozzáadása
	jnc Pixel
	inc ah			; van átvitel

Pixel:
	push dx
	
	mov di, ax
	mov al, cl			; pixel színe
	mov es:[di], al		; videó memóriába beállítja a megfelelő pixel színét

Var:
	xor ah, ah
	int 16h

	cmp al, 27
	jz Vege

; --------------------
; SZIN BEALLITASA
	cmp ah, 11
	jz Nulla

	cmp ah, 02
	jz Egy

	cmp ah, 03
	jz Ketto

	cmp ah, 04
	jz Harom

	cmp ah, 05
	jz Negy

	cmp ah, 06
	jz Ot

	cmp ah, 07
	jz Hat

	cmp ah, 08
	jz Het

	cmp ah, 09
	jz Nyolc

	cmp ah, 10
	jz Kilenc
; --------------------

	cmp ah, 75
	jz Balra

	cmp ah, 77
	jz Jobbra

	cmp ah, 72
	jz Felfele

	cmp ah, 80
	jz Lefele

	jmp Var

Vege:
	jmp Program_Vege
; --------------------
; SZIN BEALLITASA
Nulla:
	mov cl, 0
	jmp Var
Egy:
	mov cl, 25
	jmp Var
Ketto:
	mov cl, 50
	jmp Var
Harom:
	mov cl, 75
	jmp Var
Negy:
	mov cl, 100
	jmp Var
Ot:
	mov cl, 125
	jmp Var
Hat:
	mov cl, 150
	jmp Var
Het:
	mov cl, 175
	jmp Var
Nyolc:
	mov cl, 200
	jmp Var
Kilenc:
	mov cl, 225
	jmp Var
; --------------------
Balra:
	pop dx
	dec dl
	cmp dl, 1
;	jnc Tarol1
	jnc Tarol
	inc dl
	jmp Tarol

;Tarol1:
;	push dx
;	jmp Rajz

Jobbra:
	pop dx
	inc dl
	cmp dl, 250
;	jc Tarol2
	jc Tarol
	dec dl
	jmp Tarol

;Tarol2:
;	push dx
;	jmp Rajz

Felfele:
	pop dx
	dec dh
	cmp dh, 1
	;jnc Tarol3
	jnc Tarol
	inc dh
	jmp Tarol

;Tarol3:
;	push dx
;	jmp Rajz

Lefele:
	pop dx
	inc dh
	cmp dh, 200
	;jc Tarol4
	jc Tarol
	dec dh
	jmp Tarol

;Tarol4:
;	push dx
;	jmp Rajz

Tarol:
	push dx
	jmp Rajz

Program_Vege:
	mov ax, 03h
	int 10h
	pop dx

	mov	ax, 4c00h
	int	21h

Code	Ends

Data	Segment

Data	Ends

Stack	Segment

Stack	Ends
	End	Start

