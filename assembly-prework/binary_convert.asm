section .text
global binary_convert
binary_convert:
  xor rax, rax
convert_loop:
  movzx rsi, byte [rdi] ; read one byte/ascii character into the rsi register
  inc rdi               ; increment the address to point to the next character

  cmp rsi, 0x0
  je end

  ; only accept ascii '0' or '1'
  cmp rsi, 48
  jl error

  cmp rsi, 49
  jg error

  shr rsi, 1            ; right shift the rsi register, moving the highest-order bit (I think) to the carry flag

  ; This is where the magic starts, and my understanding stops

  rcl rax, 1            ; left shift rax by one bit, moving the carry flag into the least significant bit
  ja convert_loop       ; loop again if the carry flag is 0

  shr rax, 1            ; noticed that the answers were two times large than the expected values, so shifted right by one to divide by two
error:
  mov rax, -1           ; probably not a great error code since we may actually want to handle negative numbers
end:
	ret
