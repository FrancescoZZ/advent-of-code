# frozen_string_literal: true

require 'set'

input = File.open('input').read.split("\n").map(&:chars)
COLS = input.first.length
ROWS = input.length
NWSE = [[-1, 0], [0, -1], [1, 0], [0, 1]]

SQUARES, circles = input.flatten
                        .each_with_index
                        .each_with_object([Set.new, Set.new]) do |(c, i), arr|
  arr.first << i.divmod(COLS) if c == '#'
  arr.last << i.divmod(COLS) if c == 'O'
end

def tilt(circle, circles, (dr, dc))
  until SQUARES.include?(circle) || circles.include?(circle) || circle.any?(&:negative?) || circle.first >= ROWS || circle.last >= COLS
    circle[0] += dr
    circle[1] += dc
  end
  circle[0] -= dr
  circle[1] -= dc
  circle
end

sequences = {}
repeating = []
1_000_000_000.times do |i|
  sequence = []
  NWSE.each do |dir|
    sign = dir.reject(&:zero?).first
    circles.to_a
           .sort { |(aa, ab), (ba, bb)| aa == ba ? sign * (bb - ab) : sign * (ba - aa) }
           .each do |circle|
      circles.delete(circle)
      circles << tilt(circle, circles, dir)
    end
    sequence << circles.to_a.reduce(0) { |load, (r, _c)| load + ROWS - r }
  end
  puts sequence.first if i.zero?
  if sequences.key? sequence
    repeating = [sequence, i + 1]
    break
  end
  sequences[sequence] = i + 1
end

cycle_start = sequences[repeating.first]
period = repeating.last - cycle_start
puts sequences.invert[((1_000_000_000 - cycle_start) % period) + cycle_start].last
