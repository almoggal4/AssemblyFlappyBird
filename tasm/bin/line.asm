;prints a line under the current buttun in menu, this proc is heling in the pip proc, pip2 proc, brid proc
; קלט – אורך, ערכי x התחלתיים, ערכי y התחלתיים וצבע
; פלט – קו מצויר לפי ערכי הx וy, באורך ובצבע.

length1 equ [bp+10]
color equ [bp+8]
x equ [word ptr bp+6]
y equ [bp+4]

proc line
	push bp
	mov bp, sp
	
	mov bx,x
add bx,length1
loopx:
	inc x
	MOV AH,0Ch
    MOV AL,color
    MOV CX,x ; 0 ≤ X ≤ 319
    MOV DX,y ; 0 ≤ Y ≤ 199
    INT 10H
	cmp x,bx
	jne loopx

	pop bp
	ret 8
endp line