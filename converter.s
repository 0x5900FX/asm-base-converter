.intel_syntax noprefix
.text
.global main
main:
    mov %rbp, %rsp #for correct debugging
   

   call read_str
   
   lea rdi ,[welcome_usr]
   call print_str
   
   ;# lea rdi ,[user_inp]
   ;#  call print_str
   
   lea rdi , [user_inp]
   call str_len
   
   mov rcx , rax
   lea rsi , [user_inp]
   
   call ston
   mov  [number] , rax
   
    mov rdi , [number]
      call print_int
   
    call newline_   
   
   mov rdi , [number]
      call print_bin
   
   mov rdi , [number]
   
   call print_hex
   
   call exit
  
   
   
   
   
  
   
   
   read_str:
    mov rax , 0
    mov rdi , 0
    lea rsi , [user_inp]
    lea rdx , [u_len]
    syscall
    mov byte ptr [user_inp + rax ] , 0
    ret 
    
    
      print_str:
        push rdi
        call str_len
        pop rdi
        
        mov rdx, rax
        mov rsi , rdi
        
        mov rax , 1
        mov rdi , 1
        
        syscall 
        ret
    
    str_len:
        xor rcx,rcx
        mov rsi ,rdi
        
        str_len.loop:
        mov bl , [rsi]
        cmp bl , 0
        je str_len.exit
        inc rsi
        inc rcx
        jmp str_len.loop
        
        str_len.exit:
        mov rax, rcx
        ret
        
    ston:
        push rbx
        xor rax , rax 
        xor rbx , rbx
        
        ston.loop:
        cmp rcx , 0
        jle ston.done
        movzx rbx , byte ptr [rsi]
        cmp bl , '0'
        jb ston.done
        cmp bl , '9'
        ja ston.done
        imul rax , rax , 10
        sub bl , '0'
        add rax , rbx
        inc rsi
        dec rcx
        jmp ston.loop
        
        ston.done:
        pop rbx
        ret
    
    print_int:
        mov rax , rdi
        lea rsi , [int_buffer + 20]
        mov byte ptr [rsi] , 0
        mov rcx , 10
        mov rbx , rsi
        
        cmp rax , 0
        jne print_int.loop
        
        mov byte ptr [rsi -1 ] ,'0'
        lea rdi , [rsi -1]
        call print_str
        ret
        
        
        print_int.loop:
        xor rdx , rdx
        div rcx
        add dl , '0'
        dec rsi
        mov [rsi] , dl
        cmp rax , 0
        jnz print_int.loop
        
        mov rdi , rsi
        call print_str
        call newline_
        ret
                
    print_bin:
        mov rax , rdi
        lea rsi , [int_buffer + 20]
        mov byte ptr [rsi] , 0
        mov rcx , 2
        mov rbx , rsi
        
        cmp rax , 0
        jne print_int.loop
        
        mov byte ptr [rsi -1 ] ,'0'
        lea rdi , [rsi -1]
        call print_str
        call newline_
        ret
        
        
        print_bin.loop:
        xor rdx , rdx
        div rcx
        add dl , '0'
        dec rsi
        mov [rsi] , dl
        cmp rax , 0
        jnz print_bin.loop
        
        mov rdi , rsi
        call print_str
        ret
    
      print_hex:
        mov rax , rdi
        lea rsi , [int_buffer + 20]
        mov byte ptr [rsi] , 0
        mov rcx , 16
        mov rbx , rsi
        
        cmp rax , 0
        jne print_hex.loop
        
        mov byte ptr [rsi -1 ] ,'0'
        lea rdi , [rsi -1]
        call print_str
        ret
        
        
        print_hex.loop:
        xor rdx , rdx
        div rcx
        
        cmp rdx , 9
        jg cont
        
        add dl , '0'
        jmp store_char
        
        cont:
            add dl , 'A' - 10
    
       store_char:    
        dec rsi
        mov [rsi] , dl
        cmp rax , 0
        jnz print_hex.loop
        
        mov rdi , rsi
        call print_str
        call newline_
        ret
    
    newline_:
        mov rax , 1
        mov rdi , 1
        lea rsi , [newline]
        mov rdx , 1
        syscall 
        ret

    
  exit:
   mov rax , 60
   xor rdi , rdi
   syscall  
   
 .data
 user_inp: .skip 128 
 u_len = . - user_inp
 
 welcome_usr: .asciz "Hello user. Enter no from 1-225\n"
 wel_len = . - welcome_usr
 
 number: .quad 0
 
 int_buffer: .skip 1080
 
 newline: .byte '\n'
 