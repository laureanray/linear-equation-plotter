; Linear Equation ver 0. 1
; An 8086 based assembly program to plot linear equations
; In compliance with the subject: Computer Systems 
.model huge   
.code
org 100h
start:
    jmp main
    	
    begin db "   PRESS [ENTER] TO START     $"
	pix2 db 219, 219, 221, 10, 13, "$"
	pix3 db 219, 219, 219, 221, 10, 13, "$"
	pix4 db 219, 219, 219, 219, 221, 10, 13, "$"
	pix5 db 219, 219, 219, 219, 219, 221, 10, 13, "$"
	pix6 db 219, 219, 219, 219, 219, 219, 221, 10, 13, "$"
    pr1 db 10,13,10,10,10,"                     Linear Equation Plotter | Ver 0.1 $"
    pr2 db 10,13, "                          Press [Enter] to Continue$" 
    pr3 db 10,13, "                          ver 0.1$"
    pr4 db 10,10,13, "                     README:$"  
    pr5 db 10,10,13, "                     This program strictly accepts linear$" 
    pr6 db 10,13, "                     equations only (i.e. y = b, y = mx + b) $" 
    pr7 db 10,10,13, "                     Furthermore, due to 8086 limitations$"      
    pr8 db 10,13, "                     the output graph is limited to 320px$"           
    pr9 db 10,13, "                     by 200px only.$"
    pr10 db 10,10,13, "                     [Enter] Continue     [Esc] Back$"
    pr11 db 10,10,13, "                     Choose type of equation: $"
    pr12 db 10,10,13, "                     [1] y = b $"    
    pr13 db 10,13, "                     [2] y = -b $" 
    pr14 db 10,13, "                     [3] y = -mx + b $"
    pr15 db 10,13, "                     [4] y = mx - b $"
    pr16 db 10,13, "                     [5] y = -mx - b $"
    pr17 db 10,13, "                     [6] y = mx + b $"
    pr18 db 10,10,13, "                     Equation Type: y = b$"
    pr19 db 10,10,13, "                     Enter the equation: y = $"
    pr20 db 10,10,13, "                     Equation Type: y = -b$"
    pr21 db 10,10,13, "                     Enter the equation: y = -$"
    pr22 db 10,10,13, "                     Equation Type: y = -mx + b$"
    pr23 db 10,10,13, "                     Enter the slope (m): -$"
    pr24 db 10,13, "                     Enter the constant (b): $"
    pr25 db 10,10,13, "                     The equation is: y = $" 
    pr26 db 10,10,13, "                     [G] Graph [Esc] Back $"
    pr27 db 10,10,13, "                     [Esc] Back $"  
    pr28 db 10,10,13, "                     Enter the slope (m): $"
    pr29 db 10,10,13, "                     Equation Type: y = mx - b$" 
    pr30 db 10,10,13, "                     Equation Type: y = -mx - b$"
    pr31 db 10,13, "                     Enter the constant (b): -$"        
    pr32 db 10,10,13, "                     Equation Type: y = mx + b$"
    q db 10,13,10, "                     Select: $"
    x db "X-axis$"
    y db " Y-axis$"
exit: int 20h 
main proc near
    call clear
    call linear
    mov ch, 32 
    mov ah, 01h
    int 10h
    mov ah, 01h
    int 21h             ;data is stored to al
    cmp al, 0dh         ;check if space(20h) is pressed
    je program          ;jump to program if equal
    cmp al, 1bh         ;check if esc(27h) is pressed
    je exit             ;jump to exit: 20h if equal
    jne main            ;restart main if not equal 
    ret 
main endp
program proc near       ;this is the program subroutine
    call clear
    mov dx, offset pr1  ;print
    call print
    mov dx, offset pr4  ;print
    call print
    mov dx, offset pr5  ;print
    call print
    mov dx, offset pr6  ;print
    call print
    mov dx, offset pr7  ;print
    call print
    mov dx, offset pr8  ;print
    call print
    mov dx, offset pr9  ;print
    call print
    mov dx, offset pr10  ;print
    call print
    mov ch, 32 
    mov ah, 01h
    int 10h
    mov ah, 01h
    int 21h
    cmp al, 0dh ;check if enter is pressed then proceed to step_1
    je step_1
    cmp al, 1bh ;check if esc is pressed then proceed to main
    je main
    jne program ;restart the subroutine program
    ret 
