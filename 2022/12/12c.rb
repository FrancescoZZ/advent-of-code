# frozen_string_literal: true

require 'set'

data = File.open('input').read
width = data.index("\n")
grid = data.gsub("\n", '')
coords = ->(i) { Complex(*i.divmod(width)) }
grid_hash = {}
grid.each_char.with_index { |char, i| grid_hash[coords.call(i)] = char }
elevation = ->(c) { (grid_hash[c] || 'Z').sub('E', '{').sub('S', '`').ord }
root = coords.call(grid_hash.values.index('E'))

%w[S Sa].each do |target|
  queue = [[root, 0]]
  explored = Set.new([root])

  while queue.any?
    old, steps = queue.shift
    if target.include? grid_hash[old]
      puts steps
      break
    end

    [old + 1, old - 1, old + 1i, old - 1i].each do |new|
      next if explored.include?(new) || elevation.call(old) - elevation.call(new) > 1

      queue << [new, steps + 1]
      explored.add(new)
    end
  end
end
