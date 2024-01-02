;proc that check which buttun was pressed, and sending value accordingly to the buttun
; קלט-אין
; פלט – הרגיסטר bx, לפי כפתור שנלחץ: חץ שמאל – 1, חץ ימיני – 2, רווח – 3, q-4, לחיצת עכבר – 0.

proc checkpress
	push bp
	mov bp, sp
	
mousepressmiddle:

	mov ax,3
	int 33h
	and bx, 00000001b   ; check last bit in bx to see if lest mouse button is pressed
	jnz mousepress;mouse is being press
	
	
	
	mov ah,1;checked if key pressed;
	int 16h
	
	jz mousepressmiddle ; if zero flag is on, no key is pressed
	mov ah,0;key is ready
	int 16h
	cmp  ah, 4Bh   ;left arrow
	je   leftarrow
	cmp  ah, 4Dh  ;right arrow  
	je   rightarrow
	cmp  ah, 39h    ;space
	je   space
	cmp  ah, 10h  ;q 
	je   q1
	jmp mousepressmiddle;mousepressmiddle;check input

leftarrow:
	mov bx,1
	jmp endofcheckpress
rightarrow:
	mov bx,2
	jmp endofcheckpress
space:
	mov bx,3
	jmp endofcheckpress
q1:
	mov bx,4
	jmp endofcheckpress
mousepress:
	mov bx,0
endofcheckpress:
		
	pop bp
	ret 0
endp checkpress