;dataseg of all project
filename db 'try1234.bmp',0;the main page of the game
filehandle dw ?
Header db 54 dup (0)
Palette db 256*4 dup (0);256*4 changed to 400h
ScrLine db 320 dup (0)
ErrorMsg db 'Error', 13, 10,'$'
;how to play page 

filename1 db 'howtop2.bmp',0

;high score page
filename2 db 'hscore.bmp',0

;the game page is drawed by me

;pipes
originaly dw ?
length123 dw ?
originaly2 dw ?
length1234 dw ?

	;x down
xmovement1 dw 320
xmovement2 dw 256
xmovement3 dw 192
xmovement4 dw 128
xmovement5 dw 64

	;x up
xmovement12 dw 320
xmovement22 dw 256
xmovement32 dw 192
xmovement42 dw 128
xmovement52 dw 64

	;down high random
randomhigh1 dw ?
randomhigh2 dw ?
randomhigh3 dw ?
randomhigh4 dw ?
randomhigh5 dw ?

	;up high random
randomhigh1up dw ?
randomhigh2up dw ?
randomhigh3up dw ?
randomhigh4up dw ?
randomhigh5up dw ?

	;counter that counts the movements until pip gets to behind the bird
monerandom1 dw 32
monerandom2 dw 42
monerandom3 dw 52
monerandom4 dw 62
monerandom5 dw 72
	;pace of pipes that gets faster after 8 jumps
;mone dw 30
mone2 dw 45;60
fastermone1 dw 1
starttimepace db 50
startoppsitetime db 99
sec db ?

	
;start y of the bird
birdY dw 115
blackorblue dw 0
yelloworblue dw 63
redorblue dw 12
;random array with 256 values, db
randomarray dw 1 dup (26,27,28,29,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,89,90,26,27,28,29,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,89,90,26,27,28,29,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,89,90,26,27,28,29,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,89,90)
lastrand dw 0
monerandom dw 0
;fail 
xbirdfail dw 28
;sound menu and jump in game
note dw 3520 ;1193180 / 131 -> (hex)
l100 dw 10000
;mouse
mousestatus dw ?
;high score
filename4 db 'score12.txt',2
filehandle1 dw ?
newhighscore db '     newhighscore!$'
monescore dw 0d
MyString db 5d dup(' ')	;Spaces
pixX dw ?						;Variables for printBXYC
pixY dw ?
pixL dw ?
pixC dw ?
mone3 dw 0
highscore123 dw 0;the min score
;exit from the project
thankes db 'thank you for playing!$'
spacemsg db '                                                                                   $'
credit db 'flappy bird by Almog Gal$'
;;;;;;;;;;;;;

