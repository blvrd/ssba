section .text
global sum_to_n
sum_to_n:
  mov rax, rdi ; get the argument `n` from the rdi register, put it in rax
  add rax, 1   ; add 1 to rax
  mul rdi      ; multiply rax by the original argument for `n`
  shr rax, 1   ; shift rax right by one bit to divide by two (this blew my mind)
  ret