program endp  
step_1 proc near
        call clear
        mov dx, offset pr1  ;print
        call print
        mov dx, offset pr11  ;print
        call print
        mov dx, offset pr12  ;print
        call print
        mov dx, offset pr13  ;print
        call print
        mov dx, offset pr14  ;print
        call print
        mov dx, offset pr15  ;print
        call print
        mov dx, offset pr16  ;print
        call print
        mov dx, offset pr17  ;print
        call print
        mov dx, offset q
        call print
        mov ah, 01h
        int 21h 
        cmp al, 31h ;if 1 is pressed proceed to y = b program
        je bpos
        cmp al, 32h ;if 2 is pressed proceed to y = -b program
        je bneg
        cmp al, 33h ;if 3 is pressed proceed to y = -mx + b
        je mnegbpos1
        cmp al, 34h ;if 4 is pressed proceed to y = mx - b
        je mposbneg1
        cmp al, 35h ;if 5 is pressed proceed to y = -mx - b
        je mnegbneg1
        cmp al, 36h ;if 6 is pressed proceed to y = mx + b
        je mposbpos1
        jne step_1  ;restart if not equal
        bpos: ; eto yung sa input na y = b 
        call clear
        mov dx, offset pr1  ;print
        call print
        mov dx, offset pr18  ;print
        call print
        mov dx, offset pr19  ;print
        call print
        mov ah, 1
        int 21h 
        mov bl, al      ;transfer the b(al) to bl           
        mov dx, offset pr25
        call print
        mov ah, 2
        mov dl, bl
        int 21h
        mov dx, offset pr26
        call print
        mov dx, offset q
        call print
        mov ah, 1
        int 21h
        cmp al, 67h ;check if the user presses G then jump to graph
        je graph_bpos1
        cmp al, 1bh ;check if the user press ESC then go back
        je bpos
        jne bpos 
        mnegbpos1: jmp mnegbpos
        mposbneg1: jmp mposbneg
        mnegbneg1:jmp mnegbneg
        mposbpos1:jmp mposbpos
     
        bneg:
        call clear
        mov dx, offset pr1  ;print
        call print
        mov dx, offset pr20  ;print
        call print
        mov dx, offset pr21  ;print
        call print
        mov ah, 1
        int 21h
        mov bl, al  ;as usual, transfer ulet si bl kay al
        mov dx, offset pr25
        call print
        mov dl, '-'
        mov ah, 2
        int 21h
        mov dl, bl
        mov ah, 2
        int 21h
        mov dx, offset pr26
        call print
        mov dx, offset q
        call print
        mov ah, 1
        int 21h
        cmp al, 67h
        je graph_bneg1
        cmp al, 1bh
        je bneg
        jne bneg        
        graph_bpos1: jmp graph_bpos 
        
        mnegbpos:
        call clear
        mov dx, offset pr1  ;print
        call print
        mov dx, offset pr22  ;print
        call print
        mov dx, offset pr23  ;print
        call print
        mov ah, 1
        int 21h
        mov cl, al       ;the slope is stored to cl
        mov dx, offset pr24  ;print
        call print
        mov ah, 1
        int 21h 
        mov bl, al          ;the constant is stored to bl 
        mov dx, offset pr25
        call print
        jmp eqmnegbpos
          
        rtrn:
        mov dx, offset pr26
        call print
        mov dx, offset q
        call print
        mov ah, 1
        int 21h
        cmp al, 67h
        je graph_mnegbpos5
        cmp al, 1bh
        je mnegbpos
        jne mnegbpos 
        graph_bneg1: jmp graph_bneg
        mposbneg:
        call clear
        mov dx, offset pr1  ;print
        call print
        mov dx, offset pr29  ;print
        call print
        mov dx, offset pr28  ;print
        call print
        mov ah, 1
        int 21h
        mov cl, al       ;the slope is stored to cl
        mov dx, offset pr24  ;print
        call print
        mov ah, 1
        int 21h 
        mov bl, al          ;the constant is stored to bl 
        mov dx, offset pr25
        call print
        call eqmposbneg
        rtrn2:
         mov dx, offset pr26
        call print
        mov dx, offset q
        call print
        mov ah, 1
        int 21h
        cmp al, 67h
        je graph_mposbneg1
        cmp al, 1bh
        je mposbneg
        jne jmpx  
    
        ;;;;;next
        graph_mnegbpos5: jmp graph_mnegbpos
        jmpx: jmp main  
        ;;;; 
        mnegbneg:
        call clear
        mov dx, offset pr1  ;print
        call print
        mov dx, offset pr30  ;print
        call print
        mov dx, offset pr23  ;print
        call print
        mov ah, 1
        int 21h
        mov cl, al       ;the slope is stored to cl
        mov dx, offset pr31  ;print
        call print
        mov ah, 1
        int 21h 
        mov bl, al          ;the constant is stored to bl 
        mov dx, offset pr25
        call print
        call eqmnegbneg
        rtrn3:
         mov dx, offset pr26
        call print
        mov dx, offset q
        call print
        mov ah, 1
        int 21h
        cmp al, 67h
        je graph_mnegbneg1
        cmp al, 1bh
        je mnegbneg
        jne jmpx
        jmpxx: jmp main 
        jmpxxxx: jmp mposbpos
        graph_mposbneg1: jmp graph_mposbneg    
        mposbpos:;; this is for the y = mx + b equations
        call clear
        mov dx, offset pr1  ;print
        call print
        mov dx, offset pr32  ;print
        call print
        mov dx, offset pr28  ;print
        call print
        mov ah, 1
        int 21h
        mov cl, al       ;the slope is stored to cl
        mov dx, offset pr24  ;print
        call print
        mov ah, 1
        int 21h 
        mov bl, al          ;the constant is stored to bl 
        mov dx, offset pr25
        call print
        call eqmposbpos
        rtrn4:
         mov dx, offset pr26
        call print
        mov dx, offset q
        call print
        mov ah, 1
        int 21h
        cmp al, 67h
        je graph_mposbpos1
        cmp al, 1bh
        je jmpxxxx
        jne jmpxx             
        graph_mnegbneg1: jmp graph_mnegbneg
        graph_mnegbpos1: jmp graph_mnegbpos      
        eqmnegbpos:
        mov ah, 2
        mov dl, '-'
        int 21h
        mov ah, 2
        mov dl, cl
        int 21h
        mov ah, 2
        mov dl, 'x'
        int 21h
        mov ah, 2
        mov dl, ' '
        int 21h
        mov ah, 2
        mov dl, '+'
        int 21h
        mov ah, 2
        mov dl, ' '
        int 21h
        mov ah, 2
        mov dl, bl
        int 21h   
        jmp rtrn
        ret   
        eqmposbneg:
        mov ah, 2
        mov dl, cl
        int 21h
        mov ah, 2
        mov dl, 'x'
        int 21h
        mov ah, 2
        mov dl, ' '
        int 21h
        mov ah, 2
        mov dl, '-'
        int 21h
        mov ah, 2
        mov dl, ' '
        int 21h
        mov ah, 2
        mov dl, bl
        int 21h   
        jmp rtrn2
        ret  
        graph_mposbpos1: jmp graph_mposbpos
        eqmnegbneg:
        mov ah, 2
        mov dl, '-'
        int 21h
        mov ah, 2
        mov dl, cl
        int 21h
        mov ah, 2
        mov dl, 'x'
        int 21h
        mov ah, 2
        mov dl, ' '
        int 21h
        mov ah, 2
        mov dl, '-'
        int 21h
        mov ah, 2
        mov dl, ' '
        int 21h
        mov ah, 2
        mov dl, bl
        int 21h   
        jmp rtrn3 
        eqmposbpos:
    
        mov ah, 2
        mov dl, cl
        int 21h
        mov ah, 2
        mov dl, 'x'
        int 21h
        mov ah, 2
        mov dl, ' '
        int 21h
        mov ah, 2
        mov dl, '+'
        int 21h
        mov ah, 2
        mov dl, ' '
        int 21h
        mov ah, 2
        mov dl, bl
        int 21h   
        jmp rtrn4  
        bpos2: jmp main
        ret         
