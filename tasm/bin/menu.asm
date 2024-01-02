	mov ax, 13h; Graphic mode
	int 10h
		
	mov dx, offset filename;;main page of the game call procs
	call bmpcaller; Process BMP file

mov ax,1;showing the mouse
int 33h
middle:;print a black line under middle spot
	push 57;length
	push 0;color
	push 122;x
	push 197;y
	call line
begining:
	call checkpress
	
	cmp bx,0;mouse press
	je  presslocation
	cmp  bx, 1 ;left 
	je   stopleft
	cmp  bx, 2   ;right
	je   stopright
	cmp  bx, 3    ;space
	je   stopgame
	cmp  bx, 4    ;quit
	je   stopquit
	jne begining
	; jmp mousepressmiddle;mousepressmiddle;check input

;stops
stopwaitforpress1:
	jmp begining
stopleft:
	push 0
	call sound;sound
	jmp left
	
stopright:;Intermediate stop
	jmp stopright1
	
stopquit:
	jmp stopquit1
stopgame:
	jmp stopgame1
;end stops

presslocation:;check where the mouse is been clicked
	mov ax,3h
	int 33h
	cmp  cx, 370
	jl leftminx
rightmaxX:	
	cmp  cx,484
	jg leftminx
rightminY:
	cmp  dx, 171
	jl leftminx
rightmaxY:	
	cmp  dx,196
	jle  howtomose
	jmp leftminx

leftminx:
	cmp  cx, 112
	jl quitminx
leftmaxX:	
	cmp  cx,226
	jg quitminx
leftminY:
	cmp  dx, 171
	jl quitminx
leftmaxY:	
	cmp  dx,196
	jle  highscorestop1
	jmp quitminx

quitminx:
	cmp  cx, 592
	jl middleminx
quitmaxX:	
	cmp  cx,626
	jg middleminx
quitminY:
	cmp  dx, 8
	jl middleminx
quitmaxY:	
	cmp  dx,27
	jle  stopquit1
	jmp middleminx
;stops
howtomose:
	jmp howtomose1
;end stops	
middleminx:
	cmp  cx, 242
	jl stopwaitforpress1
middlemaxX:	
	cmp  cx,354
	jg stopwaitforpress1
middleminY:
	cmp  dx, 141
	jl stopwaitforpresshalf
middlemaxY:	
	cmp  dx,196
	jle  stopgame1
	jmp stopwaitforpress1
	
;stops
stopgame1:
	jmp stopgame2
stopright1:
	push 0
	call sound;sound
	jmp stopright2	
	
stopquit1:
	jmp stopquit2
	
howtomose1:
	jmp howtomose2

highscorestop1:
	push 0
	call sound;sound
	jmp highscore
stopwaitforpresshalf:
	jmp stopwaitforpress1
;end stops

left:;left spot
	push 57;prints a red line under middle spot
	push 14
	push 122
	push 197
	call line
	push 57;prints a black line under left spot
	push 0
	push 56
	push 196
	call line
	jmp mousepressleft

;stops
stopgame2:
	jmp stopgame3
	
stopquit2:
	jmp stopquit3
	
stopright2:
	jmp right
	
howtomose2:
	jmp howtomose3
;end stops
mousepressleft:	;check what pressed or clicked
	call checkpress
	cmp bx,0;mouse
	je  presslocationleft
	cmp  bx, 2   ;left
	je   stopleft_corner_to_middle1
	cmp  bx, 3  ;space  
	je   stophighscore1
	cmp  bx, 4   ;quit 
	je   stopquit2
	jne mousepressleft
presslocationleft:	;check where the mouse is been clicked
	jmp presslocation
;stops
stopleft_corner_to_middle1:
	push 0
	call sound;sound
	jmp left_corner_to_middle
stophighscore1:
	push 0
	call sound;sound
	jmp highscore
stopmousepressleft:
	jmp mousepressleft
;end stops


;stops
stophighscore3:
	push 0
	call sound;sound
	jmp highscore
stopquit3:
	jmp stopquit4
;end tops


left_corner_to_middle:
	push 57;prints a red line under left spot
	push 14
	push 56
	push 196
	call line
	jmp middle
; stop
stopgame25:
	jmp stopgame3
; end stop
highscore:;high score screen
	mov ax,0
	int 33h
	
	mov dx, offset filename2
	call bmpcaller
	
	push [highscore123]
	push offset MyString
	call Decimal2String
	push offset MyString
	push 10;10
	push 10;10
	push PURPLE		;Text Color
	call printSXYC
	push MaxDigits	;Length
	push 10;10			;column
	push 10;10			;row
	push BLUE			;Background Color
	call printBXYC
	
	mov cx,0
	mov dx,0
	mov ax,0
	
	mov ax,1
	int 33h

