; קלט: אין
; פלט: רקע למשחק 

proc background
	push bp
	mov bp, sp
	
	push 319;length
	push 199;high
	push 9;color;blue
	push 319;x
	push 199;y		
	call pip

	push 319;length
	push 5;high
	push 38;color;brown
	push 319;x
	push 199;y		
	call pip
	
	push 319;length
	push 2;high
	push 35;color;soft green;35
	push 319;x
	push 194;y		
	call pip
	
	pop bp
	ret 0
endp background