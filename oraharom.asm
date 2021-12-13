Code    Segment
    assume CS:Code, DS:Data, SS:Stack

Start:
    mov di, 82h  ; program futasakor megadott parameter pl: oraharom -i
	mov bl, [di] ; megadott parameter kimentese a BL-be

    cmp bl, '-'  ; a megadott parameter '-' jel-e?
    jnz M		 ; ha nem akkor betolti a menut 

    jmp Vizsgal  ; ha igen, akkor megvizsgaljuk a masodik parametert

Vizsgal:
    mov bl, [di+1] ; masodik parameter vizsgalata
    cmp bl, 'i'	   ; a megadott parameter 'i' jel-e?
    jnz E		   ; ha nem akkor az E Subr.-ra ugrik
    jmp I		   ; ha igen akkor az I Subr.-re ugrik

E:
    call Err	   ; Err meghivasa
 
    jmp M
I:
    call Inform	   ; Inform meghivasa

    jmp M

M:
	mov ax, Code
    mov DS, ax

	call MENU

	xor ax, ax		; Felhasznalotol var egy billentyut
	int 16h

	cmp al, 27		; ha ESC, akkor a Vege1-hez ugrik
	jz Vege1

	cmp al, '1'		; ha 1, akkor a Feldolgoz1-hez ugrik
	jz Feldolgoz1

	cmp al, '2'		; ha 2, akkor a Feldolgoz2-hoz ugrik
	jz Feldolgoz2

	jmp M

;---------------------------------
; SZAM 1 
Feldolgoz1:
    mov ax, Code
    mov DS, ax

    mov ax, 03h		; kepernyo torlese
    int 10h

    mov dx, offset fela1 ; fela1 kiirasa
    mov ah, 09h
    int 21h

    mov ah, 02h		; sortores
    mov dl, 0ah
    int 21h

    mov di, offset ertek1 ; ertek1 kimentese a di-be

Bevitel1:
    mov dx, offset ertek1
	mov ah ,09h
	int 21h

    xor ax, ax  ;Bevitel
    int 16h
	
	cmp al, 27
	jz V_Menu
	
	mov ah, 02h
	mov dl, 0	; X
	mov dh, 1	; Y
	mov bl, 0
	int 10h
    

	mov cx, 10  ; "0-9"
	mov ah, '0'

Vizsg1:
	cmp al, ah
	jz Tarol1
	inc ah
	loop Vizsg1
                ; hamis feltétel esetén fut tovább a program
	call Hib

    jmp Bevitel1

Tarol1:              ;di regiszter tartalma az ertek címke offset memória címe
	mov [di], al    ;kiírjuk a leütött billentyű ASCII értékét a memóriába  
    inc di          ;növeljük az offset címet
    mov al, '$'     ;kiírunk egy karaktersorozatot lezáró vezérlő karaktert
    mov [di], al

    mov ax, offset ertek1
    add ax, 4
    cmp ax, di
    jnz Bevitel1 ;még nem ütöttünk le 4 numerikus billentyűt, kezdőcím+4 nagyobb mint az utolsó tárolt karakter címe
                ;egyébként tovább fut a program

    mov ax, 03h
    int 10h

    jmp V_Menu 

Vege1:
	jmp Program_Vege

V_Menu:
	jmp M
;---------------------------------
; SZAM 2
Feldolgoz2:
    mov ax, Code
    mov DS, ax

    mov ax, 03h
    int 10h

    mov dx, offset fela2
    mov ah, 09h
    int 21h

    mov ah, 02h
    mov dl, 0ah
    int 21h

    mov di, offset ertek2

Bevitel2:
    mov dx, offset ertek2
	mov ah ,09h
	int 21h

    xor ax, ax  ;Bevitel
    int 16h
	
	cmp al, 27
	jz V_Menu
	
	mov ah, 02h
	mov dl, 0
	mov dh, 1
	mov bl, 0
	int 10h

	mov cx, 10  ; "0-9"
	mov ah, '0'

