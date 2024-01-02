;prints pipes up to down - i have 2 proc for pipes because i need the start of pip, y value, in up and down-so here
; קלט – y התחלתי (למרות שהוא יהיה תמיד 197), גובה, צבע, אורך, רוחב (גם קבוע תמיד,10) וx התחלתי
; פלט – מלבן בצבע, בx,בy, באורך וברוחב שהתקבל.
; הערה: ההבדל בין pipes לpipes2, הוא כאשר הגובה של המלבן רנדומלי, אפשר להסתמך על הy ההתחלתי, וכמובן שלצינור מלמעלה של המסך אין Y התחלתי כמו זה שלמטה ולכן צריכים שני פרוצדורות שונות, אחת לצינורות מלמעלה, ולאחת לצינורות מלמטה.
; הערה – משתמשת בפרוצדורה line.
 ; it's start from y=197
length1 equ [bp+12]
high1 equ [bp+10]
color equ [bp+8]
x equ [word ptr bp+6]
y equ [word ptr bp+4]

proc pip
	push bp
	mov bp, sp

	mov bx,y
	mov [originaly],bx
	mov bx,length1
	add bx,x
	mov [length123],bx
	
	
	jmp line123
loopx1:
	inc x
	mov bx,[originaly]
	mov y,bx
line123:	
	mov bx,y
	sub bx,high1
loopy:
	dec y
	MOV AH,0Ch
    MOV AL,color
    MOV CX,x ; 0 ≤ X ≤ 319
    MOV DX,y ; 0 ≤ Y ≤ 199
    INT 10H
	cmp y,bx
	jne loopy

mov bx,[length123]
cmp bx,x
jne loopx1

	pop bp
	ret 10
endp pip