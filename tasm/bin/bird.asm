;gets x location and y location and prints a bird, y range that used: y - y+6,x range that used: x-5  -  x+5 *using the line proc
 ; קלט – x התחלתי וy התחלתי ומספר (שלפיו אני בודק האם לצייר ציפור רגיל או בצבע של הרקע)
; פלט – מציירת ציפור לפי הx והy ולפי הצבע הנדרש.
; הערה – משתמשת בפרוצדורה line.

birdorbluebird equ [word ptr bp+8]
ybird equ [word ptr bp+6]
xbird equ [word ptr bp+4]
proc bird
	push bp
	mov bp, sp
; a program that draw a bird with the proc line.asm - 10x and 6y spots.
	cmp birdorbluebird,0
	jne bluebird1 
	
	mov [blackorblue],0
	mov [yelloworblue],63
	mov [redorblue],12
	jmp drawthebird
	
bluebird1:
	mov [blackorblue],9
	mov [yelloworblue],9
	mov [redorblue],9
	
drawthebird:	
	push 2
	push [yelloworblue]
	push xbird;160
	push ybird;100
	call line
	
	sub xbird,3
	inc ybird
	
	push 3
	push [yelloworblue]
	push xbird;157
	push ybird;101
	call line
	
	
	add xbird,3
	
	push 1
	push [blackorblue]
	push xbird;160
	push ybird;101
	call line
	
	add xbird,1
	
	push 2
	push [yelloworblue]
	push xbird;161
	push ybird;101
	call line
	
	sub xbird,6
	inc ybird
	
	push 10
	push [yelloworblue]
	push xbird;155
	push ybird;102
	call line
	
	
	inc ybird
	
	push 10
	push [yelloworblue]
	push xbird;155
	push ybird;102
	call line
	
	add xbird,10
	
	
	push 2;bick
	push [redorblue]
	push xbird;165
	push ybird;102
	call line
	
	sub xbird,10
	inc ybird
	
	push 10
	push [yelloworblue]
	push xbird;155
	push ybird;103
	call line
	
	add xbird,2
	inc ybird
	
	push 6
	push [yelloworblue]
	push xbird;157
	push ybird;104
	call line
	
	add xbird,2
	inc ybird
	
	push 2
	push [yelloworblue]
	push xbird;159
	push ybird;105
	call line
	
	
	pop bp
	ret 6
endp bird

