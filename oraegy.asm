
Code	Segment
	assume CS:Code, DS:Data, SS:Stack

Start:
	mov ax, Code
	mov DS, ax

	call WEL		; WEL Function meghivasa ami a Program Vege utan talalhato

; ===================================
;		EGY SZOVEG KIIRATASA
; ===================================
SzovegKi:
	mov dx, offset elvalaszto		; 0ah -> sortores (space-el)
	mov ah, 09h
	int 21h

	mov dx, offset egykar
	mov ah, 09h
	int 21h

	mov ah, 02h
	mov dl, 41h		; A
	int 21h

	mov dx, offset elvalaszto
	mov ah, 09h
	int 21h

	mov dx, offset egykarsiman
	mov ah, 09h
	int 21h

	mov ah, 02h
	mov dl, 'A'
	int 21h

	mov dx, offset elvalaszto
	mov ah, 09h
	int 21h
; ===================================
;		EGY SZAM EGYSZERUEN
; ===================================
SzamKi:
	mov dx, offset separator
	mov ah, 09h
	int 21h

	mov dx, offset elvalaszto
	mov ah, 09h
	int 21h

	mov dx, offset egyszamsiman
	mov ah, 09h
	int 21h

	mov ah, 02h
	mov dl, 2
	int 21h

; ===================================
;	   EGY SZAM ASCII TABLA SZ.
; ===================================
	mov dx, offset elvalaszto
	mov ah, 09h
	int 21h

	mov dx, offset egyszamhex
	mov ah, 09h
	int 21h

	; ASCII CODE TABLE : 48 - 57 (0 1 2 3 4 5 6 7 8 9)

	mov ah, 02h
	mov dl, 48  ; 30h /  '0'  /  00110000b
	int 21h

	mov dx, offset elvalaszto
	mov ah, 09h
	int 21h

; ===================================
;		EGY SZAM ATALAKITASSAL
; ===================================
	mov dx, offset separator
	mov ah, 09h
	int 21

	mov dx, offset egyszam
	mov ah, 09h
	int 21h

	mov bl, 2   ; MOV cel, forras
	add bl, '0' ; 48d   (48 ... 57 = 0 ... 9)

	mov ah, 02h
	mov dl, bl 
	int 21h

	mov dx, offset elvalaszto
	mov ah, 09h
	int 21h

	mov dx, offset separator
	mov ah, 09h
	int 21h

; ===================================
;		EGY SZAM ATALAKITASSAL
; ===================================
	call SUBF
Feladat1:
	xor di, di
	mov di, offset fela1  ; sor beolvasasa
	inc di				  ; di novelese
	mov al, [di]		  ; beolvasott szoveg elso karakterenek kimentese az AL-be
	jmp Vizsgalat

Feladat2:
	xor di, di
	mov di, offset fela2
	inc di				
	mov al, [di]
	jmp Vizsgalat

Feladat3:
	xor di, di
	mov di, offset fela3
	inc di				
	mov al, [di]
	jmp Vizsgalat

Feladat4:
	xor di, di
	mov di, offset fela4
	inc di				
	mov al, [di]
	jmp Vizsgalat

Vizsgalat:
	cmp al, '+'
	jz ADDSUB

	cmp al, '-'
	jz SUBSUB

	cmp al, '*'
	jz MULSUB

	cmp al, '/'
	jz DIVSUB

	jmp Program_Vege

ADDSUB:
	call FEL1
	jmp Feladat2
SUBSUB:
	call FEL2
	jmp Feladat3
MULSUB:
	call FEL3
	jmp Feladat4
DIVSUB:
	call FEL4
	jmp Program_Vege

	jmp Program_Vege
; ===================================
	xor ax, ax		; Varakozas egy billentyuzet lenyomasara
	int 16h
Program_Vege:
	mov	ax, 4c00h
	int	21h

; ===================================
WEL:
	mov ax, 03h
	int 10h

	mov ah, 02h
	mov dl, 5	; X
	mov dh, 1	; Y
	mov bl, 28
	int 10h

	mov dx, offset tit
	mov ah, 09h
	int 21h

	mov ah, 02h
	mov dl, 0ah  ; sortores
	int 21h

	mov ah, 02h
	mov dl, 4
	mov dh, 2
	mov bl, 28
	int 10h

	mov dx, offset separator
	mov ah, 09h
	int 21h

	mov ah, 02h
	mov dl, 0ah
	int 21h

	ret
; ===================================
; ===================================
SUBF:
	mov ah, 02h
	mov dl, 10
	mov dh, 11
	mov bl, 28
	int 10h

	mov dx, offset task
	mov ah, 09h
	int 21h

	mov ah, 02h
	mov dl, 0ah
	int 21h

	mov ah, 02h
	mov dl, 0
	mov dh, 12
	mov bl, 28
	int 10h

	ret
; ===================================
; ===================================
FEL1:
	mov dx, offset fela1
	mov ah, 09h
	int 21h

	xor dx, dx 		; dx uritese

	mov di, offset fela1
	mov al, [di]

	inc di
	inc di

	mov bl, [di]
	add al, bl

	sub al, '0'

	mov ah, 02h
	mov dl, al
	int 21h

	mov ah, 02h
	mov dl, 0ah
	int 21h

	ret

; ===================================
; ===================================
FEL2:
	mov dx, offset fela2
	mov ah, 09h
	int 21h

	xor dx, dx
	
	mov di, offset fela2
	mov al, [di]

	inc di
	inc di

	mov bl, [di]

	sub al, bl

	add al, '0'

	mov ah, 02h
	mov dl, al
	int 21h

	mov ah, 02h
	mov dl, 0ah
	int 21h

	ret
; ===================================
; ===================================
FEL3:
	mov dx, offset fela3
	mov ah, 09h
	int 21h

	xor dx, dx
	
	mov di, offset fela3
	xor ax, ax
	mov al, [di]
	sub al, 48

	inc di
	inc di

	mov bl, [di]
	sub bl, 48
	mul bl

	mov cx, ax

	add cl, '0'

	mov ah, 02h
	mov dl, cl
	int 21h

	mov ah, 02h
	mov dl, 0ah
	int 21h

	ret
; ===================================
; ===================================
FEL4:
	mov dx, offset fela4
	mov ah, 09h
	int 21h

	xor dx, dx
	
	mov di, offset fela4
	xor ax, ax
	mov al, [di]
	sub al, 48

	mov bl, [di+2]
	sub bl, 48

	div bl

	mov cx, ax

	add cl, 48

	mov ah, 02h
	mov dl, cl
	int 21h

	mov ah, 02h
	mov dl, 0ah
	int 21h

	ret
; ===================================


tit: 				db'ORA EGY GYAKORLO FELADATA$'
task:				db'PELDA FELADATOK$'
fela1:				db'2+2 = $'
fela2:				db'3-2 = $'
fela3:				db'3*2 = $'
fela4:				db'9/3 = $'
teszt: 				db 0ah,' teszt szoveg.$'
egykar:				db"Egy karakter kiiratasa hex-ben: $"
egykarsiman:		db"Egy karakter kiiratasa egyszeruen: $"
egyszamsiman:		db"Egy szam kiiratasa egyszeruen: $"
egyszamhex:			db"Egy szam kiiratasa egyszeruen: $"
egyszam:			db"Egy szam kiiratasa alakitgatassal: $"
elvalaszto:			db 0ah,'$'
separator: 			db'===========================$'

Code	Ends

Data	Segment

Data	Ends

Stack	Segment

Stack	Ends
	End	Start

