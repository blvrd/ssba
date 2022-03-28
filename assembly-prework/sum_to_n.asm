section .text
global sum_to_n
sum_to_n:
  xor rax, rax ; make sure rax is 0
  mov rcx, rdi ; get the argument `n` from the rdi register, put it in rcx
sum_loop:
  add rax, rcx ; add the current value of rcx to rax
  dec rcx      ; decrement rcx
  jge sum_loop ; execute the loop again if the last comparison was >= 0 (stored in the flags register)
  ret
