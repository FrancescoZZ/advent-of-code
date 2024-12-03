# frozen_string_literal: true

input = File.open('input').read
left, right = input.split("\n").map(&:split).transpose
left_sorted = left.map(&:to_i).sort
right_sorted = right.map(&:to_i).sort

part_one = [left_sorted, right_sorted].transpose.map { |(l, r)| (l - r).abs }.sum
puts part_one

appearances = {}
similarity = 0

left.each do |l|
  appearances[l] = right.count(l) unless appearances.key?(l)
  similarity += l.to_i * appearances[l]
end

puts similarity
