;proc that call to other procs that are printing a bmp file
; קלט - אין
; פלט – אין
; הערה : פרוצדורה הקוראת לפרוצדורות:openfile ,readheader,readpalette,copypal  copybitmap 
proc bmpcaller
	push bp
	mov bp, sp
	
	call OpenFile
	call ReadHeader
	call ReadPalette
	call CopyPal
	call CopyBitmap
	call CloseFile
	
	pop bp
	ret 0
endp bmpcaller