waitformouseq2:;the user need to press q or click the mouse
	mov ax,3
	int 33h
	and bx, 00000001b   ; check last bit in bx to see if lest mouse button is pressed
	jnz quitminx4
	
	mov ah, 1  ;wait for key press
	int 16h
	jz waitformouseq2
	mov ah,0;key is ready
	int 16h
	cmp  ah, 10h ;q - quit
	je stopquitfromhowto1
	jmp waitformouseq2
; stop
stopquitfromhowto1:
	push 0
	call sound;sound 
	jmp quitfromhowto2
; end stop
quitminx4:;check if the mouse was being clicked on the back button
	mov ax,3h
	int 33h
	cmp  cx, 592
	jl waitformouseq2
quitmaxX4:	
	cmp  cx,626
	jg waitformouseq2
quitminY4:
	cmp  dx, 8
	jl waitformouseq2
quitmaxY4:	
	cmp  dx,27
	jle  quitfromhowto2	
	jmp waitformouseq2
	
quitfromhowto2:	;prints the menu page
	push 0
	call sound;sound

	mov ax,0
	int 33h
	
	mov dx, offset filename
	call bmpcaller
	
	mov ax,1
	int 33h
	
	mov cx,0
	mov dx,0
	mov ax,0
	jmp middle

;stops	
stopgame3:
	jmp stopgame4
	
stopquit4:
	push 0
	call sound;sound 
	jmp quitfromthegame	
	
howtomose3:
	push 0
	call sound;sound
	jmp how_to_play

;end stops	

right:;right spot
	push 57;prints a red line under the middle spot
	push 14
	push 122
	push 197
	call line
	push 57;prints black line under right spot
	push 0
	push 185
	push 197
	call line
	jmp rightspot

rightspot:	
	call checkpress
	cmp bx,0;mouse click
	je  presslocationright
	cmp  bx, 1 ;right 
	je   stopright_corner_to_middle1
	cmp  bx, 3    ;space
	je   stophow_to_play1
	cmp  bx, 4   ;quit 
	je   quitfromthegame1
	jne rightspot
;stops
stophighscore2:
	push 0
	call sound;sound
	jmp highscore
;end stops
presslocationright:;check where the mouse is been clicked
	jmp presslocation

;stops
howtomose4:
	jmp how_to_play
stophow_to_play1:
	push 0
	call sound;sound
	jmp how_to_play
stopright_corner_to_middle1:
	push 0
	call sound;sound
	jmp right_corner_to_middle
quitfromthegame1:
	push 0
	call sound;sound
	jmp quitfromthegame
stoprightspot:
	jmp rightspot
;end stops

right_corner_to_middle:
	push 57;prints a red line under right spot
	push 14
	push 185
	push 197		
	call line
	jmp middle

;stops
stopgame4:
	push 0
	call sound;sound
	jmp game
stopquit5:
	push 0
	call sound;sound
	jmp quitfromthegame	
;end stops	

how_to_play:;how to play page of the game
	mov ax,0
	int 33h
	mov dx, offset filename1
	call bmpcaller
	
	mov cx,0
	mov dx,0
	mov ax,0
	
	mov ax,1
	int 33h
	jmp waitformouseq3
quitfromthemaingame:;prints the main page of the game
	push 0
	call sound;sound
	mov ax,0
	int 33h
	
	mov dx, offset filename
	call bmpcaller
	
	mov ax,1
	int 33h
	jmp middle
	
	
waitformouseq3:;the user need to press q or click the mouse
	mov ax,3
	int 33h
	and bx, 00000001b   ; check last bit in bx to see if lest mouse button is pressed
	jnz quitminx5

	mov ah, 1  ;wait for key press
	int 16h
	jz waitformouseq3
	mov ah,0
	int 16h
	cmp  al, 'q'  
	je stopquitfromhowto12
	jne waitformouseq3
	
quitminx5:;check if the mouse was being clicked on the back button
	mov ax,3h
	int 33h
	cmp  cx, 592
	jl waitformouseq3
quitmaxX5:	
	cmp  cx,626
	jg waitformouseq3
quitminY5:
	cmp  dx, 8
	jl waitformouseq3
quitmaxY5:	
	cmp  dx,27
	jle  stopquitfromhowto12
	jmp waitformouseq3

;stops
stopquitfromhowto12:
	push 0
	call sound;sound
	jmp quitfromhowto
;end stops
quitfromhowto:;prints the main page of the game
	mov ax,0
	int 33h	
	
	mov dx, offset filename
	call bmpcaller
	
	mov cx,0
	mov dx,0
	mov ax,0
	
	mov ax,1
	int 33h
	jmp middle
 quitfromthegame:;text mode - quit

	mov ah, 0
	mov al, 2
	int 10h
	
	mov dx, offset credit
	mov ah, 9h
	int 21h
	
	mov dx, offset spacemsg
	mov ah, 9h
	int 21h
	
	mov dx, offset thankes
	mov ah, 9h
	int 21h
	
	
	jmp endofproject

game:;the next program is the game, so i reset the registers
	mov ax,0
	int 33h
	
	mov cx,0
	mov dx,0
	mov ax,0
	
	
	



	

