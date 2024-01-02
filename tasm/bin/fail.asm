;proc that gives to failstatus a value, according if the bird is in a green - ground and pipes or brown color, if the bird is in the sky , she wiil go to the buttom of scrren, so she will touch a browen color 
; קלט – הy של הציפור (האמצעי)
; פלט – failstatus,  לפי נגיעת הציפור בפיקסלים שאינם כחולים, אם נגע בפיקסלים לא כחולים, הפרוצדורה תחזיר failstatus=1, ואם לא failstatus=0.

yodbird equ [word ptr bp+4]
proc failchecker
	push bp
	mov bp, sp

notallpartofbirdhasbeenchecked:	
	inc [xbirdfail]
	mov al,0
	
	
	mov bh,0h
	mov cx,[xbirdfail];x
	mov dx,yodbird
	mov ah,0Dh
	int 10h ; return al the pixel value read 

	cmp al,	2;if the bird touch the pipes or the ground
	jne sky
	jmp begginofmovement

sky:
	cmp yodbird,3
	jg ground123;failstatus0
	jmp begginofmovement
ground123:
	cmp yodbird,190
	jl endoffailchecker;failstatus0
	jmp begginofmovement
endoffailchecker:	
	cmp [xbirdfail],39
	jne notallpartofbirdhasbeenchecked

fail:
	mov [xbirdfail],28
	
	pop bp
	ret 4
endp failchecker