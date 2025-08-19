.model small
stack 100h

.data
    input_str   db      "Input your string: ", 0Dh, 0Ah, '$'
    buffer      db      100
                db      0
                db      101 DUP(0)
    buffer_out  db      101 DUP(0)

.code
start:
        mov     ax, @data
        mov     ds, ax
        mov     es, ax
        
        ; ??????? ???????????
        mov     ah, 9
        lea     dx, input_str
        int     21h
        
        ; ???? ??????
        mov     ah, 0Ah
        mov     dx, offset buffer
        int     21h
        
        ; ??????? ?????? ????? ?????
        mov     ah, 02h
        mov     dl, 0Dh
        int     21h
        mov     dl, 0Ah
        int     21h
        
        lea     si, [buffer + 2]      
        mov     cl, [buffer + 1]      
        lea     di, [buffer_out]      
        xor     bx, bx
        mov     bx, 1
        cld
        
next_char:
        lodsb                         
        cmp     al, 0Dh               
        je      end_prog

        cmp     al, ' '
        je      new_word

        
        test    bl, 1
        jz      copy_char
        jmp     next_char

copy_char:
        stosb                         
        jmp     next_char

new_word:
        test    bl, 1
        jz      add_space
        jmp     skip_space
add_space:
        mov     al, ' '
        stosb
skip_space:
        inc     bl
        jmp next_char

end_prog:
        mov     al, '$'
        stosb                         
        
        mov     ah, 9
        mov     dx, offset buffer_out
        int     21h
        
        mov     ah, 4Ch
        int     21h
end start
