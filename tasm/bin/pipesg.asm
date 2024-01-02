;the main game
begginofmovement:
	
	mov [mone2],1
	mov [mone3],3;score in the first jump only needed a 3 jumps- 6-3, and then jump is needed 6 jumps, the mone3 is being moved a 0 value
	;return all the values to the intial values
	mov [monerandom1], 32
	mov [monerandom2], 42
	mov [monerandom3], 52
	mov [monerandom4], 62
	mov [monerandom5], 72
	mov [fastermone1], 1
	
	mov [xmovement1] , 320
	mov [xmovement2] , 256
	mov [xmovement3] , 192
	mov [xmovement4] , 128
	mov [xmovement5] , 64

	;x up
	mov [xmovement12] , 320
	mov [xmovement22] , 256
	mov [xmovement32] , 192
	mov [xmovement42] , 128
	mov [xmovement52] , 64

	mov [starttimepace], 2
	mov [startoppsitetime],58

	mov al,0
	mov [birdY],115;starting bird y
	
	;background
	call background
	
	;prints the score
	mov bx,[highscore123]
	cmp [monescore],bx
	jle notyourhighscore
	
	
	mov dx, offset newhighscore
	mov ah, 9h
	int 21h
	mov bx,8	
	cmp bx,0
	
	
	mov bx,[monescore]
	mov [highscore123],bx
notyourhighscore:
	push [monescore]
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
	
	cmp [monescore],10;i have a bug that the tens digit remains so i am checking if the number is smaller then 10' if it is i prints a black rect on the tens digit
	jge waitforinput
	push 29;length
	push 8;high
	push 0;color
	push 80;x
	push 88;y	
	call pip
		
input123:	
	jmp waitforinput
;stops
stopquitfromthemaingame:
	jmp quitfromthemaingame
;end stops
	
waitforinput:
	mov [monescore],0;score count is going back to zero

	mov [birdY],115;bird
	push 0
	push [birdY];y
	push 34;x
	call bird	
	mov ah,7;wait for input
	int 21h
	
	cmp al,' ';space - start
	je firstjump
	cmp al, 'q'; q - go back to menu
	je stopquitfromthemaingame
	jmp waitforinput
	
firstjump:;loop that prints the bird 
	push 1
	call sound;sound in the first jump
	sub [birdY],60
	push 0
	push [birdY];y
	push 34;x
	call bird
	
movement:

	call background
	
	add [birdY],15;draw the last bird
	push [birdY];y
	push 34;x
	call bird
	
;background:;126-152 gives the jump effect - is removing all the bird draw except for the last draw

	call background
	push [birdY];y
	push 34;x
	call bird
	
	push [birdY]
	call failchecker
	
	cmp [mone3],6;inc the mone every 6 jumps, expect from the first one' which is 3 jumps
	jge stopscore1
	jmp pipes
stopscore1:	
	mov [mone3],0
	inc [monescore]
	
	PUSH [monescore];prints the score to the screen 
	PUSH offset MyString
	CALL Decimal2String
	PUSH offset MyString
	push 10;10
	push 10;10
	Push PURPLE		;Text Color
	CALL printSXYC
	push MaxDigits	;Length
	push 10;10			;column
	push 10;10			;row
	Push BLUE			;Background Color
	CALL printBXYC
	cmp [monescore],10;i have a bug that the tens digit remains so i am checking if the number is smaller then 10' if it is i prints a black rect on the tens digit
	jge pipes
	push 29;length
	push 8;high
	push 0;color
	push 80;x
	push 88;y	
	call pip
	
pipes:	
;pipes draw
;example for random and fail is on pip1
;;;;;;;;;;;;;;;;;;;;;pip1
;down
	cmp [monerandom1],32;if the bird passed the pip change the high of the pip, randomizes, the random value is in ax
	jne pip1
	call randomnumber
	mov [randomhigh1],ax
	jmp pip1

pip1:	
	push 20;length
	push [randomhigh1];high
	push 2;color;green
	push [xmovement1];x - 300
	push 197;y		
	call pip
	
	push [birdY]
	call failchecker;proc that gives to presslocation a value, according if the bird is in a green color
	
;up
	cmp [monerandom1],32;if the bird passed the pip change the high of the pip
	jne pip1up
	mov [monerandom1],0;mov the counter to 0, because the screen is 320 values of x, and the pip mov 10x per move, so it will take to come to zero 32 times 
	call randomnumber
	mov [randomhigh1up],ax
	jmp pip1up

pip1up:
	push 20;length
	push [randomhigh1up];high
	push 2;color;green
	push [xmovement1];x - 300
	push 0;y		
	call pip2
	
	push [birdY]
	call failchecker
	
;;;;;;;;;;;;;;;;;;;;;pip1
;;;;;;;;;;;;;;;;;;;;;pip2	
;down
	cmp [monerandom2],42
	jne pip2jmp
	call randomnumber
	mov [randomhigh2],ax
	jmp pip2jmp

