.model small
stack 100h
.data
        message     db      "Input your string:", 0Dh, 0Ah, '$'
        buffer      db      100
                    db      0
                    db      101 DUP(0)
        perehod     db      0Dh, 0Ah, '$'
        number_buffer       db      '0000'
             
.code
start:
        mov     ax, @data
        mov     ds, ax
        
        mov     ah, 9
        mov     dx, offset message
        int     21h
        
        mov     ah, 0Ah
        mov     dx, offset buffer
        int     21h
        
        xor     cx,cx
        mov     cl, [buffer + 1] ; length of string
        xor     al,al
        add     dx, 2
        xor     si,si
        
        
loop_str:
        cmp     si, cx
        jge      loop_end
        mov     bl,[buffer + si + 2]
        cmp     bl, 41h
        je      count_a
        
        cmp     bl, 61h
        je      count_a
        
        inc     si

count_a:
        inc     al
        inc     si
        jmp     loop_str

loop_end:
        xor     cx, cx
        mov     bl, 10
        
diving_loop:
        cmp     ax, 0
        je      print_loop
        
        div     bl
        add     ah, '0'
        push    ax
        mov     ah, 0
        inc     cx
        jmp     diving_loop

print_loop:
        cmp     cx, 0
        je      end_program
        mov     ah, 2
        pop     dx
        int     21h
        dec     cx
        jmp     print_loop
        
        
end_program:        
        mov     ah, 4Ch
        int     21h
end start
        
        
        
        
        
        
        
        
        
        