step_1 endp
print proc near
    mov ah, 9
    int 21h
    ret
print endp
clear proc near
    mov ax, 3
    int 10h
    ret
clear endp
graph_bpos proc near   
    ; now since yung constant is stored sa bl we need to multiply it by 10
    ; to get the proper intervals
    sub bl, '0'
    mov ax, 10
    mul bl
    mov bl, al ;transfer the contents of al to bl
    mov bh, 0
call plane  
;; yyung cx is yung x coord
;; yung dx is yung y coord
mov al, 10;eto yung kulay
mov cx, 5
mov dx, 100
sub dx, bx ;; now the cx (160) madadagdagan ng kung ilang yung input
            ;; pag 1 magiging X 10 so 170 dapat
equation:
inc cx
int 10h
cmp cx, 315
JNE equation    
            call xandyindi
            
                mov dh, 22
                mov dl, 1
                mov bh, 0  
                mov ah, 2  
                int 10h 
          mov dx, offset pr27
          call print
          mov ch, 32 
          mov ah, 01h
          int 10h
          mov ah, 01h
          int 21h
          cmp al, 1bh
          je bpos2
          jne jump32      
    call main
graph_bpos endp
bneg2: jmp main
jump32: jmp main
graph_bneg proc near
    sub bl, '0'
    mov ax, 10
    mul bl
    mov bl, al ;transfer the contents of al to bl
    mov bh, 0
