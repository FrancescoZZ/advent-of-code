# frozen_string_literal: true

require 'set'

# data = File.open('input').read.split("\n")
data = File.open('input').read.split("\n").map(&:chars)

# N = 10
def distance((ar, ac), (br, bc))
  (ar - br).abs + (ac - bc).abs
end

def sum_of_distances(map, exp)
  expanded = map.flat_map { |row| row.all?('.') ? [row] * exp : [row] }
                .transpose
                .flat_map { |col| col.all?('.') ? [col] * exp : [col] }
                .transpose
  cols = expanded.first.length

  flat = expanded.flatten
  galaxies = flat.each_index
                 .select { |i| flat[i] == '#' }
                 .map { |i| i.divmod(cols) }

  steps = 0
  galaxies.each_with_index do |galaxy, i|
    galaxies[i + 1..].each do |other|
      steps += distance(galaxy, other)
    end
  end

  steps
end

part_one = sum_of_distances(data, 2)
p part_one

base = sum_of_distances(data, 1)
increase = part_one - base
p base + (increase * (1_000_000 - 1))
