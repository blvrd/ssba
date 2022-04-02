# Registers
PC = 0x00 # program counter
R1 = 0x01 # general-purpose register 1
R2 = 0x02 # general-purpose register 2

# Instructions
LOADW  = 0x01
STOREW = 0x02
ADD    = 0x03
SUB    = 0x04
MUL    = 0x05
DIV    = 0x06
ADDIMM = 0x07
SHR    = 0x08
HALT   = 0xff

# Memory addresses
OUTPUT_OFFSET = 0x0e
INPUT1_OFFSET = 0x10
INPUT2_OFFSET = 0x12

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

def add_imm(registers, reg, imm)
  registers[reg] += imm
  registers[PC] += 3
end

def sub(registers, reg1, reg2)
  registers[reg1] -= registers[reg2]
  registers[PC] += 3
end

def shift_right(registers, reg, imm)
  registers[reg] = registers[reg] >> imm
  registers[PC] += 3
end

def halt
  exit 0
end

def vm(registers, memory)
  while memory[registers[PC]] != HALT
    instruction = memory[registers[PC]]
    op1         = memory[registers[PC] + 1]
    op2         = memory[registers[PC] + 2]

    case instruction
    when 0x01
      load_word(registers, memory, op1, op2)
    when 0x02
      store_word(registers, memory, op1, op2)
    when 0x03
      add(registers, op1, op2)
    when 0x04
      sub(registers, op1, op2)
    when 0x07
      add_imm(registers, op1, op2)
    when 0x08
      shift_right(registers, op1, op2)
    else
      puts "Can't execute instruction: 0x#{instruction.to_s(16)}"
      exit 1
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
  LOADW, R1, INPUT1_OFFSET,
  LOADW, R2, INPUT2_OFFSET,
  ADDIMM, R1, 5,
  STOREW, R1, OUTPUT_OFFSET,
  HALT,
  0x00,  # not used
  0, 0,  # ouput
  25, 0, # input 1
  5, 0   # input 2
]

vm(registers, memory)
