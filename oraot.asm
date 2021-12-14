
Code	Segment
	assume CS:Code, DS:Data, SS:Stack

Start:
	mov ax, Code
	mov DS, ax

	mov ax, 03h
	int 10h

	xor di, di  ; labda helye (sor)
	mov si, 1   ; lefele indul a labda (irany vektor)
	xor dx, dx
	push dx		; verem regi ido (most 0)

	mov cl, 0

Torles:
	;mov ax, 03h
	;int 10h

; Kurzor pozicionalasa
	mov ah, 02h
	mov dx, di  ; 16 bites regisztert hasznalunk
	mov dh, dl  ; pozicio di sor (8 bites)
	mov dl, 40  ; pozicio 40. oszlop
	xor bh, bh
	int 10h

; Labda kirakasa
	mov dx, offset labda
	mov ah, 09h
	int 21h


; Billentyu figyeles
Kesleltet:
	; ---------------
	; idozites nelkul
	mov ah, 01h   
	int 16h

	;cmp al, 27
	;jz Program_Vege
	; ---------------
	; idozitessel

	; ha van leütött billentyű, tehát
	; nem üres a billentyűzet puffer, akkor Z flag értéke 0
	jz nincsbill
	mov ah, 00h
	int 16h
	cmp al, 27
	jz Program_Vege
nincsbill:

; Ora beolvasasa
	xor ah, ah
	int 1ah    ; ora beolvasasa CX:DX-be

; Eltelt ido kiszamitasa (T eltelt)
	pop cx	   ; regi ido kivetele
	push cx    ; regi ido visszatetele
	mov ax, dx ; aktualis ido mentese ax-be
	sub dx, cx ; dx-ben a T eltelt = T aktualis - T regi
	push ax	   ; aktualis ido mentese a verembe

; Poz < 5
	cmp di, 5
	jnc	Ido1
	mov al, 16
	jmp Beallit

Ido1:
; Poz < 10
	cmp di, 10
	jnc Ido2
	mov al, 8
	jmp Beallit

Ido2:
; Poz < 15
	cmp di, 15
	jnc Ido3
	mov al, 4
	jmp Beallit

Ido3:
; Poz < 20
	cmp di, 20
	jnc Ido4
	mov al, 2
	jmp Beallit

Ido4:
	mov al, 1   ; (egyebkent 21-24)

Beallit:
; T eltelt > delta T?
	xor ah, ah
	cmp dx, ax

	pop ax		; az elozo ido aktualizalasahoz kell

	jc	Kesleltet

; Elozo ido aktualizalasa
	pop cx		; regi ido kivetele a verembol
	push ax     ; aktualis ido elmentese

; Poz = 0 ?
	cmp di, 0
	jz lefele

; Poz = 24 ?
	cmp di, 24
	jz felfele

Mozgas:
	call RegiTor
	add di, si	; a labda uj pozicioja
	jmp Torles

; Irany beallitasa (LE)
lefele:
	mov si, 1
	jmp Mozgas

; Irany beallitasa (FEL)
felfele:
	mov si, -1
	jmp Mozgas

Program_Vege:
	pop cx ; vermet úgy adjuk vissza, ahogy
		   ; kaptuk! A verembe maradt értéket egy „szemét”-regiszterbe
		   ; kitesszük!
	mov	ax, 4c00h
	int	21h

RegiTor:
	mov ah, 02h
	mov dx, di  ; 16 bites regisztert hasznalunk
	mov dh, dl  ; pozicio di sor (8 bites)
	mov dl, 40  ; pozicio 40. oszlop
	xor bh, bh
	int 10h

; Labda kirakasa
	mov dx, offset labda_e
	mov ah, 09h
	int 21h

	ret

labda: db'O$'
labda_e: db' $'
Code	Ends

Data	Segment

Data	Ends

Stack	Segment

Stack	Ends
	End	Start