call plane  
        mov al, 10;eto yung kulay
        mov cx, 5
        mov dx, 100
        add dx, bx ;; now the cx (160) madadagdagan ng kung ilang yung input      ;; pag 1 magiging X 10 so 170 dapat
equation2:
inc cx
int 10h
cmp cx, 315
JNE equation2  
           call xandyindi 
         mov dh, 22
         mov dl, 1
         mov bh, 0  
         mov ah, 2  
         int 10h 
          mov dx, offset pr27
          call print
          mov ah, 01h
          int 21h
          cmp al, 1bh
          je bneg2
          jne jump32  
    call main 
    ret 
graph_bneg endp

graph_mnegbpos proc near  
    sub bl, '0';offset eto yung constant
    sub cl, '0'; eto nama yung slope;   ;this will dtermine number of increment
    cmp bl, cl
    je inith 
    mov bh, cl
    mov ax, 10
    mul bl
    mov bl, al ;transfer the contents of al to bl  
        call plane    
        mov al, bl 
        mov ah, 0 
        mov bl, bh 
        jmp ashe
        inith: 
        mov bh, cl
        call plane    
        mov al, bl 
        mov ah, 0 
        mov bl, bh 
        mov ax, 10
        mov cx, 160
        add cx, ax
        jmp draven          
        ashe: 
        mov cx, 160
        add cx, ax 
        draven:     
        mov bh, al         
        mov dx, 101         
        mov al, 10
        mov ah, 0ch    ;color
        ty: jmp equation3 
mnegbpos4: jmp main  
jump33: jmp main
equation3: 
mov al, bl
loop1:
dec dx
dec bl
int 10h
cmp dx, 1                                                       
jbe reinit
cmp bl, 0 
jne loop1
dec cx
cmp dx, 0 
mov bl, al
JNE equation3 
reinit:
        xchg al, bl 
        mov ah, 0
        mov al, bh
        mov ah, 0
        mov cx, 160
        add cx, ax
        mov dx, 99
        mov al, 10
        mov ah, 0ch

equation3b: 
mov al, bl
jmp loop2
graph_mnegbpos3: jmp graph_mnegbpos
loop2:
inc dx
dec bl
int 10h
cmp dx, 199                                                       
ja continue
cmp bl, 0 
jne loop2
inc cx
cmp dx, 200 
mov bl, al
JNE equation3b

continue:
        call xandyindi 
         mov dh, 22
         mov dl, 1
         mov bh, 0  
         mov ah, 2  
         int 10h 
          mov dx, offset pr27
          call print
          mov ch, 32 
          mov ah, 01h
          int 10h
          mov ah, 01h
          int 21h
          cmp al, 1bh
          je mnegbpos4
          jne jump33      
    call main 
    ret
