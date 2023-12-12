# frozen_string_literal: true

# rubocop:disable Metrics

input = File.open('input').read

schematic = input.split("\n")
                 .map { |l| l.split.each_with_index.map { |p, i| i == 1 ? p.split(',').map(&:to_i) : p } }

count = 0

schematic.each do |str, groups|
  ['.', '#'].repeated_permutation(str.count('?')).to_a.each do |comb|
    new_str = str.dup
    comb.length.times { new_str.sub!('?', comb.shift) }
    count += 1 if new_str.split('.').reject(&:empty?).map(&:length) == groups
  end
end

p count

# p schematic

# unfolded = schematic.map do |(str, groups)|
#   [str.concat('?'.concat(str) * 4), groups * 5]
# end

# count = 0

# unfolded.each do |str, groups|
#   p str
#   ['.', '#'].repeated_permutation(str.count('?')).to_a.each do |comb|
#     new_str = str.dup
#     comb.length.times { new_str.sub!('?', comb.shift) }
#     count += 1 if new_str.split('.').reject(&:empty?).map(&:length) == groups
#   end
# end

# p count
