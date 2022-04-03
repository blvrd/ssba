Token = Struct.new(:kind, :value)

class Tokenizer
  def initialize(program_string)
    @program_string = program_string
    @current        = -1
    @tokens         = []
  end

  def eof?
    @current == @program_string.length - 1
  end

  def scan_tokens
    while !eof?
      @tokens << scan_token
    end

    @tokens
  end

  def advance!
    @current += 1
    @program_string[@current]
  end

  # Look ahead by n characters
  def look_ahead(n)
    @program_string[@current + n]
  end

  def scan_token
    char = advance!

    case char
    when /[0-9]/
      value = char

      while ((next_char = look_ahead(1)) =~ /[0-9]/) do
        value.concat(next_char)
        advance!
      end

      Token.new("NUMBER", value)
    when "+"
      Token.new("PLUS", char)
    when "-"
      Token.new("MINUS", char)
    when "*"
      Token.new("MULTIPLY", char)
    when "/"
      Token.new("DIVIDE", char)
    when "("
      Token.new("LEFT_PAREN", char)
    when ")"
      Token.new("RIGHT_PAREN", char)
    when /\s/
      Token.new("WHITESPACE", char)
    end
  end
end

tokens = Tokenizer.new("123 - (2+37) / 2").scan_tokens

pp tokens
