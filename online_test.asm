org 100h 
       
      Questions dw '2+2= 1)4 2)5 3)6 4)7?2+3= 1)4 2)5 3)6 4)7?2+4= 1)4 2)5 3)6 4)7?2+5= 1)4 2)5 3)6 4)7?*' 
 
      true_ans db '1234' 
      score db 00h   
       
      mov ax, 00h 
      mov si, 00h                      ; baraye peymayesh roye soalat 
      mov di, 00h                      ; baraye peymayesh roye javab haye sahih 
      
      L: 
       mov ah, 02h                      
       mov dx, Questions[si]           ; namayeshe character haye har soal 
        
       cmp dl, '*' 
       jz Final_PRINT                  ; check kardane payane soalat 
        
       cmp dl, '?'                     ; check kardane payane yek soal 
       jnz PRINT                       ; be payane yek soal naresideim va bayad namayeshe char ra edame bedim 
       jmp INPUT                       ; agar ? bood pasokhe user ra daryaft mikonim 
        
       PRINT:    
        int 21h                        ; har char ra chap mikonad 
        inc si                         ; index charactere soalat ra update mikonad 
        JMP L                           
                 
         
       INPUT:         
        call new_line 
             
        mov al, 0                      ; yek char as user daryaft mikonad 
        mov ah, 01h 
        int 21h         
         
         
        cmp al, true_ans[di]           ; char gerefte shode ra ba javabe sahih moghayese mikonad 
        call new_line 
         
        jz scores                      ; agar javabe user dorost bood be labele scores miravad va score ash ra yek vahed ezafe mikonad 
         
        inc di                          
        inc si 
         
         
         
        JMP L                          ; dar in 3 line index haye di , si ra ezafe mikonim va be labele L miravim 
                                       
       scores: 
        inc di                         ; baraye mohasebeye score nahayi yek vahed variable score ra ezafe mikonim 
        inc si 
        inc score 
        JMP L   
         
        
      Final_PRINT:                     ; print score nahayi 
         
      mov ax, 00h  
      mov ah, 09h   
      mov al, '*'  
      mov bl, 14  
      mov bh, 00  
      mov cx, 20  
      int 10h 
       
      call new_line 
       
      msg db ' "Your Score Is:" $' 
      mov ah, 09h 
      lea dx, msg 
      int 21h 
       
      mov ah, 02h 
      add score, 48 
      mov dl, score 
      int 21h 
         
      mov ax,0x4c00 
      int 0x21  
       
       
      new_line proc   
         
         mov ah, 02h                    ; chape new line 
         mov dl, 0Ah                     
         int 21h 
         
         mov ah, 02h                    ; be ebtedaye khat miravad 
         mov dl, 0Dh 
         int 21h 
          
      new_line endp     
     
      
ret

