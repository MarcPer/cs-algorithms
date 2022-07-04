class Stack
  def initialize
    @arr = []
  end

  def <<(x)
    @arr << x
  end

  def pop
    @arr.pop
  end

  def empty?
    @arr.empty?
  end
end

Bracket = Struct.new(:val, :idx)

OPEN_BRACKETS = %w"[ ( {"
CLOSE_BRACKETS = %w"] ) }"

def open_bracket?(char)
  OPEN_BRACKETS.include?(char)
end

def close_bracket?(char)
  CLOSE_BRACKETS.include?(char)
end

def matching_brackets?(lh, rh)
  open_idx = OPEN_BRACKETS.index(lh)
  return false unless open_idx

  close_idx = CLOSE_BRACKETS.index(rh)
  return false unless close_idx

  open_idx == close_idx
end

def parse(str)
  s = Stack.new
  str.each_char.with_index do |ch, i|
    s << Bracket.new(ch,i) if open_bracket?(ch)
    if close_bracket?(ch)
      b = s.pop
      return i+1 if b.nil? || !matching_brackets?(b.val, ch)
    end
  end
  s.empty? ? true : s.pop.idx+1
end


if $0 == __FILE__
  valid = parse(gets.strip)
  valid.is_a?(TrueClass) ? puts("Success") : puts(valid)
end

