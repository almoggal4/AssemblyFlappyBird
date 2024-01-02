;prints pipes up to down - i have 2 proc for pipes because i need the start of pip, y value, in up and down-so here
; קלט – y התחלתי (למרות שהוא יהיה תמיד 0), גובה, צבע, אורך, רוחב (גם קבוע תמיד,10) וx התחלתי
; פלט – מלבן בצבע, בx,בy, באורך וברוחב שהתקבל.
; 9
; הערה: ההבדל בין pipes לpipes2, הוא כאשר הגובה של המלבן רנדומלי, אפשר להסתמך על הy ההתחלתי, וכמובן שלצינור מלמעלה של המסך אין Y התחלתי כמו זה שלמטה ולכן צריכים שני פרוצדורות שונות, אחת לצינורות מלמעלה, ולאחת לצינורות מלמטה.
; הערה – משתמשת בפרוצדורה line.
 ; it's start from y=0
length2 equ [bp+12]
high2 equ [bp+10]
color2 equ [bp+8]
x2 equ [word ptr bp+6]
y2 equ [word ptr bp+4]

proc pip2
	push bp
	mov bp, sp

	mov bx,y2
	mov [originaly2],bx
	mov bx,length2
	add bx,x2
	mov [length1234],bx
	
	
	jmp line1234
loopx2:
	inc x2
	mov bx,[originaly2]
	mov y2,bx
line1234:	
	mov bx,y2
	add bx,high2
loopy2:
	inc y2
	MOV AH,0Ch
    MOV AL,color2
    MOV CX,x2 ; 0 ≤ X ≤ 319
    MOV DX,y2 ; 0 ≤ Y ≤ 199
    INT 10H
	cmp y2,bx
	jne loopy2

mov bx,[length1234]
cmp bx,x2
jne loopx2

	pop bp
	ret 10
endp pip2