Vizsg2:
	cmp al, ah
	jz Tarol2
	inc ah
	loop Vizsg2
                ; hamis feltétel esetén fut tovább a program
	call Hib

    jmp Bevitel2

Tarol2:             ;di regiszter tartalma az ertek címke offset memória címe
	mov [di], al    ;kiírjuk a leütött billentyű ASCII értékét a memóriába  
    inc di          ;növeljük az offset címet
    mov al, '$'     ;kiírunk egy karaktersorozatot lezáró vezérlő karaktert
    mov [di], al

    mov ax, offset ertek2
    add ax, 4
    cmp ax, di
    jnz Bevitel2 ;még nem ütöttünk le 4 numerikus billentyűt, kezdőcím+4 nagyobb mint az utolsó tárolt karakter címe
                ;egyébként tovább fut a program

    mov ax, 03h
    int 10h

    jmp V_Menu 

Program_Vege:
    mov ax, 4c00h
    int 21h

; ===================================
;           MENU KIIRASA
; ===================================
Menu:
	mov ax, 03h
	int 10h

	mov dx, offset menu_cim
	mov ah, 09h
	int 21h

	mov dx, offset menu_szoveg1
	mov ah, 09h
	int 21h

	mov dx, offset menu_szoveg2
	mov ah, 09h
	int 21h

	mov dx, offset menu_szoveg3
	mov ah, 09h
	int 21h

	ret
; ===================================
;           ERROR KIIRASA
; ===================================
Err:
    mov ax, Code
    mov DS, ax

    mov ax, 03h
    int 10h

    mov ah, 02h
    mov dl, 15
    mov dh, 1
    mov bl, 0
    int 10h

    mov dx, offset error
    mov ah,  09h
    int 21h

    xor ax, ax 
    int 16h

    mov ah, 02h
    mov dl, 0
    mov dh, 0
    mov bl, 0
    int 10h

    mov ax, 03h
    int 10h

    ret
; ===================================
;           INFO KIIRASA
; ===================================
Inform:
    mov ax, Code
    mov DS, ax

    mov ax, 03h
    int 10h

    mov ah, 02h
    mov dl, 15
    mov dh, 1
    mov bl, 0
    int 10h

    mov dx, offset info
    mov ah, 09h
    int 21h

    xor ax, ax 
    int 16h

    mov ah, 02h
    mov dl, 0
    mov dh, 0
    mov bl, 0
    int 10h

    mov ax, 03h
    int 10h

    ret
	
; ===================================
;           HIBA KIIRASA
; ===================================
Hib:
	mov ax, 03h
	int 10h
	
	mov ah, 02h
	mov dl, 0
	mov dh, 10
	mov bh, 0
	int 10h
	
	mov dx, offset hiba
	mov ah, 09h
	int 21h
	
	xor ax, ax
	int 16h	

    mov ax, 03h
	int 10h
	
	ret
; ===================================
;           VEGE KIIRASA
; ===================================
Vege:
    mov ax, 03h
	int 10h
	
	mov ah, 02h
	mov dl, 0
	mov dh, 0
	mov bh, 0
	int 10h

    mov dx, offset uzenet
    mov ah, 09h
    int 21h

    ret
; ===================================

menu_cim: db'MENU',0ah,'$'

menu_szoveg1: db'1 - szam1',0ah,'$'

menu_szoveg2: db'2 - szam2',0ah,'$'

menu_szoveg3: db'ESC - kilepes',0ah,'$'

info:  db'A program csak negyjegyu szamot fogadhat el$'

ertek1: db'****$'
ertek2: db'****$'

hiba:  db'Nem megengedett karakter$',0ah,'nyomj egy gombot a folytatashoz$'

uzenet:db'Vege a bevitelnek$'

error: db'Nincs ilyen segito opcio$'

fela1:  db'1 szam - Kerek 4 szamot$'

fela2:  db'2 szam - Kerek 4 szamot$'

Code    Ends

Data    Segment

Data    Ends

Stack   Segment

Stack   Ends
    End Start