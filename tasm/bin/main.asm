; ---------------------------------------------- ---------------------------------------------------------------
; Read a BMP file 320x200 and print it to screen
; Author: Barak Gonen, 2014
; Credit: Diego Escala, www.ece.msstate.edu/~reese/EE3724/labs/lab9/bitmap.asm
; -------------------------------------------------------------------------------------------------------------
IDEAL
MODEL small
STACK 100h
DATASEG
include 'ds.asm';dataseg of the all project

CODESEG
include 'bmp.asm';main intro to the game
include 'line.asm';ptints a line under the buttons
include 'pipes.asm';pipes down to up for the game
include 'pipes2.asm';pipes for up to down in the game
include 'bird.asm';bird of the game
include 'bmpcall.asm';call the proc of the bmp files
include 'press.asm';check if was input (keyboarde or mouse) and set bx a different values in order of possible situations
;include 'mouse.asm';check where mouse press has pressed and set bx a different values in order of possible situations
;incluse 'quit.asm' ;check if the user exit from high score/how to play, mouse and q button 
include 'fail.asm';checks if the bird touch the pipes or the ground and failed
include 'random.asm';gets a random number 
include 'sound.asm';makes a sound for the menu and the jump of the bird
include 'score.asm';prints the high score 
include 'bg.asm';draw the background of the game

;לתעד את רנדום ולדעת אותה
start:
	mov ax, @data
	mov ds, ax

	include 'menu.asm';menu program -  not responding to wrond inputs, menu, sound of line movement ,line,high score,how to play,exit
	include 'pipesg.asm';game program - pipes,pipes movement, pace of pipes,bird,fail of jump,fail of bird,score counter,sound of jumps , prints the score,save the high score and sending it to menu program, not responeding for wrong inputs, exut to menu
endofproject:;exit from project is here
	
exit:
mov ax, 4c00h
int 21h
END start 