graph_mnegbpos endp 
;; graph mposbneg 
graph_mposbneg proc near  
    sub bl, '0';offset eto yung constant
    sub cl, '0'; eto nama yung slope;   ;this will dtermine number of increment
    cmp bl, cl
    je inith1 
    mov bh, cl
    mov ax, 10
    mul bl
    mov bl, al ;transfer the contents of al to bl  
        call plane    
        mov al, bl 
        mov ah, 0 
        mov bl, bh 
        jmp ashe
        inith1: 
        mov bh, cl
        call plane    
        mov al, bl 
        mov ah, 0 
        mov bl, bh 
        mov ax, 10
        mov cx, 160
        add cx, ax
        jmp draven1          
        ashe1: 
        mov cx, 160
        add cx, ax 
        draven1:     
        mov bh, al         
        mov dx, 101         
        mov al, 10
        mov ah, 0ch  
equation4: 
mov al, bl
opsx: jmp loop3
mposbneg2: jmp main 
graph_mposbneg3: jmp graph_mposbneg 
jump34: jmp main
loop3:
dec dx
dec bl
int 10h
cmp dx, 1                                                       
jbe reinit1
cmp bl, 0 
jne loop3
inc cx
cmp dx, 320 
mov bl, al
JNE equation4 
reinit1:
        xchg al, bl 
        mov ah, 0
        mov al, bh
        mov ah, 0
        mov cx, 160
        add cx, ax
        mov dx, 99
        mov al, 10
        mov ah, 0ch
equation4b: 
mov al, bl
loop3a:
inc dx
dec bl
int 10h
cmp dx, 199                                                       
ja continue1
cmp bl, 0 
jne loop3a
dec cx
cmp dx, 0 
mov bl, al
JNE equation4b
continue1:  
        call xandyindi 
         mov dh, 22
         mov dl, 1
         mov bh, 0  
         mov ah, 2  
         int 10h 
          mov dx, offset pr27
          call print
          mov ch, 32 
          mov ah, 01h
          int 10h
          mov ah, 01h
          int 21h
          cmp al, 1bh
          je mposbneg2
          jne jump34      
    call main 
    ret
graph_mposbneg endp

graph_mnegbneg proc near  
     sub bl, '0';offset eto yung constant
    sub cl, '0'; eto nama yung slope;   ;this will dtermine number of increment
    cmp bl, cl
    je inith2 
    mov bh, cl
    mov ax, 10
    mul bl
    mov bl, al ;transfer the contents of al to bl  
        call plane    
        mov al, bl 
        mov ah, 0 
        mov bl, bh 
        jmp ashe2
        inith2: 
        mov bh, cl
        call plane    
        mov al, bl 
        mov ah, 0 
        mov bl, bh 
        mov ax, 10
        mov cx, 160
        sub cx, ax
        jmp draven2         
        ashe2: 
        mov cx, 160
        sub cx, ax 
        draven2:     
        mov bh, al         
        mov dx, 101         
        mov al, 10
        mov ah, 0ch  
equation4a: 
mov al, bl
qtpie: jmp loopxy
mnegbneg3: jmp mnegbneg
jump35: jmp main 
loopxy:
dec dx
dec bl
int 10h
cmp dx, 1                                                       
jbe reenet
cmp bl, 0 
jne loopxy
dec cx
cmp dx, 0 
mov bl, al
JNE equation4a 
reenet:
        xchg al, bl 
        mov ah, 0
        mov al, bh
        mov ah, 0
        mov cx, 160
        sub cx, ax
        mov dx, 99
        mov al, 10
        mov ah, 0ch
equation5b: 
mov al, bl
jmp loop2
loopyx:
inc dx
dec bl
int 10h
cmp dx, 199                                                       
ja continuex
cmp bl, 0 
jne loopyx
inc cx
cmp dx, 200 
mov bl, al
JNE equation5b
continuex:
           call xandyindi 
         mov dh, 22
         mov dl, 1
         mov bh, 0  
         mov ah, 2  
         int 10h 
          mov dx, offset pr27
          call print
          mov ch, 32 
          mov ah, 01h
          int 10h
          mov ah, 01h
          int 21h
          cmp al, 1bh
          je mnegbneg3
          jne jump35      
    ret
graph_mnegbneg endp

