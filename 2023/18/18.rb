# rubocop:disable Metrics
#
require 'set'

input = File.open('input').read
instructions = input.split("\n").map(&:split)

def move(x, y, dir, length)
  case dir
  when 'U' then y += length
  when 'D' then y -= length
  when 'L' then x -= length
  when 'R' then x += length
  end
  [x, y]
end

def direction_groups(instructions)
  (instructions.map(&:first).flatten.join * 3)
    .slice(instructions.length - 1, instructions.length + 3)
    .chars.each_cons(3).map(&:join)
end

def find_area(instructions, directions)
  x = 0
  y = 0
  trench = []

  instructions.zip(directions).each do |((dir, length_s, _hex), group)|
    length = length_s.to_i
    case group
    when /URD|DLU/
      length += 1
    when /ULD|DRU/
      length -= 1
    when /RDL|LUR/
      length += 1
    when /LDR|RUL/
      length -= 1
    end
    nx, ny = move(x, y, dir, length)
    trench << [nx, ny]
    x = nx
    y = ny
  end

  # Shoelace formula
  # # A = 0.5 * |(x1*y2 - x2*y1) + (x2*y3 - x3*y2) + ... + (xn*y1 - x1*yn)|
  trench.each_cons(2).reduce(0) { |sum, ((x1, y1), (x2, y2))| sum + (x1 * y2 - x2 * y1) }.abs / 2
end

directions = direction_groups(instructions)
p find_area(instructions, directions)

key = { '0' => 'R', '1' => 'D', '2' => 'L', '3' => 'U' }

new_instructions = instructions.map { |l| l[2].match(/\(#(.*)\)/)[1] }
  .map { |code| [key[code[-1]], code[...-1].to_i(16)] }
new_directions = direction_groups(new_instructions)
p find_area(new_instructions, new_directions)