pip2jmp:	
	push 20;length
	push [randomhigh2];high
	push 2;color;green
	push [xmovement2];x - 240
	push 197;y		
	call pip
	
	push [birdY]
	call failchecker
	
;up	
	cmp [monerandom2],42
	jne pip2up
	mov [monerandom2],0
	call randomnumber
	mov [randomhigh2up],ax
	jmp pip2up

pip2up:
	push 20;length
	push [randomhigh2up];high
	push 2;color;green
	push [xmovement2];x - 240
	push 0;y		
	call pip2
	
	push [birdY]
	call failchecker

;;;;;;;;;;;;;;;;;;;;;pip2	
;;;;;;;;;;;;;;;;;;;;;pip3	
;down
	cmp [monerandom3],52
	jne pip3
	call randomnumber
	mov [randomhigh3],ax
	jmp pip3

pip3:	
	push 20;length
	push [randomhigh3];high
	push 2;color;green
	push [xmovement3];x - 180
	push 197;y		
	call pip
	
	push [birdY]
	call failchecker

;up	
	cmp [monerandom3],52
	jne pip3up
	mov [monerandom3],0
	call randomnumber
	mov [randomhigh3up],ax
	jmp pip3up

pip3up:

	push 20;length
	push [randomhigh3up];high
	push 2;color;green
	push [xmovement3];x - 180
	push 0;y		
	call pip2
		
	push [birdY]
	call failchecker

;;;;;;;;;;;;;;;;;;;;;pip3
;;;;;;;;;;;;;;;;;;;;;pip4
;down
	cmp [monerandom4],62
	jne pip4
	call randomnumber
	mov [randomhigh4],ax
	jmp pip4

pip4:	
	push 20;length
	push [randomhigh4];high
	push 2;color;green
	push [xmovement4];x - 120
	push 197;y		
	call pip
	
	push [birdY]
	call failchecker
;up	
	cmp [monerandom4],62
	jne pip4up
	mov [monerandom4],0
	call randomnumber
	mov [randomhigh4up],ax
	jmp pip4up

pip4up:
	push 20;length
	push [randomhigh4up];high
	push 2;color;green
	push [xmovement4];x - 120
	push 0;y		
	call pip2
	
	push [birdY]
	call failchecker

;;;;;;;;;;;;;;;;;;;;;pip4
;;;;;;;;;;;;;;;;;;;;;pip5
;down
	cmp [monerandom5],72
	jne pip5
	call randomnumber
	mov [randomhigh5],ax
	jmp pip5

pip5:
	push 20;length
	push [randomhigh5];high
	push 2;color;green
	push [xmovement5];x - 60
	push 197;y		
	call pip
	
	push [birdY]
	call failchecker
	
;up	
	cmp [monerandom5],72
	jne pip5up
	mov [monerandom5],0
	call randomnumber
	mov [randomhigh5up],ax
	jmp pip5up
	

pip5up:
	push 20;length
	push [randomhigh5up];high
	push 2;color;green
	push [xmovement5];x - 60
	push 0;y		
	call pip2
	
;;;;;;;;;;;;;;;;;;;;;pip5
paceandmove:
	mov [mone2],45
	
	cmp [fastermone1],8;if the bird jumped 8 times, the pipes will mov faster
	jne notmorepace
	dec [starttimepace]
	inc [startoppsitetime]

notmorepace:
	mov ah,2ch;get the system time, and evrey 5 seconds mov left the pip
	int 21h
	mov [sec],dh
	mov bl,[starttimepace]
	add [sec],bl
	cmp dh, [startoppsitetime]
	jge ifsecbiggerthan60minussec;if it's 58-59 sec in the first 8 jumps and 59 sec in the other jumps	
	jmp clock;if 2 sec pasted ,he already have jumped
	
ifsecbiggerthan60minussec:;if the current system time second is bigger than 60 sec
	sub [sec],60
	jmp clock

clock:	
	mov ah,1;wait for space button to jump
	int 16h
	jz checksecstop1;if not check if 2 sec past, then get the bird down and continue the program
	mov ah,0;key is ready
	int 16h
	cmp ah,39h
	je jump2;jump
	jne checksec
;stops
checksecstop1:
	jmp checksec
;end stops
jump2:
	push 0 
	push [birdY];y
	push 34;x
	call bird
	push [fastermone1]
	call sound
	cmp [mone2],0
	je checksec1;downbird
	dec [mone2]
	dec [birdY]
	jmp jump2

checksec1:
	push 1
	push [birdY];y
	push 34;x
	call bird
	push [fastermone1]
	call sound
	cmp [mone2],45
	je checksec2;downbird
	inc [mone2]
	inc [birdY]
	jmp checksec1
	
checksec2:
	sub [birdy],45
	push [birdY]
	call failchecker
	jmp checksec
	
checksec:
	push 0 
	push [birdY];y
	push 34;x
	call bird
	mov ah,2ch
	int 21h
	cmp [sec],dh;check if 2 sec pasted
	je downbird;yes down the bird
	jmp clock;no, wait to input
	
