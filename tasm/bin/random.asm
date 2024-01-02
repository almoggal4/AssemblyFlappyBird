
RANDPRIME    equ    401

segment    biosdata    at 40h
    org    6ch
timer      dw    ?    ; clock ticks; if this line is in the dateseg the high of pipes is the same 
ends

; קלט – אין
; פלט – ax שבעל ערך מסויים לפי השעון.
; הערה: נקראת על ידי random

proc    timeticks;puts in ax a random value, using time tickets and clock interapt
    push   es
	
	;call time
    mov    ax, biosdata
    mov    es, ax
    assume es:biosdata
	mov ah,2ch
	int 21h
	mov [timer],dx
    mov    ax, [timer]

    assume es:nothing

    pop    es
    ret
endp

; קלט – שניות בשעון.
; פלט – מספר רנדומלי בגודל 8 ביט בal
; הערה: נקראת על ידי randomnumber וקוראת לtimeticks

proc    random
    push   dx
    push   bx
    mov    bx, [lastrand]
    mov    ax, bx
    mov    dx, RANDPRIME
    mul    dx
    mov    dx, ax
    call   timeticks
    xor    ax, dx
    xchg   dh, dl
    xor    ax, dx
    xchg   bh, bl
    xor    ax, bx
    mov    ah,0
    pop    bx
    pop    dx
    ret
 endp
 ; קלט – מספר בגודל 8 ביט.
;פלט – ax, מספר בין 26-90
; הערה: קוראת לפרוצדורה random

 proc randomnumber
	push bp
	mov bp, sp
	
	call random
	mov si,0
	mov si,ax
	mov ax,[randomarray+si]
	cmp ax,90
	jl endofrandom
	mov ax,60
	
endofrandom:	
	
	pop bp
	ret 
endp randomnumber

