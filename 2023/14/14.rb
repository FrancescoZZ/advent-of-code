# frozen_string_literal: true

require 'set'

input = File.open('input').read.split("\n").map(&:chars)
COLS = input.first.length
ROWS = input.length

SQUARES, CIRCLES = input.flatten
                        .each_with_index
                        .each_with_object([Set.new, []]) do |(c, i), arr|
  arr.first.add(i.divmod(COLS)) if c == '#'
  arr.last << i.divmod(COLS) if c == 'O'
end

def tilt(circle, new_circles)
  circle[0] -= 1 until SQUARES.include?(circle) || new_circles.include?(circle) || circle.first.negative?
  circle[0] += 1
  circle
end

tilted = CIRCLES.each_with_object(Set.new) do |circle, new_circles|
  new_circles << tilt(circle, new_circles)
end

p tilted.to_a.reduce(0) { |load, (r, _c)| load + ROWS - r }