graph_mposbpos proc near  
       sub bl, '0';offset eto yung constant
    sub cl, '0'; eto nama yung slope;   ;this will dtermine number of increment
    cmp bl, cl
    je inith3 
    mov bh, cl
    mov ax, 10
    mul bl
    mov bl, al ;transfer the contents of al to bl  
        call plane    
        mov al, bl 
        mov ah, 0 
        mov bl, bh 
        jmp ashe3
        inith3: 
        mov bh, cl
        call plane    
        mov al, bl 
        mov ah, 0 
        mov bl, bh 
        mov ax, 10
        mov cx, 160
        sub cx, ax
        jmp draven3         
        ashe3: 
        mov cx, 160
        sub cx, ax 
        draven3:     
        mov bh, al         
        mov dx, 101         
        mov al, 10
        mov ah, 0ch 
equation7ab:
mov al, bl
jmp loopxyz
jump38: jmp main 
mposbpos3: jmp main 
loopxyz:
dec dx
dec bl
int 10h
cmp dx, 1                                                       
jbe reenete
cmp bl, 0 
jne loopxyz
inc cx
cmp dx, 320 
mov bl, al
JNE equation7ab 
reenete:
        xchg al, bl 
        mov ah, 0
        mov al, bh
        mov ah, 0
        mov cx, 160
        sub cx, ax
        mov dx, 99
        mov al, 10
        mov ah, 0ch
equation5bx: 
mov al, bl
loopyxxx:
inc dx
dec bl
int 10h
cmp dx, 199                                                       
ja continuexx
cmp bl, 0 
jne loopyxxx
dec cx
cmp dx, 0 
mov bl, al
JNE equation5bx
continuexx: 
         call xandyindi 
         mov dh, 22
         mov dl, 1
         mov bh, 0  
         mov ah, 2  
         int 10h 
          mov dx, offset pr27
          call print
          mov ch, 32 
          mov ah, 01h
          int 10h
          mov ah, 01h
          int 21h
          cmp al, 1bh
          je mposbpos3
          jne jump38      
    ret
graph_mposbpos endp   
plane proc near
    mov ah, 0   ; set display mode function.
    mov al, 13h ; mode 13h = 320x200 pixels, 256 colors.
    int 10h     ; set it!
   
    mov al, 15
    mov cx, 0  ;col
    mov dx, 100  ;row
    mov ah, 0ch ; put pixel   
    colcountconst:
    inc cx
    int 10h
    cmp cx, 310
    JNE colcountconst   
    mov al, 15
    mov cx, 160
    mov dx, 0
    rowcountconst:
    inc dx
    int 10h
    cmp dx, 200
    JNE rowcountconst
    ;; drawing the separators
    ;y-axis looper
    mov al, 14
    mov cx, 157  ;col
    mov dx, 10  ;row
    mov ah, 0ch ; put pixel
    reconst:
    mov cx, 157  
    sepconst:
    inc cx
    int 10h
    cmp cx, 162
    JNE sepconst
    add dx, 10
    cmp dx, 200
    JNE reconst  
    ;; horizontal
    mov al, 14
    mov cx, 10 
    mov dx, 97              
    rexconst:
    mov dx, 97
    sep2const:
    inc dx
    int 10h
    cmp dx, 102
    JNE sep2const
    add cx, 10
    cmp cx, 320
    JNE rexconst
    ret
plane endp 

xandyindi proc near
    
mov dh, 11
mov dl, 1  
mov ah, 2 
mov bh, 0 
int 10h 
mov dx, offset x
mov ah, 9
int 21h  
mov dh, 1
mov dl, 20
mov ah, 2
mov bh, 0   
int 10h 
mov dx, offset y
mov ah, 9
int 21h 

ret
xandyindi endp 	
		
