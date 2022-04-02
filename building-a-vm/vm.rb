# Registers
PC = 0x00
R1 = 0x01
R2 = 0x02

# Instructions
LOADW  = 0x01
STOREW = 0x02
ADD    = 0x03
SUB    = 0x04
HALT   = 0xff

def load_word(registers, memory, reg, addr)
  registers[reg] = memory[addr] + (memory[addr + 1] * 256)
  registers[PC] += 3
end

def store_word(registers, memory, reg, addr)
  first_byte = registers[reg] % 256
  second_byte = registers[reg] / 256

  memory[addr] = first_byte
  memory[addr + 1] = second_byte
  registers[PC] += 3
end

def add(registers, reg1, reg2)
  registers[reg1] += registers[reg2]
  registers[PC] += 3
end

def sub(registers, reg1, reg2)
  registers[reg1] -= registers[reg2]
  registers[PC] += 3
end

def halt
  exit 0
end

def vm(registers, memory)
  while memory[registers[PC]] != HALT
    instruction = memory[registers[PC]]
    case instruction
    when 0x01
      load_word(registers, memory, memory[registers[PC] + 1], memory[registers[PC] + 2])
    when 0x02
      store_word(registers, memory, memory[registers[PC] + 1], memory[registers[PC] + 2])
    when 0x03
      add(registers, memory[registers[PC] + 1], memory[registers[PC] + 2])
    when 0x04
      sub(registers, memory[registers[PC] + 1], memory[registers[PC] + 2])
    end
  end

  print "#{memory}\n"
  # puts registers

  halt
end

registers = [
  0, # program counter
  0, # general-purpose register 1
  0  # general-purpose register 2
]

memory = [
  LOADW, R1, 0x10,
  LOADW, R2, 0x12,
  ADD, R1, R2,
  STOREW, R1, 0x0e,
  HALT,
  0x00,
  0x00, 0x00,
  0xa1, 0x14,
  0x0c, 0x00
]

vm(registers, memory)
