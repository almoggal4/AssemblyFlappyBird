;sound of jump bird, menu movement
; קלט – 0 או מספר גדול מ8 כאשר 0 בעצם אומר שהצליל או של התפריט וקפיצה של הציפור במהירות רגילה ומספר גדול מ8 אומר שזה צליל של קפיצה של הציפור במהירות מהירה.
; פלט – הצליל.

birsoundormenusound equ [word ptr bp+4]
proc sound
	push bp
	mov bp, sp
	
	cmp birsoundormenusound,0;menu sound effect
	je loop100
	cmp birsoundormenusound,8;bird jump slow sound effect
	jl birdjumpsoundslow
	cmp birsoundormenusound,8;bird jump fast sound effect
	jge birdjumpsoundsfast
	
birdjumpsoundslow:
	mov [l100],45
	mov [note],4500
	jmp loop100
birdjumpsoundsfast:
	mov [note],4500
	mov [l100],90
	;loop l100 times for long sound
loop100:
	in al, 61h
	or al, 00000011b
	out 61h, al
	; send control word to change frequency
	mov al, 0B6h
	out 43h, al
	; play frequency 131Hz
	mov ax, [note]
	out 42h, al ; Sending lower byte
	mov al, ah
	out 42h, al ; Sending upper byte

	dec [l100]
	cmp [l100],0
	jne loop100
	
	in al, 61h;end of sound
	and al, 11111100b
	out 61h, al 
	mov [l100],10000
		
pop bp
ret 2
endp sound
