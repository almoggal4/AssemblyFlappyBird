;prints the high score,current score and final score

MaxDigits 	EQU 5d			;Word is 0-65535 - 5 digits.
Ten			EQU 10d			
Zero		EQU 0d
ZeroC		EQU '0'
VideoSeg	EQU 0A000h		;Video Segment for direct access.
VideoSiz	EQU 0FA00h		;320X200=FA00h pixels total on screen.
VideoLen	EQU 320d		;Pixel row Length.
FontSize	EQU 25			;Characters are 8X8 pixels in graphics mode.
BLACK		EQU 0			;Color of the background before correction.
BLUE		EQU 9
PURPLE		EQU 5

proc GetPixelXY				;Get a pixel without interrupt. gets X, Y pushed. Returns color in stack.
	push bp
	mov bp,sp
	push ax bx dx es
	push VideoSeg
	pop es
	mov ax,[bp+4]	;Y = Lines
	mov bx,VideoLen
	mul bx
	add ax,[bp+6]	;X
	mov bx,ax
	xor ax,ax
	mov al,[byte ptr ES:BX]
	mov [bp+6],ax	;return Color
	pop es dx bx ax bp
	ret 2
endp GetPixelXY
; קלט – מספר, מספר מקסימלי של תוצאה (65535, למרות שאצלי יש עד 100 בתוצאה, כי זה לא ריאלי שמישהו יגיע ל100, אך אין בעיה להוסיף גם עד 65535),10 (בגלל הספרות הדו ספרתיות),0 (נקודת התחלה של התוצאה), וסטרינג של 0 (להדפסת 0 בהתחלה).
; פלט – סטרינג של המספר בעל 5 ספרות

PROC Decimal2String		;Transforms a Word number to 5 character String. gets numbe and offset for string pushed.
	push bp
	mov bp,sp
	Push ax bx cx dx si
	mov SI,[bp+4]
	mov AX,[bp+6]
	MOV BX,Ten
	MOV CX,MaxDigits
	ADD SI,MaxDigits
D2CLoop:	
	MOV DX,Zero
	DIV BX
	DEC SI
	MOV [byte ptr SI],ZeroC
	ADD [SI],DL
	cmp AX,0
	jz nomoredigits
	LOOP D2CLoop
nomoredigits:
	pop bp si dx cx bx ax
	ret 4
Endp Decimal2String
; קלט - מספר מקסימלי של תוצאה (65535), למרות שאצלי יש עד 100 בתוצאה, אופסט של הסטרינג של התוצאה, שורה (0-24), עמודה (0-39) וצבע.
; פלט – מדפיס את המספרים בצבע שנכנס, בשורה ובעמודה שקיבל עד למספר המקסימלי.

proc printSXYC			;Print a string with a color to the characters. background is always black. Use printBXYC later to fix.
	push bp				;Gets offset of string, text row (0-24), text column(0-39) and color pushed. 
	mov bp,sp
	push ax bx cx dx es 
	mov AH,0Bh
	mov	BH,0
	mov bl,1
	mov al,1
	int 10h
	mov ah,13h
	mov AL,1
	mov bx,[bp+4]		;	Color combination
    mov BH,0	
	mov DX,[bp+8]		;	Column at which to start writing.(0-39) ->DL
	mov CX,[bp+6]
	mov dh,cl			; 	Row at which to start writing. (0-24) ->DH
	mov CX,MaxDigits	; 	String Length
	push ds
	pop es
	mov bp,[bp+10]		;	ES:BP points to string to be printed.
	int 10h
	pop es dx cx bx ax bp
	ret 8
endp printSXYC
; קלט – אורך של סטרינג ותויים לסטרינג (מספרים), שורה התחלתית (0-24), עמודה התחלתית (0-39) ,צבע, גודל (גופן) .
; פלט – רקע של הצבע שהוכנס בריבוע לפי השורה והעמודה (רקע למספרים) וגופן למספרים.
; הערה: קוראת לgetpixxy

proc printBXYC			;Fix background color for text.
	push bp				;Gets length(characters) of string, text row (0-24), text column(0-39) of beginning and color pushed. 
	mov bp,sp
	push ax bx cx dx di si
	XOR DX,DX
	mov ax,[bp+4]
	mov [pixC],ax
	mov ax,[bp+8] ;Column
	mov bx,FontSize
	mul bx
	mov [pixX], ax 		;X begin
	XOR DX,DX
	mov ax,[bp+6] ;Row
	mov bx,FontSize
	mul bx
	mov [pixY],ax     ;Y Begin
	XOR DX,DX
	mov ax,[bp+10] ;Length
	mov bx,FontSize
	mul bx
	mov [pixL], ax	;Number of pixels in every row
	xor di,di
manyRowsLoop:
	xor si,si
inRowLoop:
	mov CX,[pixX]
	add Cx,si
	push Cx
	mov Dx,[pixY]
	add Dx,di
	push dx
	call GetPixelXY
	pop ax
	cmp al,BLACK		;if it's black replace it.
	jne skipPixel
	push cx
	push dx
	push [pixC]
	;call PutPixelXYC
skipPixel:
	inc si
	cmp si,[pixL]
	jb inRowLoop
	inc di
	cmp di,FontSize
	jb manyRowsLoop
	pop si di dx cx bx ax bp
	ret 8
endp printBXYC

;0	0000	black	 		שחור
;1	0001	blue	 		כחול
;2	0010	green		 	ירוק
;3	0011	cyan		 	סיין
;4	0100	red	 			אדום
;5	0101	magenta	 		אדום-ארגמן
;6	0110	brown	 		חום
;7	0111	light gray	 	אפור בהיר
;8	1000	dark gray	 	אפור כהה
;9	1001	light blue	 	כחול בהיר
;A	1010	light green	 	ירוק בהיר
;B	1011	light cyan	 	סייאן בהיר
;C	1100	light red	 	אדום בהיר
;D	1101	light magenta	אדום-ארגמן בהיר
;E	1110	yellow	 		צהוב
;F	1111	white	 		לבן