linear	proc near
		mov ax, 3
		int 10h

		mov ah, 2
		mov dl, 22
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 29
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 32
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset pix3
		mov bl, 05dh
		mov cx, 3
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 36
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 39
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset pix5
		mov bl, 05dh
		mov cx, 5
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 46
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset pix4
		mov bl, 05dh
		mov cx, 4
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 52
		mov dh, 1
		int 10h

		mov ah, 9
		mov dx, offset pix5
		mov bl, 05dh
		mov cx, 5
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 22
		mov dh, 2
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 29
		mov dh, 2
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 32
		mov dh, 2
		int 10h

		mov ah, 9
		mov dx, offset pix6
		mov bl, 05dh
		mov cx, 6
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 39
		mov dh, 2
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 45
		mov dh, 2
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 49
		mov dh, 2
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 52
		mov dh, 2
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 56
		mov dh, 2
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 22
		mov dh, 3
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 29
		mov dh, 3
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 32
		mov dh, 3
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 35
		mov dh, 3
		int 10h

		mov ah, 9
		mov dx, offset pix3
		mov bl, 05dh
		mov cx, 3
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 39
		mov dh, 3
		int 10h

		mov ah, 9
		mov dx, offset pix4
		mov bl, 05dh
		mov cx, 4
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 45
		mov dh, 3
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 49
		mov dh, 3
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 52
		mov dh, 3
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 56
		mov dh, 3
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 22
		mov dh, 4
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 29
		mov dh, 4
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 32
		mov dh, 4
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 36
		mov dh, 4
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 39
		mov dh, 4
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 45
		mov dh, 4
		int 10h

		mov ah, 9
		mov dx, offset pix6
		mov bl, 05dh
		mov cx, 6
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 52
		mov dh, 4
		int 10h

		mov ah, 9
		mov dx, offset pix5
		mov bl, 05dh
		mov cx, 5
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 22
		mov dh, 5
		int 10h

		mov ah, 9
		mov dx, offset pix6
		mov bl, 05dh
		mov cx, 6
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 29
		mov dh, 5
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 32
		mov dh, 5
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 36
		mov dh, 5
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 39
		mov dh, 5
		int 10h

		mov ah, 9
		mov dx, offset pix5
		mov bl, 05dh
		mov cx, 5
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 45
		mov dh, 5
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 49
		mov dh, 5
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 52
		mov dh, 5
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 56
		mov dh, 5
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 15
		mov dh, 7
		int 10h

		mov ah, 9
		mov dx, offset pix5
		mov bl, 05dh
		mov cx, 5
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 22
		mov dh, 7
		int 10h

		mov ah, 9
		mov dx, offset pix4
		mov bl, 05dh
		mov cx, 4
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 28
		mov dh, 7
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 32
		mov dh, 7
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 36
		mov dh, 7
		int 10h

		mov ah, 9
		mov dx, offset pix4
		mov bl, 05dh
		mov cx, 4
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 42
		mov dh, 7
		int 10h

		mov ah, 9
		mov dx, offset pix6
		mov bl, 05dh
		mov cx, 6
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 49
		mov dh, 7
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 53
		mov dh, 7
		int 10h

		mov ah, 9
		mov dx, offset pix4
		mov bl, 05dh
		mov cx, 4
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 59
		mov dh, 7
		int 10h

		mov ah, 9
		mov dx, offset pix3
		mov bl, 05dh
		mov cx, 3
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 63
		mov dh, 7
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 15
		mov dh, 8
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 21
		mov dh, 8
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 25
		mov dh, 8
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 28
		mov dh, 8
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 32
		mov dh, 8
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 35
		mov dh, 8
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 39
		mov dh, 8
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 44
		mov dh, 8
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 49
		mov dh, 8
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 52
		mov dh, 8
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 56
		mov dh, 8
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 59
		mov dh, 8
		int 10h

		mov ah, 9
		mov dx, offset pix6
		mov bl, 05dh
		mov cx, 6
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 15
		mov dh, 9
		int 10h

		mov ah, 9
		mov dx, offset pix4
		mov bl, 05dh
		mov cx, 4
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 21
		mov dh, 9
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 25
		mov dh, 9
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 28
		mov dh, 9
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 32
		mov dh, 9
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 35
		mov dh, 9
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 39
		mov dh, 9
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 44
		mov dh, 9
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 49
		mov dh, 9
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 52
		mov dh, 9
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 56
		mov dh, 9
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 59
		mov dh, 9
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 62
		mov dh, 9
		int 10h

		mov ah, 9
		mov dx, offset pix3
		mov bl, 05dh
		mov cx, 3
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 15
		mov dh, 10
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 21
		mov dh, 10
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 24
		mov dh, 10
		int 10h

		mov ah, 9
		mov dx, offset pix3
		mov bl, 05dh
		mov cx, 3
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 28
		mov dh, 10
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 32
		mov dh, 10
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 35
		mov dh, 10
		int 10h

		mov ah, 9
		mov dx, offset pix6
		mov bl, 05dh
		mov cx, 6
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 44
		mov dh, 10
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 49
		mov dh, 10
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 52
		mov dh, 10
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 56
		mov dh, 10
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 59
		mov dh, 10
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 63
		mov dh, 10
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 15
		mov dh, 11
		int 10h

		mov ah, 9
		mov dx, offset pix5
		mov bl, 05dh
		mov cx, 5
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 22
		mov dh, 11
		int 10h

		mov ah, 9
		mov dx, offset pix5
		mov bl, 05dh
		mov cx, 5
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 29
		mov dh, 11
		int 10h

		mov ah, 9
		mov dx, offset pix4
		mov bl, 05dh
		mov cx, 4
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 35
		mov dh, 11
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 39
		mov dh, 11
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 44
		mov dh, 11
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 49
		mov dh, 11
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 53
		mov dh, 11
		int 10h

		mov ah, 9
		mov dx, offset pix4
		mov bl, 05dh
		mov cx, 4
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 59
		mov dh, 11
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 63
		mov dh, 11
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 17
		mov dh, 13
		int 10h

		mov ah, 9
		mov dx, offset pix5
		mov bl, 05dh
		mov cx, 5
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 24
		mov dh, 13
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 31
		mov dh, 13
		int 10h

		mov ah, 9
		mov dx, offset pix4
		mov bl, 05dh
		mov cx, 4
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 37
		mov dh, 13
		int 10h

		mov ah, 9
		mov dx, offset pix6
		mov bl, 05dh
		mov cx, 6
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 44
		mov dh, 13
		int 10h

		mov ah, 9
		mov dx, offset pix6
		mov bl, 05dh
		mov cx, 6
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 51
		mov dh, 13
		int 10h

		mov ah, 9
		mov dx, offset pix5
		mov bl, 05dh
		mov cx, 5
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 57
		mov dh, 13
		int 10h

		mov ah, 9
		mov dx, offset pix5
		mov bl, 05dh
		mov cx, 5
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 17
		mov dh, 14
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 21
		mov dh, 14
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 24
		mov dh, 14
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 30
		mov dh, 14
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 34
		mov dh, 14
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 39
		mov dh, 14
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 46
		mov dh, 14
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 51
		mov dh, 14
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 57
		mov dh, 14
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 61
		mov dh, 14
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 17
		mov dh, 15
		int 10h

		mov ah, 9
		mov dx, offset pix5
		mov bl, 05dh
		mov cx, 5
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 24
		mov dh, 15
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 30
		mov dh, 15
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 34
		mov dh, 15
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 39
		mov dh, 15
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 46
		mov dh, 15
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 51
		mov dh, 15
		int 10h

		mov ah, 9
		mov dx, offset pix4
		mov bl, 05dh
		mov cx, 4
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 57
		mov dh, 15
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 61
		mov dh, 15
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 17
		mov dh, 16
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 24
		mov dh, 16
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 30
		mov dh, 16
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 34
		mov dh, 16
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 39
		mov dh, 16
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 46
		mov dh, 16
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 51
		mov dh, 16
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 57
		mov dh, 16
		int 10h

		mov ah, 9
		mov dx, offset pix5
		mov bl, 05dh
		mov cx, 5
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 17
		mov dh, 17
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 24
		mov dh, 17
		int 10h

		mov ah, 9
		mov dx, offset pix5
		mov bl, 05dh
		mov cx, 5
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 31
		mov dh, 17
		int 10h

		mov ah, 9
		mov dx, offset pix4
		mov bl, 05dh
		mov cx, 4
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 39
		mov dh, 17
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 46
		mov dh, 17
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 51
		mov dh, 17
		int 10h

		mov ah, 9
		mov dx, offset pix5
		mov bl, 05dh
		mov cx, 5
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 57
		mov dh, 17
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 61
		mov dh, 17
		int 10h

		mov ah, 9
		mov dx, offset pix2
		mov bl, 05dh
		mov cx, 2
		int 10h
		int 21h
		
		mov ah, 2
		mov dl, 27
		mov dh, 20
		int 10h

		mov ah, 9
		mov dx, offset begin
		mov bl, 08Fh
		mov cx, 28
		int 10h
		int 21h
		
		ret
linear	endp
end start     