downbird:
	push 0
	add [birdY],15
	push [birdY];y
	push 34;x
	call bird
;;;;;;;;;;;;;;;;;;;;;;;;;;;pip1
;down
	;pipes movement - 10 by 10 x values
	add [xmovement1],10;adding 10
	
	;prints a 10xrandom-high rect in blue color, in the left side of pip
	push 10;length
	push [randomhigh1];high
	push 9;color;blue
	push [xmovement1];x
	push 197;y		
	call pip
	
	sub [xmovement1],20;subbing 20 after adding 10, so the pipes movement is 10 by 10
	;prints a 10xrandom-high rect in green, in the left side of pip
	push 10;length
	push [randomhigh1];high
	push 2;color;green
	push [xmovement1];x
	push 197;y		
	call pip
	;that gives the effect of the pip movement to the left
;up	
	add [xmovement12],10
	
	push 10;length
	push [randomhigh1up];high
	push 9;color;blue
	push [xmovement12];x
	push 0;y		
	call pip2
	
	sub [xmovement12],20
	
	push 10;length
	push [randomhigh1up];high
	push 2;color;green
	push [xmovement12];x
	push 0;y		
	call pip2

;;;;;;;;;;;;;;;;;;;;;;;;;;;pip1	
;;;;;;;;;;;;;;;;;;;;;;;;;;;pip2
;down
	add [xmovement2],10
	
	push 10;length
	push [randomhigh2];high
	push 9;color;blue
	push [xmovement2];x
	push 197;y		
	call pip
	
	sub [xmovement2],20
	
	push 10;length
	push [randomhigh2];high
	push 2;color;green
	push [xmovement2];x
	push 197;y		
	call pip
;up
	add [xmovement22],10
	
	push 10;length
	push [randomhigh2up];high
	push 9;color;blue
	push [xmovement22];x
	push 0;y		
	call pip2
	
	sub [xmovement22],20
	
	push 10;length
	push [randomhigh2up];high
	push 2;color;green
	push [xmovement22];x
	push 0;y		
	call pip2
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;pip2	
;;;;;;;;;;;;;;;;;;;;;;;;;;;pip3
;down
	add [xmovement3],10
	
	push 10;length
	push [randomhigh3];high
	push 9;color;blue
	push [xmovement3];x
	push 197;y		
	call pip
	
	sub [xmovement3],20
	
	push 10;length
	push [randomhigh3];high
	push 2;color;green
	push [xmovement3];x
	push 197;y		
	call pip
;up	
	add [xmovement32],10
	
	push 10;length
	push [randomhigh3up];high
	push 9;color;blue
	push [xmovement32];x
	push 0;y		
	call pip2
	
	sub [xmovement32],20
	
	push 10;length
	push [randomhigh3up];high
	push 2;color;green
	push [xmovement32];x
	push 0;y		
	call pip2
;;;;;;;;;;;;;;;;;;;;;;;;;;;pip3
;;;;;;;;;;;;;;;;;;;;;;;;;;;pip4
;down
	add [xmovement4],10
	
	push 10;length
	push [randomhigh4];high
	push 9;color;blue
	push [xmovement4];x
	push 197;y		
	call pip
	
	sub [xmovement4],20
	
	push 10;length
	push [randomhigh4];high
	push 2;color;green
	push [xmovement4];x
	push 197;y		
	call pip
;up
	add [xmovement42],10
	
	push 10;length
	push [randomhigh4up];high
	push 9;color;blue
	push [xmovement42];x
	push 0;y		
	call pip2
	
	sub [xmovement42],20
	
	push 10;length
	push [randomhigh4up];high
	push 2;color;green
	push [xmovement42];x
	push 0;y		
	call pip2
;;;;;;;;;;;;;;;;;;;;;;;;;;;pip4
;;;;;;;;;;;;;;;;;;;;;;;;;;;pip5
;down
	add [xmovement5],10
		
	push 10;length
	push [randomhigh5];high
	push 9;color;blue
	push [xmovement5];x
	push 197;y		
	call pip
	
	sub [xmovement5],20
	
	push 10;length
	push [randomhigh5];high
	push 2;color;green
	push [xmovement5];x
	push 197;y		
	call pip
	
;up
	add [xmovement52],10
	
	push 10;length
	push [randomhigh5up];high
	push 9;color;blue
	push [xmovement52];x
	push 0;y		
	call pip2
	
	sub [xmovement52],20
	
	push 10;length
	push [randomhigh5up];high
	push 2;color;green
	push [xmovement52];x
	push 0;y		
	call pip2
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;pip5

	;increasing all the counters, because the pip moved once 
	inc [monerandom1]
	inc [monerandom2]
	inc [monerandom3]
	inc [monerandom4]
	inc [monerandom5]
	inc [fastermone1]
	inc [mone3]
	jmp movement;go back to movement
