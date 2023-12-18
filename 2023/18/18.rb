# frozen_string_literal: true

require 'set'

input = File.open('input').read
instructions = input.split("\n").map(&:split)

def move(x, y, dir)
  case dir
  when 'U' then y += 1
  when 'D' then y -= 1
  when 'L' then x -= 1
  when 'R' then x += 1
  end
  [x, y]
end

trench = Set.new
x = 0
y = 0

instructions.each do |inst|
  inst[1].to_i.times do
    trench << [x, y]
    x, y = move(x, y, inst[0])
  end
end

lagoon = Set.new

(x_min, x_max), (y_min, y_max) = trench.to_a.transpose.map(&:minmax)

y_max.downto(y_min) do |y|
  inside = false
  edge = ''
  x_min.upto(x_max) do |x|
    if trench.include?([x, y])
      print '#'
      if (trench.include?([x, y - 1]) && trench.include?([x, y + 1])) ||
         (trench.include?([x - 1, y]) && trench.include?([x, y + 1])) && edge == 'top' ||
         (trench.include?([x - 1, y]) && trench.include?([x, y - 1]) && edge == 'bottom')
        inside = !inside
        edge = ''
      elsif trench.include?([x, y - 1]) && trench.include?([x + 1, y])
        edge = 'top'
      elsif trench.include?([x, y + 1]) && trench.include?([x + 1, y])
        edge = 'bottom'
      end
    elsif inside
      print '.'
      lagoon << [x, y]
    else
      print ' '
    end
  end
  print "\n"
end

p trench.size
p lagoon.size
p trench.size + lagoon.size
